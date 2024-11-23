import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist/controller/toDo/to_do_controller.dart';

class SearchBar extends StatelessWidget {
  final TodoController todoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: (value) {
          todoController.filterTodos(value);
        },
        decoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Search in titles',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
