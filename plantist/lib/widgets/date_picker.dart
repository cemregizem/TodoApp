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
    return Center(
    
      child: CalendarDatePicker(
        initialDate: selectedDate.value,
        firstDate: DateTime(2022),
        lastDate: DateTime(2025),
        onDateChanged: (date) {
          selectedDate.value = date;
          print(selectedDate.value);
        },
      ),
    );
  }
}
