// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

class ItemVenda  {
  // model venda
  int? id;
  int? quantity;
  Float? price;
  String? produto;
  String? usuario;
  int? idProduto;
  int? idVenda;


  ItemVenda({
    this.id,
    this.usuario,
    this.produto,
    this.quantity,
    this.price,
    this.idProduto,
    this.idVenda
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "produto":produto,
      "usuario":usuario,
      "quantity":quantity,
      "price": price,
      "idProduto": idProduto,
      "idVenda": idVenda
    };
  }

  @override
  String toString() {
    return 'itemVenda{id: $id, quantity: $quantity, idProduto: $idProduto, idVenda: $idVenda, usuario: $usuario, produto: $produto}';
  }
}
