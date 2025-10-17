
import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/core/models/response.dart';
import 'package:boilerplate/src/features/kyc/domain/entities/entities.dart';

abstract interface class KycDataSource {
  Future<Response> sendOtp({
    required String quoteId,
    required String phoneNumber,
  });

  Future<DataResponse<KycStatus>> status({required String quoteId});

  Future<Response> verifyOtp({
    required String quoteId,
    required String otp,
  });

  Future<Response> updateDetails({
    required String quoteId,
    required KycDetails details,
  });

  Future<Response> uploadDocuments({
    required String quoteId,
    required KycDocumentsSubmission documents,
  });
}