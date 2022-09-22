import 'package:demo_provider/todo_list/todo_model.dart';
import 'package:demo_provider/todo_list/todo_provider.dart';
import 'package:demo_provider/todo_list/widgets/todo_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TodoModel? _todoModelSelected;
  FocusNode inputNode = FocusNode();
  String _name = '';
  bool _initFirstData = true;
  late TodoProvider _todoProvider;

  Future<void> myAsyncMethod(
      BuildContext context, VoidCallback onSuccess, int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
    onSuccess.call();
  }

  void _initStateWithContext(BuildContext context) {
    context.read<TodoProvider>().getDataFromLocal();
    _todoProvider = context.read<TodoProvider>();
  }

  void _onRemove() {
    if (_todoModelSelected != null) {
      _todoProvider.removeItemTodo(_todoModelSelected!.id ?? '');
    }
  }

  void _onCreate() {
    if (_formKey.currentState == null) {
      return;
    }
    FormState form = _formKey.currentState!;
    if (!form.validate()) {
      form.save();
      return;
    }
    _todoProvider.createItemTodo(_nameController.text);
    _nameController.text = '';
  }

  void _onItemTap(TodoModel model) {
    if (_todoModelSelected?.id == model.id) {
      // bo chon
      _todoModelSelected = null;
      _nameController.text = '';

      // tat ban phim
      FocusScope.of(context).requestFocus(FocusNode());
    } else {
      // chon
      _todoModelSelected = model;
      _nameController.text = model.name ?? '';

      // set con trỏ về cuối
      _nameController.selection = TextSelection.fromPosition(
          TextPosition(offset: _nameController.text.length));

      // bật bàn phím
      FocusScope.of(context).requestFocus(inputNode);
    }
    _todoProvider.emitToUpdateUi();
  }

  void _onUpdate() {
    if (_todoModelSelected == null) {
      return;
    }
    _todoProvider.updateItemInListToDo(
      _todoModelSelected!,
      _nameController.text,
    );
    _todoModelSelected = null;
    _nameController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    if (_initFirstData) {
      _initFirstData = false;
      myAsyncMethod(
        context,
        () {
          _initStateWithContext(context);
        },
        100,
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TodoList'),
        actions: [
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: _onUpdate,
          ),
          Consumer<TodoProvider>(builder: (_, TodoProvider provider, __) {
            if (provider.currentStatus == StatusTodoProvider.todoListCreating) {
              return const SizedBox(
                width: 40,
                height: 40,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            }
            return IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: _onCreate,
            );
          }),
          IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: _onRemove,
          ),
        ],
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _nameController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui long nhap ten';
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: 'Nhap ten todo'),
                focusNode: inputNode,
                textInputAction: TextInputAction.next,
              ),
            ),
          ),
          Expanded(
            child:
                Consumer<TodoProvider>(builder: (_, TodoProvider provider, __) {
              if (provider.currentStatus ==
                  StatusTodoProvider.todoListLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (provider.listTodo.isNotEmpty) {
                provider.listTodo.sort(
                    (a, b) => (b.dateTime ?? 0).compareTo((a.dateTime ?? 0)));
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (_, index) {
                    final itemModel = provider.listTodo[index];
                    return TodoListItem(
                      todoModel: provider.listTodo[index],
                      onTap: _onItemTap,
                      selected: _todoModelSelected?.id == itemModel.id,
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 12);
                  },
                  itemCount: provider.listTodo.length,
                );
              }
              return const Center(
                child: Text('Chua co du lieu'),
              );
            }),
          )
        ],
      ),
    );
  }
}
