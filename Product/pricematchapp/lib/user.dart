import 'Map.dart';

class User {
  late String _name;
  late String _email;
  late Map<String, double> _PriceWatchList;
  late String _uID;

  User(String name, String email, String uID) {
    _name = name;
    _email = email;
    _PriceWatchList = Map<String, double>();
    _uID = uID;
  }

  String getName() {
    return _name;
  }

  String getEmail() {
    return _email;
  }

  String userID() {
    return _uID;
  }
}
