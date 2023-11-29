import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LocaleTexts extends StatelessWidget {
  final String localeText;
  const LocaleTexts({
    super.key,
    required this.localeText,
  });

  @override
  Widget build(BuildContext context) {
    return LocaleText(
      localeText,
      style: const TextStyle(
          color: Pallete.blackColor, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
