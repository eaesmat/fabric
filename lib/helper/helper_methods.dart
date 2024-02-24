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
