import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/fornecedorFirebase.dart';
import 'package:lp4_appusuarios/model/product.dart';

enum ProductsState { loading, complete }

class ProductProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String tableName = "product";

  List<Product> products = [];
  ProductsState productsState = ProductsState.loading;

  Future<List<Product>> getProducts({int minQuantity = 0}) async {
    productsState = ProductsState.loading;

    var query = await db.collection(tableName).get();
    products = List.empty(growable: true);
    for (var doc in query.docs) {
      if (doc["quantity"] >= minQuantity) {
        var documentFornecedor =
            await db.collection("fornecedor").doc(doc["idFornecedor"]).get();
        products.add(
          await Product(
            id: doc.id,
            name: doc["name"],
            description: doc["description"],
            price: doc["price"],
            image: doc["image"],
            quantity: doc["quantity"],
            fornecedor: FornecedorFirebase(
              razaoSocial: documentFornecedor["razaoSocial"],
              id: documentFornecedor.id,
            ),
          ).getMainColorFromImage(),
        );
      }
    }
    notifyListeners();
    productsState = ProductsState.complete;
    return products;
  }

  Future<Product?> getProduct(Product product) async {
    try {
      var documentProduct =
          await db.collection(tableName).doc(product.id).get();
      var documentFornecedor =
          await db.collection("fornecedor").doc(product.fornecedor.id).get();
      return await Product(
        id: documentProduct.id,
        name: documentProduct["name"],
        description: documentProduct["description"],
        price: documentProduct["price"],
        image: documentProduct["image"],
        quantity: documentProduct["quantity"],
        fornecedor: FornecedorFirebase(
          id: documentFornecedor.id,
          razaoSocial: documentFornecedor["razaosocial"],
        ),
      ).getMainColorFromImage();
    } catch (e) {
      return null;
    }
  }

  Future<bool> createProduct(Product product) async {
    try {
      DocumentReference<Map<String, dynamic>> document =
          await db.collection(tableName).add(product.toMap());
      product.id = document.id;
      products.add(product);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateProduct(Product product) async {
    try {
      await db.collection(tableName).doc(product.id!).update(product.toMap());
      await getProducts();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteProduct(Product product) async {
    try {
      await db.collection(tableName).doc(product.id).delete();
      await getProducts();
      products.remove(product);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
