class Product {
  int? id;
  String name;
  String description;
  String image;
  double price;
  int idFornecedor;
  int quantity;

  Product({
    this.id,
    required this.name,
    this.description = "",
    this.image = "",
    this.price = 0.0,
    this.idFornecedor = -1,
    this.quantity = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "image": image,
      "price": price,
      "idFornecedor": idFornecedor,
      "quantity": quantity,
    };
  }
}
