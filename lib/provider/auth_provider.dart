import 'package:flutter/cupertino.dart';
import '../model/usuario.dart';

class AuthProvider extends ChangeNotifier {
  Usuario? _user;

  Usuario get user => _user!;

  bool get isLoggedIn => _user != null;

  set user(Usuario u) {
    _user = u;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
