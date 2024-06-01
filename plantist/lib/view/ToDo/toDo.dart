import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantist/controller/auth/auth_controller.dart';
import 'package:plantist/view/ToDo/toDoModalManager.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key, required this.email});

  final String email;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            AuthController.instance.logOut();
          },
        ),
        title: Text(widget.email),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            _showNewReminderModal(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 24, 24, 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Container(
            alignment: Alignment.bottomCenter,
            width: 300,
            height: 60, // Make button take full width
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.white, size: 24), // "+" icon
                SizedBox(width: 8), // Add some space between the icon and text
                Text(
                  'New Reminder',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    // Increase font size if needed
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*void _showNewReminderModal(BuildContext context) {
    TextEditingController noteController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 700, // Increase the height of the modal bottom sheet
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
                controller: noteController,
                decoration: const InputDecoration(
                  hintText: 'Notes',
                ),
              ),
              const SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  _showDetailModal(context);
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
      },
    );
  }*/

 /* void _showDetailModal(BuildContext context) {
    bool showDatePicker =
        false; // Variable to control the visibility of the date picker
    bool showTimePicker =
        false; // Variable to control the visibility of the time picker
    DateTime selectedDate = DateTime.now(); // Store selected date
    TimeOfDay selectedTime = TimeOfDay.now(); // Store selected time

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: 900, // Increased height to accommodate both pickers
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
          },
        );
      },
    );
  }*/
  void _showNewReminderModal(BuildContext context) {
  ModalManager.showNewReminderModal(context);
}

void _showDetailModal(BuildContext context) {
  ModalManager.showDetailModal(context);
}

}

