import 'dart:core';

class CartModels {
  final String productName;
  final int productPrice;
  final String categoryName;
  final String image;
         int quantity;
  final int instock;
  final String productId;
  final String productSize;
  final int discount;
  final String description;

  // cartModel constructor
  CartModels({required this.productName, required this.productPrice, required this.categoryName, required this.image, required this.quantity, required this.instock, required this.productId, required this.productSize, required this.discount, required this.description});
}