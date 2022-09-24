import 'package:flutter/material.dart';
import 'package:learning_provider/counter_screen.dart';
import 'package:learning_provider/provider_base.dart';
import 'package:learning_provider/provider_change.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(Provider(
  //   create: (_) {
  //     return Student(name: 'Nguyen van A');
  //   },
  //   lazy: false,
  //   child: MaterialApp(
  //     home: ProviderBaseScreen(),
  //   ),
  // ));

  // runApp(ChangeNotifierProvider(
  //   create: (_) {
  //     return ProductProvider(name: 'Banh mi');
  //   },
  //   lazy: false,
  //   child: MaterialApp(
  //     home: ProviderChangeScreen(),
  //   ),
  // ));

  runApp(ChangeNotifierProvider(
    create: (_) {
      return CounterProvider();
    },
    lazy: false,
    child: MaterialApp(
      home: CounterScreen(),
    ),
  ));


}
