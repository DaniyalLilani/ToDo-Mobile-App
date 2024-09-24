import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/database.dart';
import '../util/todo_tile.dart';
import '../util/dialog.dart';

class HomePage extends StatefulWidget{

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // create new data if first ever time opening app
    if(_myBox.get("TODOLIST") == null){
      db.createData();
    } else{
      db.loadData();
    }
    super.initState();
  }


  final _controller = TextEditingController();
 

  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1]; // flip 
    });
    db.updateDataBase();
    Navigator.of(context).pop;
    


  }

  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateDataBase();

    Navigator.of(context).pop();
  }



  void createNewTask(){
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          controller:_controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
      
      );

  
  }

  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
        db.updateDataBase();

  }
  
  
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center (
          child: const Text('TO DO'),
        
        ),
        elevation: 0,

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask, // CreateNewTask. STOP HERE
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
        
        
        
        ),


      body:ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context,index){
          return TodoTile(taskName: db.toDoList[index][0], taskCompleted: db.toDoList[index][1], onChanged: (value)=> checkBoxChanged(value, index),deleteFunction:(context)=> deleteTask(index) ,);
        }

      )
    );
  }
}