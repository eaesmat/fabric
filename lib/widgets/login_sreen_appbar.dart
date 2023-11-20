
import 'package:fabricproject/screens/app_languages_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LoginScreenAppBar extends StatelessWidget {
  const LoginScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
    ElevatedButton.icon(

      style: ElevatedButton.styleFrom(
        backgroundColor: Pallete.whiteColor,
        shadowColor: Colors.transparent,
      ).copyWith(elevation:ButtonStyleButton.allOrNull(0.0)),
      label: const LocaleText(
        "language",
        style: TextStyle(
            color: Pallete.blueColor, fontWeight: FontWeight.bold),
      ),
      icon: const Icon(
        Icons.language_outlined,
        color: Pallete.blueColor,
      ),
      onPressed: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AppLanguagesScreen()))
      },
    ),
        ],
      );
  }
}
