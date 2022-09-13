import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/counter_cubit.dart';
import 'package:learning_bloc/demo_category/category_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const CategoryScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CounterCubit _counterCubit = CounterCubit();

  void _incrementCounter() {
    // setState(() {
    //   _counter++;
    // });
  }

  @override
  Widget build(BuildContext context) {
    print('on build running');
    return BlocProvider<CounterCubit>(
      create: (_) => _counterCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocListener<CounterCubit, int>(
                // bloc: _counterCubit,  // có thể bỏ đi nếu widget có BlocProvider
                listener: (context, state) {
                  // print('')
                  // print('on listener running: ${state}');
                },
                child: const SizedBox(),
              ),
              BlocBuilder<CounterCubit, int>(
                // bloc: _counterCubit,  // có thể bỏ đi nếu widget có BlocProvider
                buildWhen: (context, state) {
                  if (state % 5 == 0) {
                    print('lucky number');
                  }
                  return state % 5 != 0;
                },
                builder: (BuildContext context, int state) {
                  print('on builder running: ${state.runtimeType}');
                  return Text(
                    '${_counterCubit.counter}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      child: Text('Cong'),
                      onTap: () {
                        _counterCubit.increment();
                      }),
                  GestureDetector(
                      child: Text('Tru'),
                      onTap: () {
                        _counterCubit.decrement();
                      }),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
