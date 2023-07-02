import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase{

  var dataset = {};
  String  activeCategory = '';

  // reference hive box
  final _todoBox = Hive.box('todoBox');

  // method when app is first time used
  void createInitialData(){
    activeCategory = 'home';
    dataset = {
      'home' : [
        ['Demo To Do task', false],
      ],
    };
  }

  // method to load the data from database
  void loadData(){
    dataset = _todoBox.get('TODOLIST');
    activeCategory = _todoBox.get('ACTIVECAT');
  }

  // method to update the database
  void updateData(){
    _todoBox.put('TODOLIST', dataset);
    _todoBox.put('ACTIVECAT', activeCategory);
  }
}