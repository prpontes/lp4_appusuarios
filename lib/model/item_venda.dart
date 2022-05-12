import 'package:lp4_appusuarios/model/product.dart';
import 'package:lp4_appusuarios/model/sell.dart';

class ItemVenda {
  // model venda
  int? id;
  int quantity;
  double price;
  Product? produto;
  Sell? venda;
  int? idProduto;
  int? idVenda;

  ItemVenda({
    this.id,
    this.venda,
    this.produto,
    this.quantity = 1,
    this.price = 0,
    this.idProduto,
    this.idVenda,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "quantity": quantity,
      "price": price,
      "idProduto": idProduto,
      "idVenda": idVenda
    };
  }

  static ItemVenda fromMap(Map<String, dynamic> map) {
    return ItemVenda(
      id: map["id"],
      quantity: map["quantity"],
      price: map["price"],
      produto: Product(
        id: map["idProduct"],
        name: map["name"],
        price: map["price"],
        description: map["description"] ?? "",
        image: map["image"],
      ),
    );
  }

  @override
  String toString() {
    return 'itemVenda{id: $id, quantity: $quantity, idProduto: $idProduto, idVenda: $idVenda, venda: $venda, produto: ${produto.toString()}}';
  }
}
