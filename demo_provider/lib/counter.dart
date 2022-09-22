import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    print('Hello world');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CounterProvider>(builder: (context, model, _) {
              print('builder');
              return Text('${model.counter}');
            }),
            // Text(
            //   '${context.watch<CounterProvider>().counter}',
            //   style: TextStyle(fontSize: 20),
            // ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    context.read<CounterProvider>().inCrease();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.add,
                      size: 40,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<CounterProvider>().deCrease();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.text_decrease_outlined,
                      size: 40,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CounterProvider extends ChangeNotifier {
  int counter = 0;

  // +
  void inCrease() {
    counter = counter + 1;
    notifyListeners();
  }

  // -
  void deCrease() {
    counter = counter - 1;
    notifyListeners();
  }
}
