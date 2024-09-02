import 'package:flutter/material.dart';

class PriorityDot extends StatelessWidget {
  final String priority;

  const PriorityDot({Key? key, required this.priority}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: _getPriorityColor(priority),
        shape: BoxShape.circle,
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
