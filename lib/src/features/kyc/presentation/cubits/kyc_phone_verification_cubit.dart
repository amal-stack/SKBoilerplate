import 'package:boilerplate/src/features/kyc/domain/repositories/kyc_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class KycVerificationStep {
  const KycVerificationStep();

  bool get isValid;
}

class PhoneEntryStep extends KycVerificationStep {
  PhoneEntryStep({String phoneNumber = '', String countryCode = ''})
    : this.fromInput(
        PhoneNumberInput(phoneNumber: phoneNumber, countryCode: countryCode),
      );

  const PhoneEntryStep.fromInput(this.input);

  static const PhoneEntryStep empty = PhoneEntryStep.fromInput(
    PhoneNumberInput.empty,
  );

  final PhoneNumberInput input;

  PhoneEntryStep withCountryCode(String countryCode) =>
      withInput(input.withCountryCode(countryCode));

  PhoneEntryStep withPhoneNumber(String phoneNumber) =>
      withInput(input.withPhoneNumber(phoneNumber));

  PhoneEntryStep withInput(PhoneNumberInput newInput) =>
      PhoneEntryStep.fromInput(newInput);

  @override
  bool get isValid => input.isValid;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneEntryStep &&
          runtimeType == other.runtimeType &&
          input == other.input;

  @override
  int get hashCode => input.hashCode;
}

class OtpVerificationStep extends KycVerificationStep {
  const OtpVerificationStep({
    required this.phone,
    required this.otp,
    required this.canResend,
  });

  final PhoneNumberInput phone;

  final String otp;

  final bool canResend;

  @override
  bool get isValid => phone.isValid && otp.isNotEmpty && otp.length == 6;

  OtpVerificationStep withOtp(String newOtp) =>
      OtpVerificationStep(phone: phone, otp: newOtp, canResend: canResend);

  OtpVerificationStep withCanResend(bool canResend) =>
      OtpVerificationStep(phone: phone, otp: otp, canResend: canResend);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OtpVerificationStep &&
          runtimeType == other.runtimeType &&
          phone == other.phone &&
          otp == other.otp;

  @override
  int get hashCode => Object.hash(phone, otp);
}

sealed class KycPhoneVerificationState<T extends KycVerificationStep> {
  const KycPhoneVerificationState(this.step);

  final T step;
}

class KycPhoneVerificationInput<T extends KycVerificationStep>
    extends KycPhoneVerificationState<T> {
  const KycPhoneVerificationInput(super.step);
}

class KycPhoneVerificationInProgress<T extends KycVerificationStep>
    extends KycPhoneVerificationState<T> {
  const KycPhoneVerificationInProgress(super.step);
}

class KycPhoneVerificationError<T extends KycVerificationStep>
    extends KycPhoneVerificationState<T> {
  const KycPhoneVerificationError(super.step, {required this.error});

  final String error;
}

class KycPhoneVerificationComplete
    extends KycPhoneVerificationState<OtpVerificationStep> {
  const KycPhoneVerificationComplete(super.step);
}

class PhoneNumberInput {
  const PhoneNumberInput({
    required this.phoneNumber,
    required this.countryCode,
  });

  static const empty = PhoneNumberInput(phoneNumber: '', countryCode: '');

  final String phoneNumber;

  final String countryCode;

  String get fullPhoneNumber => '+$countryCode$phoneNumber';

  PhoneNumberInput withCountryCode(String countryCode) =>
      PhoneNumberInput(phoneNumber: phoneNumber, countryCode: countryCode);

  PhoneNumberInput withPhoneNumber(String phoneNumber) =>
      PhoneNumberInput(phoneNumber: phoneNumber, countryCode: countryCode);

  PhoneNumberInput copyWith({String? phoneNumber, String? countryCode}) =>
      PhoneNumberInput(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        countryCode: countryCode ?? this.countryCode,
      );

  bool get isValid => phoneNumber.isNotEmpty && countryCode.isNotEmpty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneNumberInput &&
          runtimeType == other.runtimeType &&
          phoneNumber == other.phoneNumber &&
          countryCode == other.countryCode;

  @override
  int get hashCode => Object.hash(phoneNumber, countryCode);
}

class KycPhoneVerificationCubit extends Cubit<KycPhoneVerificationState> {
  KycPhoneVerificationCubit(
    this.repository, {
    required this.quoteId,
    PhoneNumberInput? initialPhone,
  }) : super(
         KycPhoneVerificationInput(
           PhoneEntryStep.fromInput(initialPhone ?? PhoneNumberInput.empty),
         ),
       );

  final KycRepository repository;

  final String quoteId;

  KycVerificationStep get step => state.step;

  void phoneNumberChanged(String phoneNumber) {
    if (step case PhoneEntryStep phoneEntryStep) {
      emit(
        KycPhoneVerificationInput(phoneEntryStep.withPhoneNumber(phoneNumber)),
      );
    }
  }

  void countryCodeChanged(String countryCode) {
    if (step case PhoneEntryStep phoneEntryStep) {
      emit(
        KycPhoneVerificationInput(phoneEntryStep.withCountryCode(countryCode)),
      );
    }
  }

  void editPhoneNumber() {
    if (step case OtpVerificationStep otpStep) {
      emit(
        KycPhoneVerificationInput(
          PhoneEntryStep.fromInput(otpStep.phone),
        ),
      );
    }
  }

  Future<void> sendOtp() async {
    if (step case PhoneEntryStep phoneEntryStep) {
      debugPrint('Sending OTP to ${phoneEntryStep.input.fullPhoneNumber}');
      if (!phoneEntryStep.isValid) {
        emit(
          KycPhoneVerificationError(
            phoneEntryStep,
            error: 'Please enter a valid phone number.',
          ),
        );
        return;
      }
      emit(KycPhoneVerificationInProgress(phoneEntryStep));
      await _sendOtp(phoneEntryStep.input, phoneEntryStep);
    }
  }

  void otpChanged(String otp) {
    if (step case OtpVerificationStep otpStep) {
      emit(KycPhoneVerificationInput(otpStep.withOtp(otp)));
    }
  }

  Future<void> verifyOtp({required String quoteId}) async {
    if (step case OtpVerificationStep currentState) {
      if (!currentState.isValid) {
        emit(
          KycPhoneVerificationError(
            currentState,
            error: 'Please enter a valid OTP.',
          ),
        );
        return;
      }

      emit(KycPhoneVerificationInProgress(currentState));

      try {
        final success = await repository.verifyOtp(
          quoteId: quoteId,
          otp: currentState.otp,
        );

        if (!success) {
          emit(
            KycPhoneVerificationError(
              currentState,
              error: 'Invalid OTP. Please try again.',
            ),
          );
          return;
        }
        emit(KycPhoneVerificationComplete(currentState));
      } catch (e, s) {
        emit(
          KycPhoneVerificationError(
            currentState,
            error: 'An error occurred. Please try again.',
          ),
          
        );
        debugPrint('Error during OTP verification: $e');
        debugPrintStack(stackTrace: s);
        debugPrint('Quote ID: $quoteId, OTP: ${currentState.otp}');
      }
    }
  }

  void enableResendOtp() {
    if (step case OtpVerificationStep otpStep) {
      emit(KycPhoneVerificationInput(otpStep.withCanResend(true)));
    }
  }

  Future<void> resendOtp() {
    if (step case OtpVerificationStep otpStep) {
      if (!otpStep.canResend) {
        return Future.value();
      }
      return _sendOtp(otpStep.phone, otpStep);
    }
    return Future.value();
  }

  Future<void> _sendOtp(
    PhoneNumberInput phone,
    KycVerificationStep currentStep,
  ) async {
    try {
      final success = await repository.sendOtp(
        quoteId: quoteId,
        phoneNumber: phone.fullPhoneNumber,
      );
      if (!success) {
        emit(
          KycPhoneVerificationError(
            currentStep,
            error: 'Failed to send OTP. Please try again.',
          ),
        );
        return;
      }
      emit(
        KycPhoneVerificationInput(
          OtpVerificationStep(phone: phone, otp: '', canResend: false),
        ),
      );
    } catch (e, s) {
      emit(
        KycPhoneVerificationError(
          currentStep,
          error: 'An error occurred. Please try again.',
        ),
      );
      debugPrint('Error during sending OTP: $e');
      debugPrintStack(stackTrace: s);
      debugPrint('Quote ID: $quoteId, Phone Number: ${phone.fullPhoneNumber}');
    }
  }
}
