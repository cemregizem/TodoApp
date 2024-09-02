class ToDoModel {
  late String todoId;
  late String title;
  late String note;
  late bool isDone = false;
  late String? reminderDate; 
  late String? reminderTime; 
  late String priority;
  
 

  ToDoModel(
      {required this.todoId,
      required this.title,
      required this.note,
      required this.isDone,
      this.reminderDate,
      this.reminderTime,
      required this.priority,
     
      
      });

  ToDoModel.fromMap(Map<dynamic, dynamic> map) {
    todoId = map['todoId'];
    title = map['title'];
    note = map['note'];
    isDone = map['isDone'] ?? false;
    reminderDate = map['reminderDate'];
    priority = map['priority'];
    reminderDate = map['reminderDate']; // Date stored as a string
    reminderTime = map['reminderTime']; 
   
  } 
}
