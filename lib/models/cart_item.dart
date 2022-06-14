import 'package:flutter/material.dart';
import 'package:timberr/models/product.dart';

class CartItem extends Product {
  int cartId;
  int quantity;
  late Color color;
  CartItem(
      this.cartId, this.quantity, String colorString, Map<String, dynamic> json)
      : super(
          json['product_id'],
          json['name'],
          json['price'],
          json['description'],
          json['categoryId'],
          json['colorsList'].cast<String>(),
          json['imagesList'].cast<String>(),
        ) {
    color = colorFromString(colorString);
  }
  void addQuantity(int newQuantity) {
    quantity += newQuantity;
  }

  void removeQuantity(int newQuantity) {
    quantity -= newQuantity;
  }

  Product getProduct() {
    return super.productElement();
  }
}
