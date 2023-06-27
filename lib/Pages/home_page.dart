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

  // delete all tasks
  void deleteAllTasks() {
    setState(() {
      db.todoList.clear();
    });
    db.updateData();
  }

  // delete all checked tasks
  void deleteAllCheckedTasks() {
    setState(() {
      db.todoList.removeWhere((task) => task[1] == true);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 15, 15, 23),
          toolbarHeight: MediaQuery.of(context).size.height * 0.09,
          iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
          title: Center( 
            child: Text(
              "To-Do List",
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 27))
            ),
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert, color: Theme.of(context).colorScheme.tertiary),
              color: const Color.fromARGB(255, 33, 33, 51),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1, 
                  child: ListTile(
                    iconColor: Theme.of(context).colorScheme.tertiary,
                    textColor: Theme.of(context).colorScheme.tertiary,
                    leading: const Icon(Icons.cancel_rounded),
                    title: const Text('Delete checked items'),
                  ),
                ),
                PopupMenuItem(
                  value: 2, 
                  child: ListTile(
                    iconColor: Theme.of(context).colorScheme.tertiary,
                    textColor: Theme.of(context).colorScheme.tertiary,
                    leading: const Icon(Icons.delete_rounded),
                    title: const Text('Delete all items'),
                  ),
                ),
              ],
              onSelected: (value) => {
                if (value == 1) {
                  deleteAllCheckedTasks()
                }
                else if (value == 2) {
                  deleteAllTasks()
                }
              },
            ),
          ],
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
        drawer: SafeArea(
          child : Drawer(
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
                  title: const Text('Home', style: TextStyle(fontSize: 20)),
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
                  title: const Text('Settings', style: TextStyle(fontSize: 20)),
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.settingRoute);
                  },
                ),
              ],
            ),
          )
       )
    );
  }
}
