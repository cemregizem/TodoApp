import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:plantist/model/toDo_model.dart';

class TodoController extends GetxController {
  var todoList = <toDoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Call method to fetch todo list
    fetchTodoList();
  }

  void fetchTodoList() {
    // Get reference to the todos node in Firebase
    DatabaseReference todoRef = FirebaseDatabase.instance
        .reference()
        .child('todos')
        .child(FirebaseAuth.instance.currentUser!.uid);

    // Listen for changes in the database
    todoRef.onValue.listen((event) {
      // Clear existing list
      todoList.clear();

      // Extract data from event
      Map<dynamic, dynamic>? todos = event.snapshot.value as Map<dynamic, dynamic>?;

      // If todos is not null, add each todo to the list
      if (todos != null) {
        todos.forEach((key, value) {
          toDoModel todo = toDoModel.fromMap(value);
          todoList.add(todo);
        });
      }
    });
  }
    Future<void> addTodo(String title, String note) async {
    if (title.isNotEmpty && note.isNotEmpty) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DatabaseReference todoRef = FirebaseDatabase.instance
          .reference()
          .child('todos')
          .child(uid);
      String? todoId = todoRef.push().key;
      await todoRef.child(todoId!).set({
        'title': title,
        'todoId': todoId,
        'note': note,
      });
    }
  }

  Future<void> deleteTodo(String todoId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference todoRef = FirebaseDatabase.instance
        .reference()
        .child('todos')
        .child(uid)
        .child(todoId);
    await todoRef.remove();
  }

  Future<void> updateTodoStatus(String todoId, bool isDone) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference todoRef = FirebaseDatabase.instance
      .reference()
      .child('todos')
      .child(uid)
      .child(todoId);
  await todoRef.update({
    'isDone': isDone,
  });
}

}
