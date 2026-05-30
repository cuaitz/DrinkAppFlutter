import 'package:drink_app_flutter/model/network/client.dart';

class AuthService {
  final ApiClient client;

  AuthService(this.client);

  Future<void> login(String email, String password) async {
    final res = await client.dio.post('/login', data: {
      'email': email,
      'password': password,
    });

    final token = res.data['token'];
    client.setToken(token);
  }

  Future<void> register(String email, String password, String name) async {
    final res = await client.dio.post('/register', data: {
      'email': email,
      'password': password,
      'name': name,
    });

    final token = res.data['token'];
    client.setToken(token);
  }
}