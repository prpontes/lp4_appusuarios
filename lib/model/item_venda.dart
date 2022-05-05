class ItemVenda {
  // model venda
  int? id;
  int quantity;
  double price;
  String? produto;
  String? usuario;
  int? idProduto;
  int? idVenda;

  ItemVenda({
    this.id,
    this.usuario,
    this.produto,
    this.quantity = 1,
    this.price = 0,
    this.idProduto,
    this.idVenda,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "produto": produto,
      "usuario": usuario,
      "quantity": quantity,
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
