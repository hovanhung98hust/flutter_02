import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  int counter = 0;

  void increment() {
    counter = counter + 1;
    emit(counter);
  }

  void decrement() {
    counter = counter - 1;
    emit(counter);
  }
}
//
// class CounterState {
//   final String? dataString;
//   final int? dataInt;
//
//   CounterState({this.dataString, this.dataInt});
// }
//
// class CounterInitState extends CounterState {}
