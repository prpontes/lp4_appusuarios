import 'package:flutter/widgets.dart';
import 'package:lp4_appusuarios/model/sell.dart';
import 'package:lp4_appusuarios/model/itemVenda.dart';
import 'package:lp4_appusuarios/singletons/database_singleton.dart';
import 'package:sqflite/sqflite.dart';

class SellProvider extends ChangeNotifier {
  Database db = DatabaseSingleton.instance.db;
  String nomeTabela = "sell";
  String nomeTabela2 = "item_venda";

  List<Sell> sales = [];

  List<ItemVenda> itens = [];

  SellProvider() {
    debugPrint("SellProvider()");
  }

  // listarVendas();
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

  // listarItems
  Future<List<ItemVenda>> listItens() async {
    List lista = await db.rawQuery(
        "SELECT itemVenda.quantity as quantidade, itemVenda.price as preco, product.name as produto, usuario.nome as nome from  usuario join sell on (sell.idUser = usuario.id)  join itemVenda on (itemVenda.id = sell.id) join product on ( product.id = itemvenda.idProduto) WHERE usuario.id = sell.idUser;");
    itens = List.generate(lista.length, (index) {
      return ItemVenda(
        usuario: lista[index]["usuario"],
      );
    });
    notifyListeners();
    return itens;
  }
}
