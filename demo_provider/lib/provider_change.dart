import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderChange extends StatefulWidget {
  const ProviderChange({Key? key}) : super(key: key);

  @override
  State<ProviderChange> createState() => _ProviderChangeState();
}

class _ProviderChangeState extends State<ProviderChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${context.watch<ProductModel>().name}'),
          Consumer<ProductModel>(builder: (context, model, _) {
            print('builder');
            return Text('${model.name}');
          }),
          InkWell(
            onTap: () {
              String name = context.read<ProductModel>().name ?? '';
              // String name = context.read<TodoModel>().name ?? '';
              print('name: $name');
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Bat dau lay du lieu'),
            ),
          ),
          InkWell(
            onTap: () {
              context.read<ProductModel>().updateName('Todo model 2');
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Update du lieu moi'),
            ),
          ),

        ],
      ),
    );
  }
}

class ProductModel extends ChangeNotifier {
  String? name;

  ProductModel({this.name});

  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }
}
