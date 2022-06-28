import 'package:lp4_appusuarios/model/product.dart';

class ItemVenda {
  // model venda
  String id;
  int quantity;
  double price;
  Product produto;

  ItemVenda({
    required this.id,
    required this.produto,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      "quantity": quantity,
      "price": price,
      "idProduto": produto.id,
    };
  }

  static ItemVenda fromMap(String id, Map<String, dynamic> map, Product product) {
    return ItemVenda(
      id: id,
      quantity: map["quantity"],
      price: map["price"],
      produto: product,
    );
  }
}
