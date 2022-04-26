class Product {
  int id;
  String name;
  String description;
  String image;
  double price;
  int quantity;
  int idFornecedor;

  Product({
    this.id = 0,
    required this.name,
    this.description = "",
    this.image = "",
    this.price = 0.0,
    required this.idFornecedor,
    this.quantity = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "image": image,
      "price": price,
    };
  }
}
