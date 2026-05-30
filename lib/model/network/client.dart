
import 'package:dio/dio.dart';
import 'package:drink_app_flutter/app.dart';
import 'package:drink_app_flutter/routes.dart';
import 'package:flutter/material.dart';

class ApiClient {
  late final Dio dio;
  String? token;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://new-drink-app-node.vercel.app/",
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
          if (e.response?.statusCode == 401) {
            token = null;
            scaffoldMessengerKey.currentState?.showSnackBar(
              const SnackBar(
                content: Text('Sessão expirada. Faça login novamente.'),
                backgroundColor: Colors.orange,
              ),
            );
            drinkAppRouter.go(DrinkAppRoutes.homeView);
          }
          return handler.next(e);
        }
      )
    );

  }

  void setToken(String newToken) {
    token = newToken;
  }
}