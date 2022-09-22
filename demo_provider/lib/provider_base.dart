import 'package:demo_provider/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DemoProviderBase extends StatefulWidget {
  const DemoProviderBase({Key? key}) : super(key: key);

  @override
  State<DemoProviderBase> createState() => _DemoProviderBaseState();
}

class _DemoProviderBaseState extends State<DemoProviderBase> {
  @override
  Widget build(BuildContext context) {
    String name = context.read<Student>().name ?? '';
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${name}'),
            InkWell(
              onTap: () {
                String name = context.watch<Student>().name ?? '';
                print('name: $name');
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Bat dau lay du lieu'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Student {
  String? name;

  Student({this.name}) {
    print('Khoi taoj student');
  }
}
