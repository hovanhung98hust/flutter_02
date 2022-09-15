import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/todo_list/bloc/todo_list_state.dart';
import 'package:learning_bloc/todo_list/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListInitState());
  List<TodoModel> listTodo = [];
  SharedPreferences? sharedPreferences;

  // List<String> listStringFoods = [
  //   'Com',
  //   'Chao',
  //   'Pho',
  //   'Ga',...
  // ];

  void createItemTodo(String name) async {
    for (final obj in listTodo) {
      if (obj.name == name) {
        print('Đã bị trùng tên');
        return;
      }
    }
    emit(TodoListCreatingState());
    final model = TodoModel(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      dateTime: DateTime.now().millisecondsSinceEpoch,
    );
    listTodo.add(model);
    await saveDataToLocal();
    emit(TodoListCreatedState());
  }

  void removeItemTodo(String id) async {
    listTodo.removeWhere((element) => element.id == id);
    await saveDataToLocal();
    emit(TodoListCreatedState());
  }

  void getDataFromLocal() async {
    emit(TodoListLoadingState());
    await Future.delayed(Duration(seconds: 2));
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    List<String>? listStringLocal =
        sharedPreferences!.getStringList('saveDataToLocal');
    if (listStringLocal != null && listStringLocal.isNotEmpty) {
      for (String obj in listStringLocal) {
        final model = TodoModel.fromStringLocal(obj);
        listTodo.add(model);
      }
    }
    emit(TodoListGetSuccessState());
  }

  // Lưu list todo vào local storage
  Future saveDataToLocal() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    List<String> listDataString = [];
    for (TodoModel obj in listTodo) {
      listDataString.add(obj.convertJsonToString());
    }
    await sharedPreferences!.setStringList('saveDataToLocal', listDataString);
  }

  void emitToUpdateUi() {
    emit(TodoListGetSuccessState());
  }

  void updateItemInListToDo(TodoModel todoModel, String newName) {
    for (int i = 0; i < listTodo.length; i++) {
      if (listTodo[i].id == todoModel.id) {
        listTodo[i].name = newName;
        listTodo[i].dateTime = DateTime.now().millisecondsSinceEpoch;
      }
    }
    saveDataToLocal();
    emit(TodoListGetSuccessState());
  }
}
