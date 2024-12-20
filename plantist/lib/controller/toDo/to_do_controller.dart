import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:plantist/model/to_do_model.dart';

class TodoController extends GetxController {
  var todoList = <ToDoModel>[].obs;
  var filteredTodos = <ToDoModel>[].obs;
  var selectedPriority = 'Medium'.obs;
  var selectedTitle = ''.obs;
  var selectedNote = ''.obs;
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  void updatePriority(String newPriority) {
    selectedPriority.value = newPriority;
  }

  @override
  void onInit() {
    super.onInit();

    fetchTodoList();
  }

  void fetchTodoList() {
    DatabaseReference todoRef = FirebaseDatabase.instance
        .reference()
        .child('todos')
        .child(FirebaseAuth.instance.currentUser!.uid);

    // Listen for changes in the database
    todoRef.onValue.listen((event) {
      // Clear existing list
      todoList.clear();

      Map<dynamic, dynamic>? todos =
          event.snapshot.value as Map<dynamic, dynamic>?;

      if (todos != null) {
        todos.forEach((key, value) {
          ToDoModel todo = ToDoModel.fromMap(value);
          todoList.add(todo);
        });
      }

      filterTodos('');
    });
  }

  Future<void> addTodo(String title, String note) async {
    String priority =
        selectedPriority.value; // Use the selectedPriority from the controller
    if (title.isNotEmpty && note.isNotEmpty) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DatabaseReference todoRef =
          FirebaseDatabase.instance.reference().child('todos').child(uid);
      String? todoId = todoRef.push().key;
      await todoRef.child(todoId!).set({
        'title': title,
        'todoId': todoId,
        'note': note,
        'priority': priority,
        // 'reminderDate': reminderDate,
      });
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('Title and note cannot be empty!'),
        ),
      );
    }
  }

  void filterTodos(String query) {
    filteredTodos.clear();

    if (query.isEmpty) {
      filteredTodos.assignAll(todoList);
    } else {
      filteredTodos.assignAll(todoList.where(
          (todo) => todo.title.toLowerCase().contains(query.toLowerCase())));
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

  void updateTodo(ToDoModel todo) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference todoRef = FirebaseDatabase.instance
        .reference()
        .child('todos')
        .child(uid)
        .child(todo.todoId);

    // Format date and time as strings
    String formattedDate =
        selectedDate.value.toIso8601String().split('T')[0]; // Format the date to ISO 8601
    String formattedTime =
        '${selectedTime.value.hour.toString().padLeft(2, '0')}:${selectedTime.value.minute.toString().padLeft(2, '0')}'; // Format the time as HH:mm

    await todoRef.update({
      'title': selectedTitle.value,
      'note': selectedNote.value,
      'priority': selectedPriority.value,
      'reminderDate': formattedDate,
      'reminderTime': formattedTime,
    });
  }

  // New methods to update fields
  void setTitle(String title) {
    selectedTitle.value = title;
  }

  void setNote(String note) {
    selectedNote.value = note;
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  void setTime(TimeOfDay time) {
    selectedTime.value = time;
  }
}
