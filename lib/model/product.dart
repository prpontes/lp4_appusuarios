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
  late Fornecedor fornecedor;
  Color mainColor;

  Product({
    this.id,
    required this.name,
    this.description = "",
    this.image = "",
    this.price = 0.0,
    this.quantity = 0,
    fornecedor,
    this.mainColor = Colors.deepPurple,
  }) {
    this.fornecedor = fornecedor ?? Fornecedor();
  }

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
        if (paletteGenerator.dominantColor!.color.computeLuminance() > 0.6) {
          mainColor = HSLColor.fromColor(paletteGenerator.dominantColor!.color)
              .withLightness(0.6)
              .toColor();
        } else if (paletteGenerator.dominantColor!.color.computeLuminance() <=
            0.1) {
          if (paletteGenerator.vibrantColor != null) {
            mainColor =
                paletteGenerator.vibrantColor!.color.computeLuminance() <= 0.45
                    ? paletteGenerator.vibrantColor!.color
                    : HSLColor.fromColor(paletteGenerator.vibrantColor!.color)
                        .withLightness(0.45)
                        .toColor();
          } else {
            mainColor =
                HSLColor.fromColor(paletteGenerator.dominantColor!.color)
                    .withLightness(0.2)
                    .toColor();
          }
        } else {
          mainColor = paletteGenerator.dominantColor!.color;
        }
        return this;
      }
      throw Exception();
    } catch (e) {
      image = "";
    }
    return this;
  }
}
