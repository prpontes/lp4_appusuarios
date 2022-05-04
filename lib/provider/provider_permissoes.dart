import 'package:flutter/cupertino.dart';
import 'package:lp4_appusuarios/model/permissoes.dart';

class PermissoesModel extends ChangeNotifier
{
  Permissoes? _permissoes;
  Permissoes get permissoes => _permissoes!;

  set permissoes(Permissoes value) {
    _permissoes = value;
    notifyListeners();
  }
}