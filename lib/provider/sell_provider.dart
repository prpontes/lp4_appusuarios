import 'package:flutter/widgets.dart';
import 'package:lp4_appusuarios/model/sell.dart';
import 'package:lp4_appusuarios/model/item_venda.dart';
import 'package:lp4_appusuarios/singletons/database_singleton.dart';
import 'package:sqflite/sqflite.dart';

class SellProvider extends ChangeNotifier {
  Database db = DatabaseSingleton.instance.db;
  String tabelaVenda = "sell";
  String tabelaItemVenda = "itemVenda";

  List<Sell> sales = [];

  Future<List<Sell>> listSales(int idUsuario) async {
    List salesList = await db
        .query(tabelaVenda, where: "idUser = ?", whereArgs: [idUsuario]);

    debugPrint("lista: ${salesList.toString()}");

    sales = await Future.wait(List.generate(salesList.length, (index) async {
      return Sell.fromMap(salesList[index])
        ..items = await listItems(salesList[index]["id"]);
    }));

    debugPrint("sales: ${sales.toString()}");
    notifyListeners();
    return sales;
  }

  Future<List<ItemVenda>> listItems(int idVenda) async {
    List itensList = await db
        .query("itemVenda_view", where: "idVenda = ?", whereArgs: [idVenda]);
    debugPrint(itensList.toString());
    var itensVenda = List.generate(itensList.length, (index) {
      return ItemVenda.fromMap(itensList[index]);
    });
    return itensVenda;
  }

  Future<Sell> saveSell(Sell sell) async {
    int id = await db.insert(tabelaVenda, sell.toMap());
    if (id == 0) {
      throw Exception("Failed to insert itemVenda");
    }
    sell.id = id;
    sales.add(sell);
    notifyListeners();
    return sell;
  }

  Future<ItemVenda> saveItem(ItemVenda item) async {
    var itemVendaId = await db.insert(tabelaItemVenda, item.toMap());
    if (itemVendaId == 0) {
      throw Exception("Failed to insert itemVenda");
    }
    notifyListeners();
    return item;
  }

  Future<void> buy(List<ItemVenda> itens, int userId) async {
    // create Venda and get id
    Sell venda = Sell(
      date: DateTime.now().toString(),
      idUser: userId,
    );
    int idVenda = (await saveSell(venda)).id!;
    try {
      for (ItemVenda item in itens) {
        item.idVenda = idVenda;
        await saveItem(item);
      }
    } catch (e) {
      await db.delete(tabelaVenda, where: "sell.id = ?", whereArgs: [idVenda]);
    }
  }
}
