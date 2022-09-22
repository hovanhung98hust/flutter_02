import 'package:flutter/material.dart';

class ProductModel {
  String? name;
  Color? color;
  int? price;

  ProductModel({this.name, this.color, this.price});

  @override
  bool operator ==(Object other) {
    return (other is ProductModel) &&
        other.name == name &&
        other.price == price;
  }


}
