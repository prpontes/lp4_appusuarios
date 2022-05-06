import 'package:flutter/widgets.dart';
import 'package:lp4_appusuarios/model/fornecedor.dart';
import 'package:lp4_appusuarios/model/product.dart';
import 'package:lp4_appusuarios/model/sell.dart';
import 'package:lp4_appusuarios/model/item_venda.dart';
import 'package:lp4_appusuarios/singletons/database_singleton.dart';
import 'package:sqflite/sqflite.dart';

class SellProvider extends ChangeNotifier {
  Database db = DatabaseSingleton.instance.db;
  String tabelaVenda = "sell";
  String tabelaItemVenda = "itemVenda";

  List<Sell> sales = [];

  List<ItemVenda> itens = [];

  SellProvider() {
    debugPrint("SellProvider()");
  }

  // listarVendas();
  Future<List<Sell>> listSales() async {
    List lista = await db.query(tabelaVenda);

    sales = List.generate(lista.length, (index) {
      return Sell(
        id: lista[index]["id"],
        date: lista[index]["date"],
        idUser: lista[index]["idUser"],
      );
    });
    notifyListeners();
    return sales;
  }

  // listarItems
  Future<List<ItemVenda>> listItens(int idUsuario) async {
    List lista = await db
        .query("itemVenda_view", where: "idUser = ?", whereArgs: [idUsuario]);
    var itensVenda = List.generate(lista.length, (index) {
      return ItemVenda(
        id: lista[index]["id"],
        quantity: lista[index]["quantity"],
        price: lista[index]["price"],
        produto: Product(
          name: lista[index]["name"],
          description: lista[index]["description"],
          image: lista[index]["image"],
        ),
      );
    });

    sales = List.generate(lista.length, (index) {
      return Sell(
        id: lista[index]["idVenda"],
        date: lista[index]["date"],
        idUser: lista[index]["idUser"],
        items: itensVenda,
      );
    });

    notifyListeners();
    return itens;
  }

  Future<Sell> saveSell(Sell sell) async {
    int id = await db.insert(tabelaVenda, sell.toMap());
    sell.id = id;
    sales.add(sell);
    notifyListeners();
    return sell;
  }

  Future<ItemVenda> saveItem(ItemVenda item) async {
    debugPrint("saveItem() ${item.toString()}");
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
    debugPrint("idVenda: $idVenda");
    // create ItemVenda
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
