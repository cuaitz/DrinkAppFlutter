import 'package:drink_app_flutter/model/drink.dart';
import 'package:drink_app_flutter/model/network/client.dart';

class DrinkApi {
  late final ApiClient client;

  DrinkApi() {
    client = ApiClient();
  }

  
}