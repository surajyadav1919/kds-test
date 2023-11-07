import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateController extends GetxController{
  RxString dateSelect = "".obs;
  Future<void> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now(); // Initialize with the current date
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate)
        selectedDate = picked;
    String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    dateSelect.value = formattedDate;
    update();
  }
}