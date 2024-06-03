import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:plantist/model/toDo_model.dart';

class TodoController extends GetxController {
  var todoList = <toDoModel>[].obs;
  var filteredTodos = <toDoModel>[].obs;

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
          toDoModel todo = toDoModel.fromMap(value);
          todoList.add(todo);
        });
      }

      filterTodos('');
    });
  }

  Future<void> addTodo(String title, String note) async {
    if (title.isNotEmpty && note.isNotEmpty) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DatabaseReference todoRef =
          FirebaseDatabase.instance.reference().child('todos').child(uid);
      String? todoId = todoRef.push().key;
      await todoRef.child(todoId!).set({
        'title': title,
        'todoId': todoId,
        'note': note,
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
}
