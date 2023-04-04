import 'package:flutter/material.dart';
import 'package:my_todo/src/todo_model.dart';

class TodoController extends ChangeNotifier {
  final List<TodoModel> todos = [];

  void add(TodoModel todo) {
    todos.add(todo);
    notifyListeners();
  }

  void update(int id, TodoModel todo) {
    int index = todos.indexWhere((element) => element.id == id);
    todos[index] = todo;
    notifyListeners();
  }

  void delete(TodoModel todo) {
    todos.remove(todo);
    notifyListeners();
  }
}
