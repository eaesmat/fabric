import 'dart:ui';

import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';

String? customValidator(String? value, Locale currentLocale) {
  if (value == null || value.isEmpty) {
    if (currentLocale.languageCode == 'en') {
      return 'Required!';
    } else if (currentLocale.languageCode == 'fa') {
      return 'الزامی';
    } else if (currentLocale.languageCode == 'ps') {
      return 'اړین';
    }
  }
  return null;
}

String? customValidatorCheckNumberOnly(String? value, Locale currentLocale) {
  // Trim leading and trailing spaces from the input value
  final trimmedValue = value?.trim();

  if (value == null || trimmedValue!.isEmpty) {
    if (currentLocale.languageCode == 'en') {
      return 'Required';
    } else if (currentLocale.languageCode == 'fa') {
      return 'الزامی';
    } else if (currentLocale.languageCode == 'ps') {
      return 'اړین';
    }
  }

  // Check if the original value is different from the trimmed value, indicating leading or trailing spaces
  if (value != trimmedValue) {
    if (currentLocale.languageCode == 'en') {
      return 'Please remove leading or trailing spaces';
    } else if (currentLocale.languageCode == 'fa') {
      return 'لطفاً فاصله‌های شروع یا پایانی را حذف کنید';
    } else if (currentLocale.languageCode == 'ps') {
      return 'مهرباني وکړئ مخکې او وروسته خالې فاصلې پاکي کړئ';
    }
  }

  // Check if the trimmed value is zero
  if (double.tryParse(trimmedValue!) == 0) {
    if (currentLocale.languageCode == 'en') {
      return 'Zero is not allowed';
    } else if (currentLocale.languageCode == 'fa') {
      return 'صفر مجاز نیست';
    } else if (currentLocale.languageCode == 'ps') {
      return 'صفر ته اجازه نشته';
    }
  }

  // Use a regular expression to check if the trimmed value contains only numbers
  // This regex pattern allows integers or floating-point numbers
  final RegExp regex = RegExp(r'^\d*\.?\d+$');
  if (!regex.hasMatch(trimmedValue)) {
    // If the value contains characters other than numbers or decimal points, return an error message
    if (currentLocale.languageCode == 'en') {
      return 'Please enter a valid number (e.g., 123 or 123.45)';
    } else if (currentLocale.languageCode == 'fa') {
      return 'لطفاً یک عدد معتبر وارد کنید (مثال: ۱۲۳ یا ۱۲۳٫۴۵)';
    } else if (currentLocale.languageCode == 'ps') {
      return 'مهرباني وکړئ یوه معتبره شمیره ولیکئ (د مثال په توګه، ۱۲۳ یا ۱۲۳٫۴۵)';
    }
  }

  return null;
}



String? showShopIfNoSarafi(String? value, Locale currentLocale) {
  if (value == null || value.isEmpty) {
    if (currentLocale.languageCode == 'en') {
      return 'Shop';
    } else if (currentLocale.languageCode == 'fa') {
      return 'دوکان ';
    } else if (currentLocale.languageCode == 'ps') {
      return 'هټۍ';
    }
  }
  return null;
}

String showSaraiType(String? value, Locale currentLocale) {
  if (value == null || value.isEmpty) {
    return '';
  }

  if (currentLocale.languageCode == 'en') {
    if (value == 'تخلیه') {
      return 'Unload';
    } else if (value == 'دوکان') {
      return 'Shop';
    } else {
      return 'Warehouse';
    }
  } else if (currentLocale.languageCode == 'fa') {
    if (value == 'تخلیه') {
      return 'تخلیه';
    } else if (value == 'دوکان') {
      return 'دوکان';
    } else {
      return 'گدام';
    }
  } else if (currentLocale.languageCode == 'ps') {
    if (value == 'تخلیه') {
      return 'تخلیه';
    } else if (value == 'دوکان') {
      return 'دوکان';
    } else {
      return 'ګدام';
    }
  }

  return '';
}




Color getColorFromName(String colorName) {
  switch (colorName.toLowerCase()) {
    case "جگری":
      return Colors.red.shade900;
    case "سبز":
      return Colors.green;
    case "سرخ":
      return Colors.red;
    case "سیاه":
      return Colors.black;
    case "گلابی":
      return Colors.pink;
    case "سفید":
      return Colors.white;
    case "بنفش":
      return Colors.purple;
    case "آبی":
      return Colors.blue;
    case "یاسمندی":
      return Colors.deepPurple;
    case "آسمانی":
      return Colors.blueAccent;
    default:
      return Pallete.blueColor; // Default color
  }
}
