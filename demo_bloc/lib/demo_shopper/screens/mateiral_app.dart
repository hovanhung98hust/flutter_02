import 'package:demo_bloc/demo_shopper/blocs/cart_bloc.dart';
import 'package:demo_bloc/demo_shopper/screens/cart.dart';
import 'package:demo_bloc/demo_shopper/screens/catalog.dart';
import 'package:demo_bloc/demo_shopper/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyMaterialApp extends StatefulWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  State<MyMaterialApp> createState() => _MaterialAppState();
}

class _MaterialAppState extends State<MyMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=> CartBloc(),
      child: MaterialApp(
        routes: {
          '/': (context) => const MyCatalog(),
          // '/catalog': (context) => const MyCatalog(),
          '/cart': (context) => const MyCart(),
        },
      ),
    );
  }
}
