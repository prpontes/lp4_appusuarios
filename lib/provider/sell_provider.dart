import 'package:flutter/widgets.dart';
import 'package:lp4_appusuarios/model/sell.dart';
import 'package:lp4_appusuarios/model/item_venda.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lp4_appusuarios/model/usuarioFirebase.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';

class SellProvider extends ChangeNotifier {
  String tabelaVenda = "sell";
  String tabelaItemVenda = "itemVenda";
  late final ProductProvider _productProvider;
  late final UsuarioProvider _userProvider;

  FirebaseFirestore db = FirebaseFirestore.instance;

  SellProvider({required ProductProvider productProvider, required UsuarioProvider usuarioProvider}) {
    _productProvider = productProvider;
    _userProvider = usuarioProvider;
  }

  List<Sell> sales = [];
  // List<ItemVenda> itensVenda = [];

  Future<List<Sell>> listSales() async {
    var query = await db.collection(tabelaVenda).get();

    for (var doc in query.docs) {
      final List<ItemVenda> items = List.empty(growable: true);
      var query = await db.collection(tabelaVenda).doc(doc.id).collection("items").get();
      for (var doc in query.docs) {
        items.add(
          ItemVenda.fromMap(
            doc.id,
            doc.data(),
            (await _productProvider.getProduct(
              doc["idProduto"],
            ))!,
          ),
        );
      }
      sales.add(Sell.fromMap(
        doc.data(),
        id: doc.id,
        user: (await _userProvider.getUsuario(doc["idUser"]))!,
        items: items,
      ));
    }
    notifyListeners();
    return sales;
  }

  // Future<List<ItemVenda>> listItems(int idVenda) async {
  //   List itensList = await db
  //       .query("itemVenda_view", where: "idVenda = ?", whereArgs: [idVenda]);
  //   var itensVenda = List.generate(itensList.length, (index) {
  //     return ItemVenda.fromMap(itensList[index]);
  //   });
  //   return itensVenda;
  // }

  Future<Sell> saveSell(Sell sell) async {
    DocumentReference<Map<String, dynamic>> document = await db.collection(tabelaVenda).add(sell.toMap());
    sell.id = document.id;
    sales.add(sell);
    notifyListeners();
    return sell;
  }

  Future<ItemVenda> saveItem(Sell sell, ItemVenda item) async {
    DocumentReference<Map<String, dynamic>> document = await db.collection(tabelaVenda).doc(sell.id).collection("items").add(item.toMap());
    item.id = document.id;
    sell.items.add(item);
    notifyListeners();
    return item;
  }

  Future<void> buy(List<ItemVenda> itens, UsuarioFirebase user) async {
    // create Venda and get id
    Sell venda = Sell(
      id: "",
      date: DateTime.now().toString(),
      user: user,
    );
    await saveSell(venda);
    try {
      for (ItemVenda item in itens) {
        await saveItem(venda, item);
      }
    } catch (e) {
      for (var item in venda.items) {
        await db.collection(tabelaVenda).doc(venda.id).collection("items").doc(item.id).delete();
      }
      await db.collection(tabelaVenda).doc(venda.id).delete();
    }
    // update quantity from product
    for (ItemVenda item in itens) {
      item.produto.quantity = item.produto.quantity - item.quantity;
      await _productProvider.updateProduct(item.produto);
    }
  }
}
