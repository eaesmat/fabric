import 'package:fabricproject/screens/app_languages_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          ElevatedButton.icon(

            style: ElevatedButton.styleFrom(
              backgroundColor: Pallete.whiteColor,
              shadowColor: Colors.transparent,
            ).copyWith(elevation:ButtonStyleButton.allOrNull(0.0)),
            label: const LocaleText(
              "language",
              style: TextStyle(
                  color: Pallete.blackColor, fontWeight: FontWeight.normal),
            ),
            icon: const Icon(
              Icons.language_outlined,
              color: Pallete.blackColor,
            ),
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AppLanguagesScreen()))
            },
          ),
        ],
      )),
      body: const Center(child: Text("Home screen")),
    );
  }
}
