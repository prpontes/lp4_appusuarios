import 'package:flutter/cupertino.dart';
import '../model/usuario.dart';

class AuthProvider extends ChangeNotifier {
  Usuario? _user;

  Usuario? get user => isLoggedIn ? _user! : null;

  bool get isLoggedIn => _user != null;

  login(Usuario user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
