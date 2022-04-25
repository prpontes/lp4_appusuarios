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

    products = List.generate(productsList.length, (index) {
      return Product(
        id: productsList[index]["id"],
        name: productsList[index]["name"],
        description: productsList[index]["description"],
        price: productsList[index]["price"],
        image: productsList[index]["image"],
      );
    });
    notifyListeners();
    return products;
  }

  Future<Product?> getProduct(int id) async {
    List resultado =
        await db.query(tableName, where: "id = ?", whereArgs: [id]);

    if (resultado.isNotEmpty) {
      return Product(
        id: resultado[0]["id"],
        name: resultado[0]["name"],
        description: resultado[0]["description"],
        price: resultado[0]["price"],
        image: resultado[0]["image"],
      );
    } else {
      return null;
    }
  }

  Future<int> createProduct(Product product) async {
    int id = await db.insert(tableName, product.toMap());
    product.id = id;
    products.add(product);
    notifyListeners();
    return id;
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

  Future<bool> deleteProduct(int productId) async {
    int result =
        await db.delete(tableName, where: "id = ?", whereArgs: [productId]);
    if (result > 0) {
      await getProducts();
      return true;
    } else {
      debugPrint("Não foi possível deletar o produto");
      return false;
    }
  }
}
