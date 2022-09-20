import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo_model.dart';

// ignore: must_be_immutable
class Todocard extends StatefulWidget {
  //Variables to receive data for
  final int id;
  final String title;
  final DateTime creationDate;
  bool isChecked;
  final Function insertFunction;
  final Function deleteFunction;
  Todocard(
      {required this.id,
      required this.title,
      required this.creationDate,
      required this.isChecked,
      required this.deleteFunction,
      required this.insertFunction,
      super.key});

  @override
  State<Todocard> createState() => _TodocardState();
}

class _TodocardState extends State<Todocard> {
  @override
  Widget build(BuildContext context) {
    //create a local todo
    var localTodo = Todo(
      id: widget.id,
      title: widget.title,
      creationDate: widget.creationDate,
      isChecked: widget.isChecked,
    );

    return Card(
      child: Row(children: [
        //Check box
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Checkbox(
            value: widget.isChecked,
            onChanged: (bool? value) {
              setState(() {
                widget.isChecked = value!;
              });
              //Change local todo
              localTodo.isChecked = value!;
              widget.insertFunction(localTodo);
            },
          ),
        ),
        //Title and daaate
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              DateFormat('dd MMM yyyy - hh:mm aaa').format(widget.creationDate),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8F8F8F),
              ),
            ),
          ],
        )),
        //Delete button
        IconButton(onPressed: () {
          widget.deleteFunction(localTodo);
        }, icon: const Icon(Icons.close))
      ]),
    );
  }
}
