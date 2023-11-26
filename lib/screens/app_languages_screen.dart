import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/language_item.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Pallete.whiteColor,
        title: const LocaleTexts.new(localeText: 'language'),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          Divider(
            thickness: .3,
          ),
          // language item is widget class fo ListTile accepts the following params as constructor
          LanguageItem(languageAbr: 'en', languageName: 'English'),
          Divider(
            thickness: .3,
          ),
          LanguageItem(languageAbr: 'fa', languageName: 'دری'),
          Divider(
            thickness: .3,
          ),
          LanguageItem(languageAbr: 'ps', languageName: 'پښتو'),
          Divider(
            thickness: .3,
          ),
        ],
      ),
    );
  }
}

