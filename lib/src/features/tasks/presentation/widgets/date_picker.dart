import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


Widget createDatePicker(BuildContext context, DateTime dateField, String label, void Function(DateTime)? onDateChanged) {
  return TextField(
    onTap: () async {
      // Show Date Picker
      DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: dateField,
        firstDate: DateTime(2024),
        lastDate: DateTime(2026),
      );


          // Invoke the onDateChanged callback
          if (onDateChanged != null) {
            onDateChanged(selectedDate!);
          }
    },
    decoration: InputDecoration(
      labelText: label,
      errorText: dateField.isBefore(DateTime.now()) ? "Date can't be in the past" : null,
    ),
    controller: TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(dateField)?? '',
    ),
    readOnly: true,
  );
}