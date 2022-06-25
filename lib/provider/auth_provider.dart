import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lp4_appusuarios/model/usuarioFirebase.dart';
import '../model/usuario.dart';

class AuthProvider extends ChangeNotifier {
  UsuarioFirebase? _user;

  UsuarioFirebase? get user => isLoggedIn ? _user! : null;

  bool get isLoggedIn => _user != null;

  login(UsuarioFirebase user) {
    _user = user;
    notifyListeners();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }
}
