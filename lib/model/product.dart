import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class Product {
  int? id;
  String name;
  String description;
  String image;
  double price;
  int idFornecedor;
  Color mainColor;

  Product({
    this.id,
    required this.name,
    this.description = "",
    this.image = "",
    this.price = 0.0,
    this.idFornecedor = -1,
    this.mainColor = Colors.deepPurple,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "image": image,
      "price": price,
      "idFornecedor": idFornecedor,
    };
  }

  Future<Product> getMainColorFromImage() async {
    try {
      if (image != "") {
        PaletteGenerator paletteGenerator =
            await PaletteGenerator.fromImageProvider(NetworkImage(image));
        mainColor = paletteGenerator.vibrantColor!.color;
        return this;
      }
      throw Exception();
    } catch (e) {
      image = "";
      mainColor = Colors.deepPurple;
    }
    return this;
  }
}
