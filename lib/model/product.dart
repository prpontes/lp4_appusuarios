import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/fornecedor.dart';
import 'package:palette_generator/palette_generator.dart';

class Product {
  int? id;
  String name;
  String description;
  String image;
  double price;
  int quantity;
  Fornecedor fornecedor;
  Color mainColor;

  Product({
    this.id,
    required this.name,
    this.description = "",
    this.image = "",
    this.price = 0.0,
    this.quantity = 0,
    required this.fornecedor,
    this.mainColor = Colors.deepPurple,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "image": image,
      "price": price,
      "quantity": quantity,
      "idFornecedor": fornecedor.id,
    };
  }

  Future<Product> getMainColorFromImage() async {
    try {
      if (image != "") {
        PaletteGenerator paletteGenerator =
            await PaletteGenerator.fromImageProvider(NetworkImage(image));
        if (paletteGenerator.dominantColor!.color.computeLuminance() > 0.5) {
          mainColor = HSLColor.fromColor(paletteGenerator.dominantColor!.color)
              .withLightness(0.5)
              .toColor();
        } else {
          mainColor = paletteGenerator.dominantColor!.color;
        }
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
