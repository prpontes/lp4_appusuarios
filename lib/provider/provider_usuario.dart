import 'package:flutter/cupertino.dart';
import '../model/usuario.dart';

class UsuarioModel extends ChangeNotifier
{
  Usuario? _user;

  Usuario get user => _user!;

  set user(Usuario u)
  {
    _user = u;
    notifyListeners();
  }
}