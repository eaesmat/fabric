import 'package:fabricproject/widgets/expansion_tile.dart';
import 'package:fabricproject/widgets/language_item.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // User profile
            ListTileWidget(
              lead: CircleAvatar(
                child: Icon(Icons.person_2_rounded),
              ),
              tileTitle: Text(
                "Esmatullah Ahamdzai",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              tileSubTitle: Text("ea.ahmadzai2020@gmail.com"),
              trail: Icon(Icons.notification_add),
            ),
// User profile ends
// Edit profile
            ListTileWidget(
              lead: Icon(
                Icons.edit,
              ),
              tileTitle: LocaleText('edit_profile'),
            ),
//Edit Profile ends
            // expansion tile of app language
            // this comes as a widget
            /// Language section
            ExpansionTileWidget(
              lead: Icon(Icons.language),
              expansionTitle: LocaleText('language'),
              children: [
                LanguageItem(languageAbr: 'en', languageName: 'English'),
                LanguageItem(languageAbr: 'fa', languageName: 'دری'),
                LanguageItem(languageAbr: 'ar', languageName: 'پښتو'),
              ],
            ),
// Language section ends
          ],
        ),
      ),
    );
  }
}
