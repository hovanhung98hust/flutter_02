import 'package:demo_bloc/demo_shopper/blocs/catalog_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Cubit<CartState> {
  CartBloc() : super(CartInitState());

  /// Internal, private state of the cart. Stores the ids of each item.
  final List<Item> _items = [];

  /// List of items in the cart.
  List<Item> get items => _items;

  /// The current total price of all items.
  int get totalPrice =>
      _items.fold(0, (total, current) => total + current.price);

  void add(Item item) {
    _items.add(item);
    emit(CartRebuildState());
  }

  void remove(Item item) {
    _items.removeWhere((element) => element.id == item.id);
    emit(CartRebuildState());
  }
  bool checkContain(Item item){
    return _items.contains(item);
  }
}

abstract class CartState {}

class CartInitState extends CartState {}

class CartRebuildState extends CartState {}
