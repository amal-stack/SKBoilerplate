import 'package:boilerplate/src/features/kyc/domain/repositories/kyc_repository.dart';
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
      PhoneEntryStep.fromInput(input.withCountryCode(countryCode));

  PhoneEntryStep withPhoneNumber(String phoneNumber) =>
      PhoneEntryStep.fromInput(input.withPhoneNumber(phoneNumber));

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
  KycPhoneVerificationCubit(this.repository)
    : super(const KycPhoneVerificationInput(PhoneEntryStep.empty));

  final KycRepository repository;

  KycVerificationStep get step => state.step;

  void phoneNumberChanged(String phoneNumber) {
        emit(
          KycPhoneVerificationInput(
            PhoneEntryStep(
              phoneNumber: phoneNumber,
            )
          ),
        );
    }



  void countryCodeChanged(String countryCode) {
      emit(
        KycPhoneVerificationInput(
          PhoneEntryStep(
            countryCode: countryCode,
          )
        ),
      );
  }

  void sendOtp({required String quoteId}) async {
    
    switch (step) {
      case PhoneEntryStep phoneEntryStep:
        _sendOtp(quoteId: quoteId, phone: phoneEntryStep.input);
        return;
      case OtpVerificationStep otpStep:
        if (!otpStep.canResend) {
          return;
        }
        _sendOtp(quoteId: quoteId, phone: otpStep.phone);
        return;
    }
  }


  void otpChanged(String otp) {
    // void emitFromSentState(OtpSentState state) {
    //   emit(state.withOtp(otp));
    // }

    // switch (state) {
    //   case OtpSentState sentState:
    //     emitFromSentState(sentState);
    //     return;
    //   case PostInputState<OtpSentState> inProgressState:
    //     emitFromSentState(inProgressState.toInput());
    //     return;
    //   default:
    //     return;
    // }
  }

  void verifyOtp({required String quoteId}) async {
    // if (state case OtpSentState currentState) {
    //   final otp = currentState.otp;
    //   if (otp == null || otp.isEmpty) {
    //     emit(currentState.toError('Please enter the OTP.'));
    //     return;
    //   }

    //   emit(currentState.toInProgress());

    //   try {
    //     final success = await repository.verifyOtp(quoteId: quoteId, otp: otp);
    //     if (!success) {
    //       emit(currentState.toError('Invalid OTP. Please try again.'));
    //       return;
    //     }
    //     emit(currentState.toCompleted());
    //   } catch (e) {
    //     emit(currentState.toError('An error occurred. Please try again.'));
    //   }
    // }
  }

  void reset() {
    //emit(const EnteringPhoneState());
  }

  void _sendOtp({
    required String quoteId,
    required PhoneNumberInput phone,
  }) async {
    // if (!phone.isValid) {
    //     emit(state.toError('Please enter a valid phone number'));
    //     return;
    //   }
    //   emit(currentState.toInProgress());

    //   try {
    //     final success = await repository.sendOtp(
    //       quoteId: quoteId,
    //       phoneNumber: currentState.phone.fullPhoneNumber,
    //     );
    //     if (!success) {
    //       emit(currentState.toError('Failed to send OTP. Please try again.'));
    //       return;
    //     }
    //     emit(currentState.toOtpSent());
    //   } catch (e) {
    //     emit(currentState.toError('An error occurred. Please try again.'));
    //   }
  }
}
