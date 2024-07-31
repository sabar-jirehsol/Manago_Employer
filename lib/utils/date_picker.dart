import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manago_employer/utils/color_constants.dart';

class DatePickerClass {
  static DateFormat formatter = DateFormat('dd/MM/yyyy');

  static Future<DateTime?> selectDate(BuildContext context,
      {DateTime? firstDate, DateTime? lastDate}) async {
    DateTime? picked =await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate ?? DateTime(1940),
      lastDate: lastDate ?? DateTime(3000),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(            colorScheme: const ColorScheme.light(
              primary:  Color(0xff1E3852),
                onPrimary: Colors.white,
                onBackground: Colors.white,
              onSurface: Color.fromARGB(255, 66, 125, 145),


            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff054543), // button text color
              ),
            ),
            datePickerTheme: const DatePickerThemeData(
              headerBackgroundColor: Color(0xff1E3852),
              backgroundColor: Colors.white,
              headerForegroundColor: Colors.white,
              shape: RoundedRectangleBorder( // Set the shape to RoundedRectangleBorder
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0), // Adjust the border radius as needed
                ),
              ),
              surfaceTintColor: Colors.white,

            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      return picked;
    } else {
      return null;
    }
  }

  static String dateFormatterMethod(DateTime date) {
    DateFormat formatter = DateFormat('dd/MM/yy');
    if (date.isUtc) {
      String format = formatter.format(date.add(const Duration(days: 3)));
      return format;
    } else {
      String formatted = formatter.format(date);
      return formatted;
    }
  }

  static String dateFormatterMonths(DateTime date) {
    DateFormat formatter = DateFormat.yMMMMd();
    String formatted = formatter.format(date.add(const Duration(days: 3)));
    return formatted;
  }

  static String monthYear(DateTime date) {
    DateFormat formatter = DateFormat.yMMMM();
    String formatted = formatter.format(date);
    return formatted;
  }
}
