import 'package:dio/dio.dart';
import 'package:drink_app_flutter/model/drink.dart';

class DrinkService {
  final Dio dio;

  DrinkService(this.dio);

  Future<List<Drink>> getAll() async {
    final res = await dio.get('/drinks');
    return (res.data as List)
        .map((e) => Drink.fromJson(e))
        .toList();
  }

  Future<List<Drink>> getUserDrinks(String userId) async {
    final res = await dio.get('/drinks/user/$userId');
    return (res.data as List)
        .map((e) => Drink.fromJson(e))
        .toList();
  }

  Future<Drink> create(Drink drink) async {
    final res = await dio.post(
      '/drinks',
      data: drink.toJson(),
    );

    return Drink.fromJson(res.data);
  }

  Future<Drink> update(String id, Drink drink) async {
    final res = await dio.put(
      '/drinks/$id',
      data: drink.toJson(),
    );

    return Drink.fromJson(res.data);
  }

  Future<void> delete(String id) async {
    await dio.delete('/drinks/$id');
  }
}