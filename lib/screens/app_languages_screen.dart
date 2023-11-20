import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/language_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class AppLanguagesScreen extends StatefulWidget {
  const AppLanguagesScreen({super.key});

  @override
  State<AppLanguagesScreen> createState() => _AppLanguagesScreenState();
}

class _AppLanguagesScreenState extends State<AppLanguagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(
          "language",
          style: TextStyle(
              color: Pallete.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          LanguageItem(languageAbr: 'en', languageName: 'English'),
          LanguageItem(languageAbr: 'fa', languageName: 'دری'),
          LanguageItem(languageAbr: 'ps', languageName: 'پښتو'),
        ],
      ),
    );
  }
}
