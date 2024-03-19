import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LanguageItem extends StatelessWidget {
  // these comes from language screen to make language names and its icons
  final String? languageName;
  final String? languageAbr;
  const LanguageItem(
      {super.key, required this.languageAbr, required this.languageName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              if (languageAbr == 'en')
                Flag.fromCode(FlagsCode.US, height: 20, width: 20),
              if (languageAbr == 'fa' || languageAbr == 'ar')
                Flag.fromCode(FlagsCode.AF, height: 20, width: 20),
              const SizedBox(
                width: 10,
              ),
              Text(
                languageName!,
              ),
            ],
          ),
          onTap: () {
            LocaleNotifier.of(context)?.change(languageAbr!);
          },
        ),
        const Divider(
          thickness: .1,
        )
      ],
    );
  }
}
