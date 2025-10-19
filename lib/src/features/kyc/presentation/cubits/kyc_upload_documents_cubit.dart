import 'package:boilerplate/src/features/kyc/domain/entities/entities.dart';
import 'package:boilerplate/src/features/kyc/domain/repositories/kyc_repository.dart';
import 'package:boilerplate/src/shared/flags.dart' as f;
import 'package:flutter_bloc/flutter_bloc.dart';

class KycUploadDocumentsCubit extends Cubit<KycUploadDocumentsState> {
  KycUploadDocumentsCubit(this.repository, {required this.quoteId})
    : super(const KycUploadDocumentsInput());

  final KycRepository repository;

  final String quoteId;

  void documentUploaded(UploadedKycDocuments documents) {
    emit(KycUploadDocumentsInput(documents));
  }

  Future<void> submitDocuments() async {
    emit(KycUploadDocumentsSubmitting(state.documents));
    if (f.disableUploads) {
      emit(KycUploadDocumentsSubmitted(state.documents));
      return;
    }
    try {
      final success = await repository.uploadDocuments(
        documents: state.documents.toSubmission(),
        quoteId: quoteId,
      );
      if (!success) {
        emit(
          KycUploadDocumentsError(
            state.documents,
            "Failed to submit KYC documents",
          ),
        );
        return;
      }
      emit(KycUploadDocumentsSubmitted(state.documents));
    } catch (e) {
      emit(KycUploadDocumentsError(state.documents, e.toString()));
    }
  }
}

class UploadedKycDocuments {
  final String? aadhaarFrontPath;
  final String? aadhaarBackPath;
  final String? addressProofPath;

  const UploadedKycDocuments({
    this.aadhaarFrontPath,
    this.aadhaarBackPath,
    this.addressProofPath,
  });

  bool get isComplete =>
      aadhaarFrontPath != null &&
      aadhaarBackPath != null &&
      addressProofPath != null;

  UploadedKycDocuments copyWith({
    String? aadhaarFrontPath,
    String? aadhaarBackPath,
    String? addressProofPath,
  }) => UploadedKycDocuments(
    aadhaarFrontPath: aadhaarFrontPath ?? this.aadhaarFrontPath,
    aadhaarBackPath: aadhaarBackPath ?? this.aadhaarBackPath,
    addressProofPath: addressProofPath ?? this.addressProofPath,
  );

  KycDocumentsSubmission toSubmission() => KycDocumentsSubmission(
    aadhaarFrontPath:
        aadhaarFrontPath ??
        _kycException("Aadhaar card's front document is missing"),
    aadhaarBackPath:
        aadhaarBackPath ??
        _kycException("Aadhaar card's back document is missing"),
    addressProofPath:
        addressProofPath ?? _kycException("Address proof document is missing"),
  );

  Never _kycException(String message) => throw KycException(message);
}

sealed class KycUploadDocumentsState {
  const KycUploadDocumentsState([
    this.documents = const UploadedKycDocuments(),
  ]);

  final UploadedKycDocuments documents;
}

class KycUploadDocumentsInput extends KycUploadDocumentsState {
  const KycUploadDocumentsInput([super.documents]);
}

class KycUploadDocumentsSubmitting extends KycUploadDocumentsState {
  const KycUploadDocumentsSubmitting(super.documents);
}

class KycUploadDocumentsSubmitted extends KycUploadDocumentsState {
  const KycUploadDocumentsSubmitted(super.documents);
}

class KycUploadDocumentsError extends KycUploadDocumentsState {
  const KycUploadDocumentsError(super.documents, this.message);

  final String message;
}

class KycException implements Exception {
  KycException(this.message);

  final String message;

  @override
  String toString() => 'KycException: $message';
}

sealed class KycUploadInvoiceState {
  const KycUploadInvoiceState([this.invoicePath, this.hasInvoice = true]);

  final String? invoicePath;

  final bool hasInvoice;
}

class KycUploadInvoiceInput extends KycUploadInvoiceState {
  const KycUploadInvoiceInput([super.invoicePath, super.hasInvoice]);
}

class KycUploadInvoiceSubmitting extends KycUploadInvoiceState {
  const KycUploadInvoiceSubmitting(super.invoicePath, super.hasInvoice);
}

class KycUploadInvoiceSubmitted extends KycUploadInvoiceState {
  const KycUploadInvoiceSubmitted(super.invoicePath, super.hasInvoice);
}

class KycUploadInvoiceCubit extends Cubit<KycUploadInvoiceState> {
  KycUploadInvoiceCubit(this.repository, {required this.quoteId})
    : super(const KycUploadInvoiceInput());

  final KycRepository repository;

  final String quoteId;

  void invoiceUploaded(String invoicePath) {
    emit(KycUploadInvoiceInput(invoicePath));
  }

  void hasInvoiceChanged(bool hasInvoice) {
    emit(KycUploadInvoiceInput(state.invoicePath, hasInvoice));
  }

  void toggleHasInvoice() {
    emit(KycUploadInvoiceInput(state.invoicePath, !state.hasInvoice));
  }

  Future<void> submitInvoice() async {
    // TODO: Submit invoice to backend
    emit(KycUploadInvoiceSubmitted(state.invoicePath, state.hasInvoice));
  }
}
