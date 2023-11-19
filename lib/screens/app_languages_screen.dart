
import 'package:fabricproject/theme/pallete.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
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
          style: TextStyle(color: Pallete.blackColor, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Flag.fromCode(FlagsCode.US, height: 20, width: 20),
              const SizedBox(width: 10,),
                const Text(
                  'English',
                ),
              ],
            ),
            onTap: () {
              LocaleNotifier.of(context)?.change('en');
            },
          ),
          ListTile(
             title: Row(
              children: [
                Flag.fromCode(FlagsCode.AF, height: 20, width: 20),
              const SizedBox(width: 10,),
                const Text(
                  'دری',
                ),
              ],
            ),
            onTap: () {
              LocaleNotifier.of(context)?.change('fa');
            },
          ),
          ListTile(
             title: Row(
              children: [
                Flag.fromCode(FlagsCode.AF, height: 20, width: 20),
              const SizedBox(width: 10,),
                const Text(
                  'پښتو',
                ),
              ],
            ),
            onTap: () {
              LocaleNotifier.of(context)?.change('ps');
            },
          ),
        ],
      ),
    );
  }
}
