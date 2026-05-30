import 'package:dio/dio.dart';
import 'package:drink_app_flutter/model/beverage.dart';

class BeverageService {
  final Dio dio;

  BeverageService(this.dio);

  Future<List<Beverage>> getAll() async {
    final res = await dio.get('/api/beverages');

    return (res.data as List)
        .map((e) => Beverage.fromJson(e))
        .toList();
  }

  Future<Beverage> getById(String id) async {
    final res = await dio.get('/api/beverage/$id');
    return Beverage.fromJson(res.data);
  }

  Future<Beverage> create(Beverage beverage) async {
    final res = await dio.post(
      '/api/beverage',
      data: beverage.toJson(),
    );

    return Beverage.fromJson(res.data);
  }

  Future<Beverage> update(String id, Beverage beverage) async {
    final res = await dio.put(
      '/api/beverage/$id',
      data: beverage.toJson(),
    );

    return Beverage.fromJson(res.data);
  }

  Future<void> delete(String id) async {
    await dio.delete('/api/beverage/$id');
  }
}