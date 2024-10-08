import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class DateTimeBuilder {
  BuildContext context;

  DateTimeBuilder({required this.context});

  Future<DateTime?> showDatePickerView(
      {required DateTime firstDate, required DateTime lastDate}) {
    return showDatePicker(
        context: context, firstDate: firstDate, lastDate: lastDate);
  }

  Future<TimeOfDay?> showTimePickerView({required TimeOfDay initialTime}){
    return showTimePicker(context: context, initialTime: initialTime);
  }

  Future<DateTime?> showDateTimePickerView({
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      cancelText: CANCEL,
      confirmText: DONE,
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );

    return selectedTime == null
        ? selectedDate
        : DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }
}
