import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogBloc extends Cubit<CatalogState> {
  CatalogBloc() : super(CatalogInitState());
  static List<String> itemNames = [
    'Gà KFC',
    'Trà sữa',
    'Vịt quay bắc kinh',
    'Sữa chua hạ long',
    'Gà ủ muối',
    'Bia Tiger',
    'Spaghetti',
    'Pizza',
    'Bánh mì hội an',
    'Phở thìn',
    'Chân gà',
    'Coffee',
    'Trà',
    'Xôi',
    'Cơm',
  ];
  List<Item> listItems = [];

  List<Item> getListItems() {
    if (listItems.isNotEmpty) {
      return listItems;
    }
    for (int i = 0; i < itemNames.length; i++) {
      listItems.add(Item(i, itemNames[i]));
    }
    return listItems;
  }
}

class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  Item(this.id, this.name)
      // To make the sample app look nicer, each item is given one of the
      // Material Design primary colors.
      : color = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  bool operator ==(Object other) => other is Item && other.id == id;

// @override
// int get hashCode => id;

}

abstract class CatalogState {}

class CatalogInitState extends CatalogState {}
