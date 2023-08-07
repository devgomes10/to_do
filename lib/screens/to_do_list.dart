import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/task_model.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Task> tasks = [];
  TextEditingController _taskController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void addTask(String title) {
    setState(() {
      tasks.add(Task(title, false));
      _taskController.clear();
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  Widget buildTaskItem(Task task, int index) {
    return ListTile(
      leading: Checkbox(
        activeColor: Colors.deepOrange,
        value: task.isCompleted,
        onChanged: (value) => toggleTask(index),
      ),
      title: Text(
        task.title,
        style: GoogleFonts.montserrat(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => removeTask(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Tarefas Diárias',
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
        ),
        body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return buildTaskItem(tasks[index], index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: GoogleFonts.montserrat(),
                      controller: _taskController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, adicione uma tarefa';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          addTask(value);
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Adicione uma nova tarefa...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addTask(_taskController.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
