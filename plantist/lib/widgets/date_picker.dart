import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerWidget extends StatelessWidget {
  final RxBool showDatePicker;
  final Rx<DateTime> selectedDate;

  DatePickerWidget({
    required this.showDatePicker,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: TextStyle(
                color: showDatePicker.value ? Colors.green : Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Switch(
              value: showDatePicker.value,
              onChanged: (bool value) {
                showDatePicker.value = value;
               
              },
            ),
          ],
        ),
        Obx(() {
          if (showDatePicker.value) {
            return CalendarDatePicker(
              initialDate: selectedDate.value,
              firstDate: DateTime(2022),
              lastDate: DateTime(2025),
              onDateChanged: (date) {
                selectedDate.value = date;
                print(selectedDate.value );
              },
            );
          } else {
            return SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
