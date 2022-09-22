import 'dart:convert';

import 'package:demo_provider/todo_list/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> listTodo = [];
  SharedPreferences? sharedPreferences;
  StatusTodoProvider? currentStatus;

  void createItemTodo(String name) async {
    for (final obj in listTodo) {
      if (obj.name == name) {
        print('Đã bị trùng tên');
        return;
      }
    }
    currentStatus = StatusTodoProvider.todoListCreating;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    final model = TodoModel(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      dateTime: DateTime.now().millisecondsSinceEpoch,
    );
    listTodo.add(model);
    await saveDataToLocal();
    currentStatus = StatusTodoProvider.todoListCreated;
    notifyListeners();
  }

  void removeItemTodo(String id) async {
    listTodo.removeWhere((element) => element.id == id);
    await saveDataToLocal();
    currentStatus = StatusTodoProvider.todoListCreated;
    notifyListeners();
  }

  void getDataFromLocal() async {
    currentStatus = StatusTodoProvider.todoListLoading;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    List<String>? listStringLocal =
        sharedPreferences!.getStringList('saveDataToLocal');
    if (listStringLocal != null && listStringLocal.isNotEmpty) {
      for (String obj in listStringLocal) {
        Map<String, dynamic> dataJson = jsonDecode(obj);
        TodoModel model = TodoModel();
        model.name = dataJson['name'];
        model.id = dataJson['id'];
        model.dateTime = dataJson['dateTime'];

        listTodo.add(model);
      }
    }
    currentStatus = StatusTodoProvider.todoListGetSuccess;
    notifyListeners();
  }

  // Lưu list todo vào local storage
  Future saveDataToLocal() async {
    // int, double, string, bool, List<String>
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    List<String> listDataString = [];
    for (TodoModel model in listTodo) {
      // buoc 1
      Map<String, dynamic> dataJson = Map<String, dynamic>();
      dataJson['name'] = model.name;
      dataJson['id'] = model.id;
      dataJson['dateTime'] = model.dateTime;

      // buoc 2
      String dataString = jsonEncode(dataJson);
      listDataString.add(dataString);
    }
    await sharedPreferences!.setStringList('saveDataToLocal', listDataString);
  }

  void emitToUpdateUi([StatusTodoProvider? status]) {
    currentStatus = StatusTodoProvider.todoListGetSuccess;
    notifyListeners();
  }

  void updateItemInListToDo(TodoModel todoModel, String newName) {
    for (int i = 0; i < listTodo.length; i++) {
      if (listTodo[i].id == todoModel.id) {
        listTodo[i].name = newName;
        listTodo[i].dateTime = DateTime.now().millisecondsSinceEpoch;
      }
    }
    saveDataToLocal();
    currentStatus = StatusTodoProvider.todoListGetSuccess;
    notifyListeners();
  }
}

enum StatusTodoProvider {
  todoListCreating,
  todoListCreated,
  todoListLoading,
  todoListGetSuccess,
}
