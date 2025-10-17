import 'package:boilerplate/src/features/kyc/domain/data/data_sources/kyc_data_source.dart';
import 'package:boilerplate/src/features/kyc/domain/entities/entities.dart';
import 'package:boilerplate/src/features/kyc/domain/repositories/kyc_repository.dart';

class RemoteKycRepository implements KycRepository {
  const RemoteKycRepository(this.dataSource);

  final KycDataSource dataSource;

  @override
  Future<bool> sendOtp({
    required String quoteId,
    required String phoneNumber,
  }) => dataSource
      .sendOtp(quoteId: quoteId, phoneNumber: phoneNumber)
      .then((response) => response.success);

  @override
  Future<KycStatus> status({required String quoteId}) => dataSource
      .status(quoteId: quoteId)
      .then((response) => response.requireData);

  @override
  Future<bool> verifyOtp({required String quoteId, required String otp}) =>
      dataSource
          .verifyOtp(quoteId: quoteId, otp: otp)
          .then((response) => response.success);

  @override
  Future<bool> updateDetails({
    required String quoteId,
    required KycDetails details,
  }) => dataSource
      .updateDetails(quoteId: quoteId, details: details)
      .then((response) => response.success);

  @override
  Future<bool> uploadDocuments({
    required String quoteId,
    required KycDocumentsSubmission documents,
  }) => dataSource
      .uploadDocuments(quoteId: quoteId, documents: documents)
      .then((response) => response.success);
}
