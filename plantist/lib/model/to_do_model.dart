class ToDoModel {
  late String todoId;
  late String title;
  late String note;
  late bool isDone = false;
  late String? reminderDate;
  late String priority;
  //late TimeOfDay? reminderTime;
 

  ToDoModel(
      {required this.todoId,
      required this.title,
      required this.note,
      required this.isDone,
      this.reminderDate,
      required this.priority,
     // this.reminderTime,
      
      });

  ToDoModel.fromMap(Map<dynamic, dynamic> map) {
    todoId = map['todoId'];
    title = map['title'];
    note = map['note'];
    isDone = map['isDone'] ?? false;
    reminderDate = map['reminderDate'];
    priority = map['priority'];
    //reminderTime = map['reminderTime'] != null ? _parseTimeOfDay(map['reminderTime']) : null;
   
  }
}
