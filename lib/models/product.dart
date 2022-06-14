import 'package:flutter/material.dart';

class Product {
  final int productId;
  final String name;
  final int price;
  final String description;
  final int categoryId;
  late final List<Color> colorsList;
  final List<String> imagesList;
  Product(this.productId, this.name, this.price, this.description,
      this.categoryId, List<String> colorsStringList, this.imagesList) {
    colorsList = colorsStringList
        .map((colorString) => colorFromString(colorString))
        .toList();
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        json['product_id'],
        json['name'],
        json['price'],
        json['description'],
        json['categoryId'],
        json['colorsList'].cast<String>(),
        json['imagesList'].cast<String>());
  }
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'price': price,
      'description': description,
      'categoryId': categoryId,
      'colorsList': colorsList.map((e) => colorToString(e)).toList(),
      'imagesList': imagesList
    };
  }

  Product productElement() {
    return this;
  }
}

Color colorFromString(String colorString) {
  switch (colorString) {
    case 'red':
      return Colors.red;
    case 'green':
      return Colors.green;
    case 'blue':
      return Colors.blue;
    case 'white':
      return Colors.white;
    case 'black':
      return Colors.black;
    case 'purple':
      return Colors.purple;
    case 'orange':
      return Colors.orange;
    case 'indigo':
      return Colors.indigo;
    case 'teal':
      return Colors.teal;
    case 'grey':
      return Colors.grey;
    case 'amber':
      return Colors.amber;
    case 'cyan':
      return Colors.cyan;
    case 'brown':
      return Colors.brown;
    case 'lime':
      return Colors.lime;
    case 'pink':
      return Colors.pink;
    case 'yellow':
      return Colors.yellow;
    default:
      return Colors.white;
  }
}

String colorToString(Color color) {
  if (color == Colors.red) {
    return "red";
  } else if (color == Colors.green) {
    return "green";
  } else if (color == Colors.blue) {
    return "blue";
  } else if (color == Colors.white) {
    return "white";
  } else if (color == Colors.black) {
    return "black";
  } else if (color == Colors.purple) {
    return "purple";
  } else if (color == Colors.orange) {
    return "orange";
  } else if (color == Colors.indigo) {
    return "indigo";
  } else if (color == Colors.teal) {
    return "teal";
  } else if (color == Colors.grey) {
    return "grey";
  } else if (color == Colors.amber) {
    return "amber";
  } else if (color == Colors.cyan) {
    return "cyan";
  } else if (color == Colors.brown) {
    return "brown";
  } else if (color == Colors.lime) {
    return "lime";
  } else if (color == Colors.pink) {
    return "pink";
  } else if (color == Colors.yellow) {
    return "yellow";
  } else {
    return "white";
  }
}
