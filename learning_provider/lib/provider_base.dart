import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderBaseScreen extends StatefulWidget {
  const ProviderBaseScreen({Key? key}) : super(key: key);

  @override
  State<ProviderBaseScreen> createState() => _ProviderBaseScreenState();
}

class _ProviderBaseScreenState extends State<ProviderBaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: InkWell(
            onTap: () {
              Student student = context.read<Student>();
            },
            child: Text('Bat dau su dung student'),
          ),
        ),
      ),
    );
  }
}

class Student {
  String? name;

  Student({this.name}) {
    print('Khoi tao Student');
  }
}
