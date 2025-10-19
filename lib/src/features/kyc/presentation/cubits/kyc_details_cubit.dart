import 'package:boilerplate/src/features/kyc/domain/entities/entities.dart';
import 'package:boilerplate/src/features/kyc/domain/repositories/kyc_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KycDetailsCubit extends Cubit<KycDetailsState> {
  KycDetailsCubit(this.repository, {required this.quoteId})
    : super(KycDetailsInput());

  final KycRepository repository;

  final String quoteId;

  void detailsChanged(KycDetails newDetails) {
    emit(KycDetailsInput(newDetails));
  }

  Future<void> submitKycDetails() async {
      emit(KycDetailsSubmitting(state.details));
      try {
        final success = await repository.updateDetails(
          details: state.details,
          quoteId: quoteId,
        );
        if (!success) {
          emit(KycDetailsError(state.details, "Failed to submit KYC details"));
          return;
        }
        emit(KycDetailsSubmitted(state.details));
      } catch (e) {
        emit(KycDetailsError(state.details, e.toString()));
      }
    }
  
}

sealed class KycDetailsState {
  const KycDetailsState(this.details);

  final KycDetails details;
}

class KycDetailsInput extends KycDetailsState {
  KycDetailsInput([
    super.details = const KycDetails(
      firstName: '',
      lastName: '',
      address: KycAddress(),
    ),
  ]);
}

class KycDetailsSubmitting extends KycDetailsState {
  const KycDetailsSubmitting(super.details);
}

class KycDetailsSubmitted extends KycDetailsState {
  const KycDetailsSubmitted(super.details);
}

class KycDetailsError extends KycDetailsState {
  const KycDetailsError(super.details, this.message);

  final String message;
}
