import 'package:dio/dio.dart';
import 'package:e_commerce_complete_fake_api/model/core/api_urls.dart';
import 'package:e_commerce_complete_fake_api/model/service/api_error_handler.dart';
import 'package:e_commerce_complete_fake_api/model/service/api_response.dart';
import 'package:e_commerce_complete_fake_api/model/service/dio_service.dart';

abstract class ProductService {
  Future<ApiResponse> productList();
  Future<ApiResponse> category(String categoryName);
}

class ProductServiceRemoteDataSource extends ProductService {
  static final ProductServiceRemoteDataSource _singleton = ProductServiceRemoteDataSource._internal();
  late final DioService _dioService;

  factory ProductServiceRemoteDataSource() {
    return _singleton;
  }

  ProductServiceRemoteDataSource._internal() {
    _dioService = DioService();
  }

  @override
  Future<ApiResponse> category(String categoryName) async {
    ApiUrls.categoryName = categoryName;
    try {
      Response? response = await _dioService.get(ApiUrls().categories);
      return ApiResponse.withSuccess(response!);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> productList() async {
    try {
      Response? response = await _dioService.get(ApiUrls().allProducts);
      return ApiResponse.withSuccess(response!);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
