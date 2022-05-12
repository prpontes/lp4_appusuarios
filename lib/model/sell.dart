// ignore_for_file: non_constant_identifier_names

import 'package:lp4_appusuarios/model/item_venda.dart';


class Sell {
  // model venda
  int? id;
  String? date;
  int? idUser;
  String? username;
  List<ItemVenda> items;

  Sell({
    this.id,
    this.date,
    this.idUser,
    this.username,
    this.items = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date,
      "idUser": idUser,
    };
  }

  static Sell fromMap(Map<String, dynamic> map) {
    return Sell(
      id: map['idVenda'],
      date: map['date'],
      idUser: map['idUser'],
      username: map['nome']
    );
  }

  @override
  String toString() {
    return 'Usuario{id: $id, date: $date, idUser: $idUser}';
  }
}
