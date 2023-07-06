import 'package:flutter_application/Pages/dialog_box.dart';
import 'package:flutter_application/Pages/todo_tile.dart';
import 'package:flutter_application/data/database.dart';
import 'package:flutter_application/themes/style.dart';
import 'package:flutter_application/themes/theme_manager.dart';
import 'package:flutter_application/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // refernce the hive box
  final _todoBox = Hive.box('todoBox');

  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if the app is opened first time, then
    if (_todoBox.get('TODOLIST') == null && _todoBox.get('ACTIVECAT') == null) {
      db.createInitialData();
    } else {
      // if data is already there
      db.loadData();
    }
    super.initState();
  }

  void onCancel(controller){
    controller.clear();
    Navigator.of(context).pop();
  }

  // add task action in dialog box
  void addTask() {
    setState(() {
      db.dataset[db.activeCategory]!.add([_controller1.text, false]);

      _controller1.clear();
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
          controller: _controller1,
          onAdd: addTask,
          onCancel: () => onCancel(_controller1),
          hint: 'Add a new task'
        );
      });
  }

  // when the checkbox is checked
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.dataset[db.activeCategory]![index][1] = !db.dataset[db.activeCategory]![index][1];
    });
    db.updateData();
  }

  // delete todo task
  void deleteTodoTask(int index) {
    setState(() {
      db.dataset[db.activeCategory]!.removeAt(index);
    });
    db.updateData();
  }

  // delete all tasks
  void deleteAllTasks() {
    setState(() {
      db.dataset[db.activeCategory]!.clear();
    });
    db.updateData();
  }

  // delete all checked tasks
  void deleteAllCheckedTasks() {
    setState(() {
      db.dataset[db.activeCategory]!.removeWhere((task) => task[1] == true);
    });
    db.updateData();
  }

  void changeActiveCatagory(label){
    setState(() {
      db.activeCategory = label;
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void addKey(){
    setState(() {
     db.dataset[_controller2.text] = [];
     db.activeCategory = _controller2.text;
     _controller2.clear();
    });
    Navigator.of(context).pop();
    db.updateData(); 
  }

  // add new label in dataset
  void addLabel() {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller2,
          onAdd: addKey,
          onCancel: () => onCancel(_controller2),
          hint: 'Add a label'
        );
      }
    );
  }

  // delete a label
  void deleteLabel() {
    setState(() {
      db.dataset.remove(db.activeCategory);
      db.activeCategory = db.dataset.keys.toList()[0];
    });
    db.updateData(); 
  }

  void updateKey(){
    setState(() {
     var oldKeyVal = db.dataset.remove(db.activeCategory);
     db.dataset[_controller2.text] = oldKeyVal;
     db.activeCategory = _controller2.text;
     _controller2.clear();
    });
    Navigator.of(context).pop();
    db.updateData(); 
  }

  // edit a label
  void editLabel(){
    _controller2.text = db.activeCategory;
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller2,
          onAdd: updateKey,
          onCancel: () => onCancel(_controller2),
          hint: null,
        );
      }
    );
  }

  void updateToDo(int index) {
    setState(() {
      db.dataset[db.activeCategory]![index][0] = _controller1.text;

      _controller1.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  // edit a ToDo
  void editToDo(int index){
    _controller1.text = db.dataset[db.activeCategory]![index][0];
    showDialog(
    context: context,
    builder: (context) {
      return DialogBox(
        controller: _controller1,
        onAdd: () => updateToDo(index),
        onCancel: () => onCancel(_controller1),
        hint: null
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
        extendBody: true,
        backgroundColor: themeManager.darkTheme ? Styles.darkBackgroundColor : Styles.lightBackgroundColor,
        appBar: AppBar(
          title: Center( 
            child: Text(
              'To-Do List',
              style: TextStyle(color: themeManager.darkTheme ? Styles.darkActiveTextColor : Styles.lightActiveTextColor, fontSize: 24))
          ),
          actions: [
            PopupMenuButton(
              icon: Icon(
                Icons.more_vert, 
                color: themeManager.darkTheme ? Styles.darkActiveTextColor : Styles.lightActiveTextColor,
              ),
              color: themeManager.darkTheme ? Styles.darkPopUpMenuColor : Styles.lightPopUpMenuColor,
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1, 
                  child: ListTile(
                    leading: Icon(Icons.cancel_rounded),
                    title: Text('Delete checked items'),
                  ),
                ),
                const PopupMenuItem(
                  value: 2, 
                  child: ListTile(
                    leading: Icon(Icons.delete_rounded),
                    title: Text('Delete all items'),
                  ),
                ),
                const PopupMenuItem(
                  value: 3, 
                  child: ListTile(
                    leading: Icon(Icons.delete_forever_outlined),
                    title: Text('Delete Label'),
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
                else{
                  deleteLabel()
                }
              },
            ),
          ],
          elevation: 0,
        ),
        body: 
        Stack(children: [
          Positioned.fill(
            child: GridPaper(
              color: themeManager.darkTheme ? Styles.darkGridLinesColor : Styles.lightGridLinesColor,
            )
          ),
          Column( 
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: themeManager.darkTheme ? Styles.darkActiveTextColor : Styles.lightActiveTextColor,
                          width: 0.7, 
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                          child: Text(
                            ('${db.activeCategory.toUpperCase()}.'),
                            style: TextStyle(
                              color: themeManager.darkTheme? Styles.darkActiveTextColor : Styles.lightActiveTextColor,
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.9,
                          child: IconButton(
                            color: themeManager.darkTheme ? Styles.darkActiveTextColor : Styles.lightActiveTextColor,
                            onPressed: () => editLabel(),
                            icon: const Icon(Icons.edit),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: 
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                            itemCount: db.dataset[db.activeCategory]!.length,
                            itemBuilder: (context, index) {
                              return ToDoTile(
                                taskName: db.dataset[db.activeCategory]![index][0],
                                taskCompleted: db.dataset[db.activeCategory]![index][1],
                                onChanged: (value) => checkBoxChanged(value, index),
                                deleteTask: (context) => deleteTodoTask(index),
                                editToDo: (context) => editToDo(index),
                              );
                            }
                          )
                        ),
                      ),
                    ),
                  ],
                ),
        ],),
        // GridPaper(
        //   color: themeManager.darkTheme ? Styles.darkGridLinesColor : Styles.lightGridLinesColor,
        //   child :
        //   Column( 
        //     children: [
        //       Container(
        //         padding: const EdgeInsets.only(left: 16.0),
        //         decoration: BoxDecoration(
        //           border: Border(
        //             bottom: BorderSide(
        //               color: themeManager.darkTheme ? Styles.darkActiveTextColor : Styles.lightActiveTextColor,
        //               width: 0.7, 
        //             ),
        //           ),
        //         ),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Container(
        //               padding: const EdgeInsets.only(left: 3.0, right: 3.0),
        //               child: Text(
        //                 ('${db.activeCategory.toUpperCase()}.'),
        //                 style: TextStyle(
        //                   color: themeManager.darkTheme? Styles.darkActiveTextColor : Styles.lightActiveTextColor,
        //                   fontSize: 26,
        //                   fontWeight: FontWeight.w600,
        //                 ),
        //               ),
        //             ),
        //             Transform.scale(
        //               scale: 0.9,
        //               child: IconButton(
        //                 color: themeManager.darkTheme ? Styles.darkActiveTextColor : Styles.lightActiveTextColor,
        //                 onPressed: () => editLabel(),
        //                 icon: const Icon(Icons.edit),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       Expanded(
        //         child: Padding(
        //           padding: const EdgeInsets.only(top: 10.0),
        //           child: SizedBox(
        //             width: double.infinity,
        //             height: double.infinity,
        //             child: 
        //             ListView.builder(
        //               physics: const BouncingScrollPhysics(),
        //                 itemCount: db.dataset[db.activeCategory]!.length,
        //                 itemBuilder: (context, index) {
        //                   return ToDoTile(
        //                     taskName: db.dataset[db.activeCategory]![index][0],
        //                     taskCompleted: db.dataset[db.activeCategory]![index][1],
        //                     onChanged: (value) => checkBoxChanged(value, index),
        //                     deleteTask: (context) => deleteTodoTask(index),
        //                     editToDo: (context) => editToDo(index),
        //                   );
        //                 }
        //               )
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              onPressed: () => createTask(),
              focusElevation: 5,
              backgroundColor: themeManager.darkTheme ? Styles.darkInactiveTextColor : Styles.lightInactiveTextColor,
              child: const Icon(Icons.add),
            ),
          ),
          drawer: SafeArea(
            child : Drawer(
              backgroundColor: themeManager.darkTheme ? Styles.darkBackgroundColor : Styles.lightBackgroundColor,
              width: MediaQuery.of(context).size.width * 0.7,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                    ),
                    title: const Text('Home', style: TextStyle(fontSize: 20)),
                    onTap: () {
                      Navigator.pushNamed(context, MyRoutes.homeRoute);
                    },
                  ),
                  SingleChildScrollView(
                   child: ExpansionTile(
                      leading: const Icon(
                        Icons.category_rounded,
                      ),
                      initiallyExpanded: true,
                      title: const Text('Labels', style: TextStyle(fontSize: 20)),
                      childrenPadding: const EdgeInsets.only(left: 60.0),
                      children: [
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: db.dataset.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                (db.dataset.keys.toList()[index][0].toUpperCase() + db.dataset.keys.toList()[index].substring(1).toLowerCase()), 
                                style: const TextStyle(fontSize: 18)
                              ),
                              onTap: () => changeActiveCatagory(db.dataset.keys.toList()[index]),
                            );
                          }
                        ),
                        ListTile(
                          trailing: const Icon(
                            Icons.add,
                          ),
                          title: const Text('Add label', style: TextStyle(fontSize: 18)),
                          onTap: () => addLabel(),
                        )
                      ],
                    ),
                  ),
                  ListTile(
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
            ),
          ),
    );
  }
}