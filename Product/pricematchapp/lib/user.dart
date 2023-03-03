import 'dart:ffi';

import 'Map.dart';

class User {
  late String _name;
  late String _email;
  late Map<String, Double> _PriceWatchList;

  User(String name, String email) {
    _name = name;
    _email = email;
    _PriceWatchList = Map<String, Double>();
  }
}
