import 'package:flutter/widgets.dart';
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
    List lista = await db.rawQuery(
        "SELECT *, itemVenda.quantity as quantity, itemVenda.price as price FROM $tabelaItemVenda itemVenda INNER JOIN $tabelaVenda ON $tabelaItemVenda.idVenda = $tabelaVenda.id INNER JOIN product ON $tabelaItemVenda.idProduto = product.id WHERE $tabelaVenda.idUser = $idUsuario");
    // example return: {id: 1, quantity: null, price: 0.0, idProduto: 1, idVenda: 4, date: 2022-05-05 23:52:29.088175, idUser: 1, name: bebeaaaa, description: , image: https://motorshow.com.br/wp-content/uploads/sites/2/2020/05/solo-rear-side-view_1575x1050.jpg, idFornecedor: -1}
    debugPrint(lista.toString());

    var itensVenda = List.generate(lista.length, (index) {
      return ItemVenda(
        id: lista[index]["id"],
        quantity: lista[index]["quantity"],
        price: lista[index]["price"],
        idProduto: lista[index]["idProduto"],
        idVenda: lista[index]["idVenda"],
        produto: Product(
          id: lista[index]["idProduto"],
          name: lista[index]["name"],
          description: lista[index]["description"],
          image: lista[index]["image"],
          price: lista[index]["price"],
          idFornecedor: lista[index]["idFornecedor"],
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
    await db.insert(tabelaItemVenda, item.toMap());
    notifyListeners();
    return item;
  }

  void buy(List<ItemVenda> itens, int userId) async {
    // create Venda and get id
    Sell venda = Sell(
      date: DateTime.now().toString(),
      idUser: userId,
    );
    int idVenda = (await saveSell(venda)).id!;
    debugPrint("idVenda: $idVenda");
    // create ItemVenda
    for (ItemVenda item in itens) {
      item.idVenda = idVenda;
      await saveItem(item);
    }
  }
}
