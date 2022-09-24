import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderChangeScreen extends StatefulWidget {
  const ProviderChangeScreen({Key? key}) : super(key: key);

  @override
  State<ProviderChangeScreen> createState() => _ProviderChangeScreenState();
}

class _ProviderChangeScreenState extends State<ProviderChangeScreen> {
  @override
  Widget build(BuildContext context) {
    String name = context.read<ProductProvider>().name??'';
    // print('_ProviderChangeScreenState build');
    // BlocProvider.of<ProductProvider>(context);
    // context.watch<ProductProvider>()
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('${name}'),
          // TextChild(),
          Text('${context.watch<ProductProvider>().name}'),
          // Consumer<ProductProvider>(
          //   builder: (context, model, _) {
          //     // chỉ được gọi khi ProductProvider thay đổi
          //     print('builder');
          //     if(model.currentStatus=='A'){
          //       return CircularProgressIndicator();
          //     }
          //     if(model.currentStatus=='B'){
          //       return ListView();
          //     }
          //     return Text('${model.name}');
          //   },
          // ),
          InkWell(
            onTap: () {
              context.read<ProductProvider>().updateName('Com suon');
            },
            child: Text('Cap nhat ten moi'),
          ),
        ],
      ),
    );
  }
}

class TextChild extends StatelessWidget {
  const TextChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('${context.read<ProductProvider>().name}');
  }
}

class ProductProvider extends ChangeNotifier {
  String? name;
  int currentStatus = 0;

  ProductProvider({this.name});

  void updateName(String newName) {
    name = newName;
    if (name == 'A') {
      currentStatus = 1;
    }
    if (name == 'B') {
      currentStatus = 2;
    }
    // thay đổi ProductProvider và truyền tín hiệu tới tất cả những thằng đang lắng nghe nó
    notifyListeners();
  }
}
