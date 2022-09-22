import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop/list_product/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListProductCubit extends Cubit<ProductState> {
  ListProductCubit() : super(ProductInitState());

  List<ProductModel> listProduct = [];
  List<ProductModel> listProductSelected = [];
  SharedPreferences? preferences;

  void addItemToCart(ProductModel model) async {
    if (!listProductSelected.contains(model)) {
      listProductSelected.add(model);
      emit(ProductGetSuccessState());
    }
    saveListProductSelected();
  }

  // xóa 1 item trong list product đã chọn
  void onRemoveItemSelected(ProductModel model) {
    listProductSelected.remove(model);
    emit(ProductGetSuccessState());
    saveListProductSelected();
  }

  void updateDataSelectedNew(List<ProductModel> newSelected) {
    listProductSelected = newSelected;
    emit(ProductGetSuccessState());
    saveListProductSelected();
  }

  Future convertListStringToListModel() async {
    // phát tín hiệu đang xử lý
    emit(ProductGettingState());
    await Future.delayed(Duration(seconds: 2));
    for (int i = 0; i < itemNames.length; i++) {
      String item = itemNames[i];
      // Tạo Product model rỗng
      ProductModel model = ProductModel();

      // gán dữ liệu cho model rỗng vừa tạo
      model.name = item;
      model.price = 12;
      Random random = Random();
      model.color = Color.fromRGBO(
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255),
        1,
      );

      // thêm model vừa convert vào list
      listProduct.add(model);
    }

    // phát tín hiệu đã xử lý xong
    emit(ProductGetSuccessState());
  }

  Future saveListProductSelected() async {
    List<String> listDataString = [];

    for (ProductModel productModel in listProductSelected) {
      // b1: chuyen Model ve Map
      Map<String, dynamic> dataJson = Map<String, dynamic>();
      dataJson['name'] = productModel.name;
      dataJson['price'] = productModel.price;
      // chuyển Color về dạng dữ liệu nguyên thủy để có thể lưu đc = SharePreferance
      int colorValue = productModel.color!.value;
      dataJson['color'] = colorValue;

      // b2: chuyển Map thành String
      String dataString = jsonEncode(dataJson);

      listDataString.add(dataString);
    }
    if (preferences == null) {
      preferences = await SharedPreferences.getInstance();
    }
    preferences!.setStringList('dataProductCart', listDataString);
  }

  Future getListProductSelected() async {
    if (preferences == null) {
      preferences = await SharedPreferences.getInstance();
    }
    List<String>? dataListString =
        preferences!.getStringList('dataProductCart');
    if (dataListString != null) {
      for (String obj in dataListString) {
        // b1 chuyen string ve map
        Map<String, dynamic> dataMap = jsonDecode(obj);

        // b2 chuyen map ve model
        ProductModel productModel = ProductModel();
        productModel.name = dataMap['name'];
        productModel.price = dataMap['price'];
        productModel.color = Color(dataMap['color']);
        listProductSelected.add(productModel);
      }
    }
    emit(ProductGetSuccessState());
  }

  List<String> itemNames = [
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
}

class ProductState {}

class ProductInitState extends ProductState {}

// tins hiệu đang xử lý dữ liệu
class ProductGettingState extends ProductState {}

// Tín hiệu đã xử lý thành công dữ liệu
class ProductGetSuccessState extends ProductState {}

class MyTestColorScreen extends StatefulWidget {
  const MyTestColorScreen({Key? key}) : super(key: key);

  @override
  State<MyTestColorScreen> createState() => _MyTestColorScreenState();
}

class _MyTestColorScreenState extends State<MyTestColorScreen> {
  @override
  Widget build(BuildContext context) {
    int colorValue = Colors.red.value;
    Color colorSaved = Color(colorValue);
    return Scaffold(
      body: Container(
        width: 100,
        height: 100,
        color: colorSaved,
      ),
    );
  }
}
