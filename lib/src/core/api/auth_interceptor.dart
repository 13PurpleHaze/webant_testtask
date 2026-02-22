import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './constants.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  final Dio _dio;

  const AuthInterceptor({
    required FlutterSecureStorage storage,
    required Dio dio,
  }) : _storage = storage,
       _dio = dio;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.read(key: 'token') ?? '';
    options.headers.addAll({
      if (!options.path.contains('/token')) 'Authorization': 'Bearer $token',
    });
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        final token = await _refreshToken();
        await _storage.write(key: 'token', value: token);

        final newRequest = err.requestOptions;
        newRequest.headers['Authorization'] = 'Bearer $token';

        final response = await _dio.fetch(newRequest);
        handler.resolve(response);
        return;
      } catch (e) {
        //
      }
    }
    handler.next(err);
  }

  Future<String> _refreshToken() async {
    final basicAuth = base64Encode(utf8.encode('$clientId:$clientSecret'));

    final response = await _dio.post(
      '/token',
      data: {
        'grant_type': 'password',
        'username': username,
        'password': password,
      },
      options: Options(
        responseType: ResponseType.plain,
        headers: {
          'Authorization': 'Basic $basicAuth',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    );
    final data = jsonDecode(response.data);
    return data['access_token'];
  }
}
