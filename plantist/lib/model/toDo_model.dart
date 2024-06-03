class toDoModel {
  late String todoId;
  late String title;
  late String note;
  late bool isDone = false;
  /*late String priority;
  late dynamic date;
  ;*/

  toDoModel({
    required this.todoId,
    required this.title,
    required this.note,
    required this.isDone
    /*required this.priority,
    required this.date,
    */
  });

  toDoModel.fromMap(Map<dynamic, dynamic> map) {
    todoId = map['todoId'];
    title = map['title'];
    note = map['note'];
    isDone = map['isDone'] ?? false;
    /*priority=map['priority'];
    date = map['date'];
   ;*/
  }
}