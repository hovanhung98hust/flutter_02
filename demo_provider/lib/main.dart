import 'package:demo_provider/counter.dart';
import 'package:demo_provider/provider_base.dart';
import 'package:demo_provider/provider_change.dart';
import 'package:demo_provider/todo_list/todo_list_screen.dart';
import 'package:demo_provider/todo_list/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(MaterialApp(
  //   home: Provider(
  //     lazy: true,
  //     create: (_) => Student(name: 'Student 1'),
  //     child: DemoProviderBase(),
  //   ),
  // ));

  // runApp(MaterialApp(
  //   home: ChangeNotifierProvider<TodoModel>(
  //     create: (_) => TodoModel(name: 'Todo 1'),
  //     lazy: true,
  //     child: ProviderChange(),
  //   ),
  // ));

  // runApp(MaterialApp(
  //   home: ChangeNotifierProvider<CounterProvider>(
  //     create: (_) => CounterProvider(),
  //     lazy: true,
  //     child: CounterScreen(),
  //   ),
  // ));

  runApp(MaterialApp(
    home: ChangeNotifierProvider<TodoProvider>(
      create: (_) => TodoProvider(),
      lazy: true,
      child: TodoListScreen(),
    ),
  ));
}

// class DemoProvider extends StatefulWidget {
//   const DemoProvider({Key? key}) : super(key: key);
//
//   @override
//   State<DemoProvider> createState() => _DemoProviderState();
// }
//
// class _DemoProviderState extends State<DemoProvider> {
//   String _name = 'Hello world';
//   Student _student = Student(name: 'Test 1');
//
//   @override
//   Widget build(BuildContext context) {
//     // Student student = Student(name: 'Test 1');
//     return const SizedBox();
//         // Provider(
//         // create: (_) => Student(name: 'Test 1'),
//         // lazy: false,
//         // child:
//     //     ChangeNotifierProvider<Student>(
//     //   create: (_) => _student,
//     //   child: Scaffold(
//     //     body: Column(
//     //       mainAxisAlignment: MainAxisAlignment.center,
//     //       children: [
//     //         // Text('1: ${context.read<Student>().name}'),
//     //         MyChildWidget(),
//     //         InkWell(
//     //           onTap: () {
//     //             // setState(() {
//     //             //   _student = Student(name: 'Test new');
//     //             // });
//     //             _student.setNewData('newName');
//     //           },
//     //           child: Padding(
//     //             padding: const EdgeInsets.all(8.0),
//     //             child: Text('Clcik to update student'),
//     //           ),
//     //         ),
//     //         // ProxyProvider(
//     //         //     update: (_, a) => Student(name: _name),
//     //         //     child: const SizedBox(),
//     //         // )
//     //       ],
//     //     ),
//     //   ),
//     //   // ),
//     // );
//   }
// }
//
// class MyChildWidget extends StatelessWidget {
//   const MyChildWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             InkWell(
//               child: Text('${context.watch<Student>().name}'),
//               // child: Text('hello world'),
//               onTap: () {
//                 // String text = '${context.read<Student>().name}';
//               },
//             ),
//             Consumer<Student>(builder: (context, model, _) {
//               return Text('${model.name}');
//             })
//             // Text('${Provider.of<Student>(context).name}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class Student    {
//   String? name;
//
//   Student({this.name}) {
//     print('Khoi taoj student');
//   }
//
//   // void setNewData(String newName) {
//   //   this.name = newName;
//   //   notifyListeners();
//   // }
// }
