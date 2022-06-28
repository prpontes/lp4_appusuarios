// ignore_for_file: non_constant_identifier_names

import 'package:lp4_appusuarios/model/item_venda.dart';
import 'package:lp4_appusuarios/model/usuarioFirebase.dart';

class Sell {
  // model venda
  String id;
  String date;
  UsuarioFirebase user;
  late List<ItemVenda> items;

  Sell({
    required this.id,
    required this.date,
    required this.user,
    List<ItemVenda>? items,
  }) {
    this.items = items ?? List.empty(growable: true);
  }

  Map<String, dynamic> toMap() {
    return {
      "date": date,
      "idUser": user.id,
    };
  }

  static Sell fromMap(Map<String, dynamic> map,
      {required String id,
      required UsuarioFirebase user,
      List<ItemVenda>? items}) {
    return Sell(
      id: id,
      date: map['date'],
      user: user,
      items: items ?? List.empty(growable: true),
    );
  }
}
