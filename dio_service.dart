import 'package:dio/dio.dart';
import 'package:e_commerce_complete_fake_api/model/core/api_urls.dart';

class DioService {
  static final DioService _singleton = DioService._internal();
  late final Dio _dio;

  factory DioService() {
    return _singleton;
  }

  DioService._internal() {
    _setup();
  }

  Future<void> _setup() async {
    _dio = Dio(BaseOptions(
      baseUrl: ApiUrls().baseUrl,
      validateStatus: (status) {
        return status != null && status < 500;
      },
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      responseHeader: true,
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<Response?> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on FormatException {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      throw e;
    }
  }
}
