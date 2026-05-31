import 'package:drink_app_flutter/model/network/client.dart';
import 'package:drink_app_flutter/model/user.dart';

class AuthService {
  final ApiClient client;

  AuthService(this.client);

  Future<void> login(String email, String password) async {
    final res = await client.dio.post('/api/users/login', data: {
      'email': email,
      'password': password,
    });

    final token = res.data['token'];
    client.setToken(token);
  }

  Future<void> register(String email, String password, String name) async {
    final res = await client.dio.post('/api/users/register', data: {
      'email': email,
      'password': password,
      'name': name,
    });

    final token = res.data['token'];
    client.setToken(token);
  }

  Future<User> me() async {
    final res = await client.dio.get('/api/users/me');
    return User.fromJson(res.data);
  }
}