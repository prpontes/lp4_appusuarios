import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/product.dart';
import 'package:lp4_appusuarios/singletons/database_singleton.dart';
import 'package:sqflite/sqflite.dart';

class ProductProvider extends ChangeNotifier {
  Database db = DatabaseSingleton.instance.db;
  String tableName = "product";

  List<Product> products = [];

  Future<List<Product>> getProducts() async {
    List productsList = await db.query(tableName);
    products = List.empty(growable: true);
    for (var product in productsList) {
      products.add(
        await Product(
          id: product["id"],
          name: product["name"],
          description: product["description"],
          price: product["price"],
          image: product["image"],
          idFornecedor: product["idFornecedor"],
        ).getMainColorFromImage(),
      );
    }

    notifyListeners();
    return products;
  }

  Future<Product?> getProduct(int id) async {
    List resultado =
        await db.query(tableName, where: "id = ?", whereArgs: [id]);

    if (resultado.isNotEmpty) {
      return await Product(
        id: resultado[0]["id"],
        name: resultado[0]["name"],
        description: resultado[0]["description"],
        price: resultado[0]["price"],
        image: resultado[0]["image"],
        idFornecedor: resultado[0]["idFornecedor"],
      ).getMainColorFromImage();
    } else {
      return null;
    }
  }

  Future<bool> createProduct(Product product) async {
    debugPrint(product.toMap().toString());
    int id = await db.insert(tableName, product.toMap());
    if (id != 0) {
      product.id = id;
      products.add(product);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> updateProduct(Product product) async {
    int result = await db.update(tableName, product.toMap(),
        where: "id = ?", whereArgs: [product.id]);
    if (result > 0) {
      await getProducts();
      return true;
    } else {
      debugPrint("Não foi possível atualizar o produto");
      return false;
    }
  }

  Future<bool> deleteProduct(Product product) async {
    int result =
        await db.delete(tableName, where: "id = ?", whereArgs: [product.id]);
    if (result > 0) {
      await getProducts();
      return true;
    } else {
      debugPrint("Não foi possível deletar o produto");
      return false;
    }
  }
}
