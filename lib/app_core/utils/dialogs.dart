import 'package:flutter/material.dart';

class Dialogs {
  static Future<DateTime?> showDateTimePickerDialog(
    BuildContext context,
  ) async {
    return await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
  }
}
