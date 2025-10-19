import 'package:boilerplate/src/core/config/api_options.dart';
import 'package:boilerplate/src/core/network/api_client.dart';
import 'package:boilerplate/src/core/network/dio_api_client.dart';
import 'package:boilerplate/src/core/network/token_store.dart';
import 'package:boilerplate/src/features/auth/data/data_sources/auth_source.dart';
import 'package:boilerplate/src/features/auth/data/data_sources/remote/remote_auth_source.dart';
import 'package:boilerplate/src/features/brands/data/data_sources/brands_data_source.dart';
import 'package:boilerplate/src/features/brands/data/data_sources/remote/remote_brands_data_source.dart';
import 'package:boilerplate/src/features/dashboard/data/data_sources/dashboard_data_source.dart';
import 'package:boilerplate/src/features/dashboard/data/data_sources/remote/remote_dashboard_data_source.dart';
import 'package:boilerplate/src/features/kyc/domain/data/data_sources/kyc_data_source.dart';
import 'package:boilerplate/src/features/kyc/domain/data/data_sources/remote/remote_kyc_data_source.dart';
import 'package:boilerplate/src/features/orders/data/data_sources/orders_data_source.dart';
import 'package:boilerplate/src/features/orders/data/data_sources/remote/remote_orders_data_source.dart';

import 'package:boilerplate/src/features/products/data/data_sources/products_data_source.dart';
import 'package:boilerplate/src/features/products/data/data_sources/remote/remote_products_data_source.dart';
import 'package:boilerplate/src/features/questionaire/data/data_sources/grades_data_source.dart';
import 'package:boilerplate/src/features/questionaire/data/data_sources/local/local_questionnaire_data_source.dart';
import 'package:boilerplate/src/features/questionaire/data/data_sources/questionnaire_data_source.dart';
import 'package:boilerplate/src/features/questionaire/data/data_sources/quotes_data_source.dart';
import 'package:boilerplate/src/features/questionaire/data/data_sources/remote/remote_grades_data_source.dart';
import 'package:boilerplate/src/features/questionaire/data/data_sources/remote/remote_quotes_data_source.dart';
import 'package:dio/dio.dart';

const _tokenKey = 'switchkart.auth.token';

final class Dependencies {
  Dependencies({
    required this.apiClient,
    AuthSource? authClient,
    BrandsDataSource? brandsDataSource,
    ProductsDataSource? productsDataSource,
    DashboardDataSource? dashboardDataSource,
    QuestionnaireDataSource? questionnaireDataSource,
    GradesDataSource? gradesDataSource,
    QuotesDataSource? quotesDataSource,
    KycDataSource? kycDataSource,
    OrdersDataSource? ordersDataSource,
  }) : authSource = authClient ?? RemoteAuthSource(apiClient),
       brandsDataSource = brandsDataSource ?? RemoteBrandsDataSource(apiClient),
       productsDataSource =
           productsDataSource ?? RemoteProductsDataSource(apiClient),
       dashboardDataSource =
           dashboardDataSource ?? RemoteDashboardDataSource(apiClient),
       questionnaireDataSource =
           questionnaireDataSource ?? const LocalQuestionnaireDataSource(),
       gradesDataSource = gradesDataSource ?? RemoteGradesDataSource(apiClient),
       quotesDataSource = quotesDataSource ?? RemoteQuotesDataSource(apiClient),
       kycDataSource = kycDataSource ?? RemoteKycDataSource(apiClient),
       ordersDataSource = ordersDataSource ?? RemoteOrdersDataSource(apiClient);

  factory Dependencies.defaults() => Dependencies(
    apiClient: DioApiClient.fromOptions(
      BaseOptions(baseUrl: ApiOptions.baseUrl,
      connectTimeout: ApiOptions.connectTimeout,
      sendTimeout: ApiOptions.sendTimeout,
      receiveTimeout: ApiOptions.receiveTimeout
      ),
      SecureTokenStore(_tokenKey),
    ),
  );
  final ApiClient apiClient;

  final AuthSource authSource;

  final BrandsDataSource brandsDataSource;

  final ProductsDataSource productsDataSource;

  final DashboardDataSource dashboardDataSource;

  final QuestionnaireDataSource questionnaireDataSource;

  final QuotesDataSource quotesDataSource;

  final GradesDataSource gradesDataSource;

  final KycDataSource kycDataSource;

  final OrdersDataSource ordersDataSource;
}
