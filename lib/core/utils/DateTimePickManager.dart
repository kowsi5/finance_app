import 'dart:async';
import 'package:finance_app/core/res/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';

class DateTimePickManager {
  DateTimePickManager._();
}

Future<String?> callDatePicker(context) async {
  String selectedDate = "";
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2100));
  if (pickedDate != null) {
    selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
  } else {}
  return Future.value(selectedDate);
}

Future<String?> callBannerDatePicker(context) async {
  String selectedDate = "";
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100));
  if (pickedDate != null) {
    selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
  } else {}
  return Future.value(selectedDate);
}

Future<String?> callFutureDatePicker(context) async {
  String selectedDate = "";

  DateTime? pickedDate = await DatePicker.showSimpleDatePicker(
    context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
    dateFormat: "yyyy-MM-dd",
    locale: DateTimePickerLocale.en_us,
    looping: true,
  );
  if (pickedDate != null) {
    selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
  } else {}
  return Future.value(selectedDate);
}

Future<String?> callDOBDatePicker(context) async {
  String selectedDate = "";
  DateTime? pickedDate = await DatePicker.showSimpleDatePicker(
    context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime.now(),
    dateFormat: "yyyy-MM-dd",
    itemTextStyle: AppStyle.textAppStyle,
    titleText: "Select DOB",
    locale: DateTimePickerLocale.en_us,
    looping: false,
  );

  if (pickedDate != null) {
    selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
  } else {}
  return Future.value(selectedDate);
}

Future<String?> callTimePicker(context) async {
  String selectedTime = "";
  TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: const TimeOfDay(hour: 00, minute: 00),
      builder: (BuildContext context, Widget? child) {
        // Ensure 12-hour format by providing localization
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      });
  if (pickedTime != null) {
    selectedTime = pickedTime.format(context);
    // var df = DateFormat("hh:mm a");
    // var dt = df.parse(selectedTime.replaceAll(" ", ""));
    // selectedTime = DateFormat('HH:mm:ss').format(dt);
  } else {}
  return Future.value(selectedTime);
}
