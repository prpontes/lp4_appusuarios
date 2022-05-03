import 'package:flutter/widgets.dart';
import 'package:lp4_appusuarios/model/sell.dart';
import 'package:lp4_appusuarios/singletons/database_singleton.dart';
import 'package:sqflite/sqflite.dart';

class SellProvider extends ChangeNotifier {
  Database db = DatabaseSingleton.instance.db;
  String nomeTabela = "sell";

  List<Sell> sales = [];

  SellProvider() {
    debugPrint("SellProvider()");
    // listarUsuarios();
  }

  Future<List<Sell>> listSales() async {
    List lista = await db.query(nomeTabela);

    sales = List.generate(lista.length, (index) {
      return Sell(
        id: lista[index]["id"],
        date: lista[index]["date"],
        id_user: lista[index]["id_user"],
      );
    });
    notifyListeners();
    return sales;
  }
}
