import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:webant_testtask/src/core/api/auth_interceptor.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  factory ApiClient() => _instance;

  late final Dio dio;

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://gallery.prod2.webant.ru',
        contentType: 'application/json',
      ),
    );
    dio.interceptors.add(AuthInterceptor(dio: dio, storage: _storage));
  }
}
