class Todo{
  int? id;
  final String title;
  DateTime creationDate;
  bool isChecked;

  //Create the constructor
  Todo({
    this.id,
    required this.title,
    required this.creationDate,
    required this.isChecked
  });

  //convert data to map to be able to save it properly
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title' : title,
      'creationDate': creationDate.toString(),
      'isChecked' : isChecked ? 1 : 0 // convert boolean to int
    };
  }

  // debugging stuff
  @override
  String toString() {
    return 'Todo(id : $id, title : $title, creationDate : $creationDate, isChecked: $isChecked)';
  }
}