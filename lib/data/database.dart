import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{

  List toDoList = [];

  final _myBox = Hive.box('mybox');
  // run if this is first launch ever
  void createData(){
    toDoList =[
      ["Example Task 1", false], ["Example Task 2", false]
    ];
  }

  // load data

  void loadData(){
      toDoList = _myBox.get("TODOLIST");
  }

  void updateDataBase(){

    _myBox.put("TODOLIST", toDoList);

  }
}