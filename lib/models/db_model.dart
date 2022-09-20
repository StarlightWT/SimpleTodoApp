import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './todo_model.dart';

class DatabaseConnect {
  Database? _database;

  //create a getter for the database and open a connection to it
  Future<Database> get database async {
    //Path to database in device
    final dbpath = await getDatabasesPath();
    //Set name of database
    const dbname = 'todo.db';

    final path = join(dbpath, dbname);

    //Connect to database
    _database = await openDatabase(path, version: 1, onCreate: _createDB);

    return _database!;
  }

  //_createDB function
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        creationDate TEXT,
        isChecked INTEGER
      )
    ''');
  }

  // function to add data to databse
  Future<void> insertTodo(Todo todo) async {
    //Get the connection
    final db = await database;
    //Insert the todo
    await db.insert(
      'todo', //Name of table
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, //Replaces duplicates
    );
  }

  // function to removed data from database
  Future<void> deleteTodo(Todo todo) async {
    final db = await database; //Get the connection

    await db.delete(
      'todo',
      where: 'id == ?', // Check for id in todo-list
      whereArgs: [todo.id],
    );
  }

  // function to fetch all data from database
  Future<List<Todo>> getTodo() async {
    final db = await database;
    //query the database and save the todo as list of maps
    List<Map<String, dynamic>> items = await db.query(
      'todo',
      orderBy: 'id DESC',
    );

    //Convert list of maps to list of todo
    return List.generate(
        items.length,
        (i) => Todo(
              id: items[i]['id'],
              title: items[i]['title'],
              creationDate: DateTime.parse(items[i]['creationDate']),
              isChecked: items[i]['isChecked'] == 1 ? true : false, // Convert int to bool
            ));
  }
}
