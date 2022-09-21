import 'package:flutter/material.dart';

import '../models/todo_model.dart';

class UserInput extends StatelessWidget {
  final textController = TextEditingController();
  final Function insertFunction;

  UserInput({required this.insertFunction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      color: const Color.fromRGBO(20, 20, 25, 100),
      child: Row(
        children: [
          //This will be in the input box
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
              controller: textController,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                hintText: "add new todo",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                border: InputBorder.none,
              ),
            ),
          )),
          const SizedBox(width: 10),
          //Button
          GestureDetector(
            onTap: () {
              if(textController.text == "") return;
              var myTodo = Todo(
                title: textController.text,
                creationDate: DateTime.now(),
                isChecked: false,
              );
              insertFunction(myTodo);
            },
            child: Container(
                color: Colors.purple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
