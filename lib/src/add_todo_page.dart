import 'package:flutter/material.dart';
import 'package:my_todo/src/todo_controller.dart';
import 'package:my_todo/src/todo_model.dart';
import 'package:provider/provider.dart';

class AddTodoPage extends StatefulWidget {
  final TodoModel? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController textEditingController = TextEditingController();
  bool enable = false;
  late TodoModel? todo = widget.todo;

  void save() {
    final todoController = Provider.of<TodoController>(context, listen: false);

    if (todo != null) {
      TodoModel todoModel = TodoModel(
        textEditingController.text.trim(),
        todo!.id,
        todo!.checked,
      );
      todoController.update(todo!.id, todoModel);
    } else {
      TodoModel todoModel = TodoModel(
        textEditingController.text.trim(),
        DateTime.now().millisecondsSinceEpoch,
        false,
      );
      todoController.add(todoModel);
    }

    Navigator.pop(context);
  }

  @override
  void initState() {
    if (todo != null) {
      textEditingController.text = todo!.title;
    }
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              onChanged: (value) {
                setState(() {
                  enable = value.isNotEmpty;
                });
              },
              decoration: const InputDecoration(
                labelText: "Todo",
                border: OutlineInputBorder(),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: enable ? save : null,
                child: Text(todo != null ? "Edit" : "Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
