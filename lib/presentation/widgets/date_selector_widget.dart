import 'package:flutter/material.dart';
import 'package:gym/core/resources/functions.dart';

class DateSelector extends StatefulWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected; // Callback to pass the selected date

  const DateSelector({
    super.key,
    this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  // Method to show the date picker and update the selected date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != widget.selectedDate) {
      widget.onDateSelected(
          pickedDate); // Call the callback to update the date in the parent
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context), // Trigger date picker on tap
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          border: Border.all(color: Colors.grey), // Optional border
        ),
        child: Center(
          child: Text(
            widget.selectedDate != null
                ? dateFormate(date: widget.selectedDate ?? DateTime.now())
                : 'Select Date', // Show the selected date or a placeholder
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
