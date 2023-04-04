import 'package:flutter/material.dart';
import 'package:my_todo/src/add_todo_page.dart';
import 'package:my_todo/src/todo_controller.dart';
import 'package:my_todo/src/todo_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final todoController = Provider.of<TodoController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text("My Todo")),
      body: Consumer<TodoController>(builder: (context, controller, child) {
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemCount: controller.todos.length,
          itemBuilder: (BuildContext context, int index) {
            final todo = controller.todos[index];
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return AddTodoPage(todo: todo);
                }));
              },
              leading: Checkbox(
                value: todo.checked,
                onChanged: (value) {
                  final newTodo = TodoModel(
                    todo.title,
                    todo.id,
                    value ?? false,
                  );
                  todoController.update(todo.id, newTodo);
                },
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration: todo.checked ? TextDecoration.lineThrough : null,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  todoController.delete(todo);
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const AddTodoPage();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
