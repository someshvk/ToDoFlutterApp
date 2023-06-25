import 'package:flutter_application/Pages/dialog_box.dart';
import 'package:flutter_application/Pages/todo_tile.dart';
import 'package:flutter_application/data/database.dart';
import 'package:flutter_application/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // refernce the hive box
  final _todoBox = Hive.box('todoBox');

  final _controller = TextEditingController();

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if the app is opened first time, then
    if (_todoBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      // if data is already there
      db.loadData();
    }
    super.initState();
  }

  // add task action in dialog box
  void addTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  // create a new task
  void createTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onAdd: addTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  // when the checkbox is checked
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();
  }

  // delete todo task
  void deleteTodoTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 17, 17, 24),
          title: Text(
            "To-Do List",
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary)),
          elevation: 0,
        ),
        body: GridPaper(
          color: Theme.of(context).colorScheme.primary,
          child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ListView.builder(
                  itemCount: db.todoList.length,
                  itemBuilder: (context, index) {
                    return ToDoTile(
                        taskName: db.todoList[index][0],
                        taskCompleted: db.todoList[index][1],
                        onChanged: (value) => checkBoxChanged(value, index),
                        deleteTask: (context) => deleteTodoTask(index));
                  })
              ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            onPressed: () => createTask(),
            focusElevation: 5,
            child: const Icon(Icons.add),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.background,
          width: MediaQuery.of(context).size.width * 0.7,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                iconColor: Theme.of(context).colorScheme.tertiary,
                textColor: Theme.of(context).colorScheme.tertiary,
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.homeRoute);
                },
              ),
              ListTile(
                iconColor: Theme.of(context).colorScheme.tertiary,
                textColor: Theme.of(context).colorScheme.tertiary,
                leading: const Icon(
                  Icons.settings,
                ),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.settingRoute);
                },
              ),
            ],
          ),
        ));
  }
}
