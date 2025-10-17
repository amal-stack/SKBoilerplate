import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/core/models/response.dart';
import 'package:boilerplate/src/core/network/api_client.dart';
import 'package:boilerplate/src/core/network/models/api_request.dart';
import 'package:boilerplate/src/features/kyc/domain/data/data_sources/kyc_data_source.dart';
import 'package:boilerplate/src/features/kyc/domain/entities/entities.dart';
import 'package:path/path.dart' as p;

class RemoteKycDataSource implements KycDataSource {
  const RemoteKycDataSource(this.apiClient);

  final ApiClient apiClient;

  static const baseUrl = '/orders/kyc';

  @override
  Future<Response> sendOtp({
    required String quoteId,
    required String phoneNumber,
  }) => apiClient
      .post(
        ApiRequest(
          path: '$baseUrl/send-otp',
          data: {'quoteId': quoteId, 'phoneNumber': phoneNumber},
        ),
      )
      .then((response) => Response.fromJson(response.dataAsMap()));

  @override
  Future<DataResponse<KycStatus>> status({required String quoteId}) => apiClient
      .get(ApiRequest(path: '$baseUrl/$quoteId/status'))
      .then(
        (response) => DataResponse.fromJsonWithConverter(
          response.dataAsMap(),
          dataFromJson: KycStatus.fromJson,
          dataToJson: (KycStatus data) => data.toJson(),
        ),
      );

  @override
  Future<Response> verifyOtp({required String quoteId, required String otp}) =>
      apiClient
          .post(
            ApiRequest(
              path: '$baseUrl/verify-otp',
              data: {'quoteId': quoteId, 'otp': otp},
            ),
          )
          .then((response) => Response.fromJson(response.dataAsMap()));

  @override
  Future<Response> updateDetails({
    required String quoteId,
    required KycDetails details,
  }) => apiClient
      .put(
        ApiRequest(path: '$baseUrl/$quoteId/details', data: details.toJson()),
      )
      .then((response) => Response.fromJson(response.dataAsMap()));

  @override
  Future<Response> uploadDocuments({
    required String quoteId,
    required KycDocumentsSubmission documents,
  }) => apiClient
      .post(
        ApiRequest(
          path: '$baseUrl/$quoteId/documents/upload',
          data: ApiFormData(
            fields: const {},
            files: [
              ApiFileEntry(
                key: 'aadhaarFront',
                filename:
                    '$quoteId-aadhaar-front.${p.extension(documents.aadhaarFrontPath)}',
                path: documents.aadhaarFrontPath,
              ),
              ApiFileEntry(
                key: 'aadhaarBack',
                filename:
                    '$quoteId-aadhaar-back.${p.extension(documents.aadhaarBackPath)}',
                path: documents.aadhaarBackPath,
              ),
              ApiFileEntry(
                key: 'addressProof',
                filename:
                    '$quoteId-address-proof.${p.extension(documents.addressProofPath)}',
                path: documents.addressProofPath,
              ),
            ],
          ),
        ),
      )
      .then((response) => Response.fromJson(response.dataAsMap()));
}
