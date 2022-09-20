import 'package:flutter/material.dart';
import '../models/db_model.dart';
import '../models/todo_model.dart';
import '../widgets/user_input.dart';
import '../widgets/todo_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  var db = DatabaseConnect();

  void addItem(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }

  void removeItem(Todo todo) async {
    await db.deleteTodo(todo);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EBFF),
      appBar: AppBar(
        title: const Text("Todo list"),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(20, 20, 25, 100),
      ),
      body: Column(children: [
        Todolist(insertFunction: addItem, deleteFunction: removeItem,),
        UserInput(insertFunction: addItem,),
      ]),
    );
  }
}
