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
import 'package:boilerplate/src/features/products/data/data_sources/products_data_source.dart';
import 'package:boilerplate/src/features/products/data/data_sources/remote/remote_products_data_source.dart';
import 'package:dio/dio.dart';

final class Dependencies {
  Dependencies({
    required this.apiClient,
    AuthSource? authClient,
    BrandsDataSource? brandsDataSource,
    ProductsDataSource? productsDataSource,
    DashboardDataSource? dashboardDataSource,
  }) : authSource = authClient ?? RemoteAuthSource(apiClient),
       brandsDataSource = brandsDataSource ?? RemoteBrandsDataSource(apiClient),
       productsDataSource =
           productsDataSource ?? RemoteProductsDataSource(apiClient),
       dashboardDataSource =
           dashboardDataSource ?? RemoteDashboardDataSource(apiClient);

  factory Dependencies.defaults() => Dependencies(
    apiClient: DioApiClient.fromOptions(
      BaseOptions(baseUrl: ApiOptions.baseUrl),
      InMemoryTokenStore(),
    ),
  );
  final ApiClient apiClient;

  final AuthSource authSource;

  final BrandsDataSource brandsDataSource;

  final ProductsDataSource productsDataSource;

  final DashboardDataSource dashboardDataSource;
}
