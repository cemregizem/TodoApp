import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist/controller/toDo/to_do_controller.dart';
import 'package:plantist/model/to_do_model.dart';
import 'package:plantist/widgets/date_picker.dart';
import 'package:plantist/widgets/drop_down.dart';
import 'package:plantist/widgets/priority.dart';
import 'package:plantist/widgets/time_picker.dart';
import 'package:plantist/widgets/header.dart';
import 'package:plantist/widgets/button.dart';
import 'package:plantist/widgets/search_bar.dart'
    as custom; //to avoid name conflict withsearchbar class in flutter

class TodoPage extends StatelessWidget {
  TodoPage({super.key, required this.email, required this.userId});

  final String email;
  final String userId;

  TextEditingController noteController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  late TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    todoController = Get.put(TodoController());
    return Scaffold(
      appBar: Header(),
      body: Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 16),
              child: const Text(
                'Plantist',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              )),
          const SizedBox(
              height: 10), // Add some space between title and search bar
          custom.SearchBar(),

          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 450,
              child: Obx(() {
                return ListView.builder(
                  itemCount: todoController.filteredTodos.length,
                  itemBuilder: (context, index) {
                    ToDoModel todo = todoController.filteredTodos[index];
                    return Dismissible(
                      key: Key(todo.todoId), // Unique key for each item
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20.0),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) {
                        todoController.deleteTodo(todo.todoId);
                      },
                      child: Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          leading: Checkbox(
                            value: todo.isDone,
                            onChanged: (bool? value) {
                              // Update the isDone status when checkbox is changed
                              todoController.updateTodoStatus(
                                  todo.todoId, value ?? false);
                            },
                          ),
                          title: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Text(
                                  todo.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                 Text(
                                 todo.note,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Align(
                            alignment: Alignment.centerLeft,
                            child: 
                                Row(
                                  children: [
                                    Text(
                                      todo.reminderDate ?? '',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      todo.reminderTime ?? '',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                )
                             
                          ),
                          trailing: PriorityDot(priority: todo.priority),
                          onTap: () {
                            _showDetailModal(context, todo);
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
          const SizedBox(height: 30),
          NewReminderButton(
            onPressed: () {
              _showNewReminderModal(context);
            },
          ),
        ],
      ),
    );
  }

  void _showNewReminderModal(BuildContext context) {
    TextEditingController noteController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 700,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Handle cancel button action
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      String title = titleController.text.trim();
                      String note = noteController.text.trim();
                      await todoController.addTodo(title, note);
                      titleController.clear();
                      noteController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(
                  hintText: 'Notes',
                ),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Priority',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 100),
                  Expanded(child: Obx(() {
                    return DropDownWidget(
                      options: ['High', 'Medium', 'Low'],
                      selectedValue: todoController.selectedPriority.value,
                      onChanged: (newValue) {
                        todoController.updatePriority(newValue);
                      },
                    );
                  })),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void _showDetailModal(BuildContext context, ToDoModel todo) {
    todoController.setTitle(todo.title);
    todoController.setNote(todo.note);
    todoController.selectedPriority.value = todo.priority;
    // Convert variables to Rx types
    final showDatePicker = false.obs;
    final showTimePicker = false.obs;
    final selectedDate = DateTime.now().obs;
    final selectedTime = TimeOfDay.now().obs;

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(16),
            height: 900, // Increased height to accommodate both pickers
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Handle cancel button action
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        todoController.updateTodo(todo);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(() => TextField(
                      controller: TextEditingController(
                          text: todoController.selectedTitle.value),
                      onChanged: (value) {
                        todoController.setTitle(value);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Title',
                      ),
                    )),
                const SizedBox(height: 20),
                Obx(() => TextField(
                      controller: TextEditingController(
                          text: todoController.selectedNote.value),
                      onChanged: (value) {
                        todoController.setNote(value);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Note',
                      ),
                    )),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Priority',
                        style: TextStyle(
                              color: Colors.blueGrey,
                       
                              fontSize: 18)),
                    const SizedBox(width: 100),
                    Expanded(child: Obx(() {
                      return DropDownWidget(
                        options: const ['High', 'Medium', 'Low'],
                        selectedValue: todoController.selectedPriority.value,
                        onChanged: (newValue) {
                          todoController.updatePriority(newValue);
                        },
                      );
                    })),
                  ],
                ),
                 const SizedBox(height: 16),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                            color: showDatePicker.value
                                ? Colors.green
                                : Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Switch(
                          value: showDatePicker.value,
                          onChanged: (bool value) {
                            showDatePicker.value = value;
                            if (value) {
                              showTimePicker.value = false;
                            }
                          },
                        ),
                      ],
                    )),
                const SizedBox(height: 16),
                Obx(() {
                  if (showDatePicker.value) {
                    return DatePickerWidget(
                      showDatePicker: showDatePicker,
                      selectedDate: selectedDate,
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Time',
                          style: TextStyle(
                              color: showTimePicker.value
                                  ? Colors.green
                                  : Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        Switch(
                          value: showTimePicker.value,
                          onChanged: (bool value) {
                            showTimePicker.value = value;
                            if (value) {
                              showDatePicker.value = false;
                            }
                 // Disable date picker
                          },
                        ),
                      ],
                    )),
                const SizedBox(height: 16),
                Obx(() {
                  if (showTimePicker.value) {
                    return TimePickerWidget(
                      onTimeChanged: (time) {
                        selectedTime.value = time;
                      },
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }),
              ],
            ),
          );
        });
  }
}
