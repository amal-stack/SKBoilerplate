import 'package:boilerplate/src/features/kyc/domain/entities/entities.dart';

abstract interface class KycRepository {
  Future<bool> sendOtp({required String quoteId, required String phoneNumber});
  Future<KycStatus> status({required String quoteId});
  Future<bool> verifyOtp({required String quoteId, required String otp});
  Future<bool> updateDetails({
    required String quoteId,
    required KycDetails details,
  });
  Future<bool> uploadDocuments({
    required String quoteId,
    required KycDocumentsSubmission documents,
  });
}
