import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase{

  // To do list to store tasks
  List todoList = [];
  // reference hive box
  final _todoBox = Hive.box('todoBox');

  // method when app is first time used
  void createInitialData(){
    todoList = [
      ['Demo To Do task', false]
    ];
  }

  // method to load the data from database
  void loadData(){
    todoList = _todoBox.get('TODOLIST');
  }

  // method to update the database
  void updateData(){
    _todoBox.put('TODOLIST', todoList);
  }
}