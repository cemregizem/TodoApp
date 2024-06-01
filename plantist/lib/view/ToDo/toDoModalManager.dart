import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:plantist/view/ToDo/toDo.dart';
import 'package:plantist/widgets/timePicker.dart';

class ModalManager {
  static void showNewReminderModal(BuildContext context) {
    TextEditingController noteController = TextEditingController();
    TextEditingController titleController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return  NewReminderModal(noteController: noteController,titleController: titleController,);
      },
    );
  }

  static void showDetailModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return DetailModal();
      },
    );
  }
}

class NewReminderModal extends StatelessWidget {
  final TextEditingController noteController;
  final TextEditingController titleController;
   const NewReminderModal({Key? key, required this.noteController,required this.titleController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {
                      // Handle add button action
                      Navigator.pop(context); // Close the bottom sheet
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
              GestureDetector(
                onTap: () {
                  ModalManager.showDetailModal(context);
                },
                child: Container(
                  width: double.infinity, // Take full width
                  height: 90, // Set the height
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey, // Set the border color
                      width: 1, // Set the border width
                    ), // Set the radius
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Details',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ],
      ),
    );
  }
}

class DetailModal extends StatefulWidget {
  @override
  _DetailModalState createState() => _DetailModalState();
}

class _DetailModalState extends State<DetailModal> {
  bool showDatePicker = false;
  bool showTimePicker = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 900,
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
                        onPressed: () {
                          // Handle add button action
                          Navigator.pop(context); // Close the bottom sheet
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                            color:
                                showDatePicker ? Colors.green : Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      Switch(
                        value: showDatePicker,
                        onChanged: (bool value) {
                          setState(() {
                            showDatePicker = value;
                            // Ensure only one picker is active at a time
                          });
                        },
                      ),
                    ],
                  ),
                  if (showDatePicker)
                    Expanded(
                      child: Container(
                        child: CalendarDatePicker(
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2025),
                          onDateChanged: (date) {
                            setState(() {
                              selectedDate = date;
                            });
                          },
                        ),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Time',
                        style: TextStyle(
                            color:
                                showTimePicker ? Colors.green : Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      Switch(
                        value: showTimePicker,
                        onChanged: (bool value) {
                          setState(() {
                            showTimePicker = value;
                            // Ensure only one picker is active at a time
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  if (showTimePicker)
                    Expanded(
                      child: Container(
                        child: TimePickerWidget(
                          onTimeChanged: (time) {
                            setState(() {
                              selectedTime = time;
                            });
                          },
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity, // Take full width
                      height: 80, // Set the height
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey, // Set the border color
                          width: 1, // Set the border width
                        ), // Set the radius
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Priority',
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity, // Take full width
                      height: 80, // Set the height
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey, // Set the border color
                          width: 1, // Set the border width
                        ), // Set the radius
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Attach a File',
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Icon(
                            Icons.attach_file,
                            color: Colors.grey,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
      ),
    );
  }
}
