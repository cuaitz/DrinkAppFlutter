
import 'package:dio/dio.dart';

class ApiClient {
  late final Dio dio;
  String? token;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://drink-app-backend.vercel.app",
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json'
        }
      )
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (e, handler) {
          print("Request error: ${e.response?.statusCode} ${e.response?.data}");
          return handler.next(e);
        }
      )
    );

  }

  void setToken(String newToken) {
    token = newToken;
  }
}