import 'package:flutter/material.dart';
import 'package:form/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(username: '', password: '', id: '', token: '');

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserfromModel(User user) {
    _user = user;
    notifyListeners();
  }

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
