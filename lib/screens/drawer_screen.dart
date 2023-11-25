// drawer_widget.dart

import 'package:fabricproject/screens/companies_screen.dart';
import 'package:fabricproject/widgets/drawer/expansion_tile.dart';
import 'package:fabricproject/widgets/language_item.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    navigateCompaniesCallBack() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const CompaniesScreen(),
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const ListTileWidget(
              lead: CircleAvatar(
                child: Icon(Icons.person_2_rounded),
              ),
              tileTitle: Text("Esmatullah Ahamdzai"),
              tileSubTitle: Text("ea.ahmadzai2020@gmail.com"),
              trail: Icon(Icons.notification_add),
            ),
            const Divider(
              thickness: .3,
            ),
            const ListTileWidget(
              lead: Icon(Icons.edit),
              tileTitle: LocaleText('edit_profile'),
            ),
            const Divider(
              thickness: .3,
            ),
            // expansion tile of app language
            // this comes as a widget
            const DrawerExpansionTile(
              lead: Icon(Icons.language),
              expansionTitle: LocaleText('language'),
              children: [
                LanguageItem(languageAbr: 'en', languageName: 'English'),
                Divider(
                  thickness: .1,
                ),
                LanguageItem(languageAbr: 'fa', languageName: 'دری'),
                Divider(
                  thickness: .1,
                ),
                LanguageItem(languageAbr: 'ps', languageName: 'پښتو'),
              ],
            ),
            const Divider(
              thickness: .3,
            ),
            DrawerExpansionTile(
              lead: const Icon(Icons.settings),
              expansionTitle: const LocaleText('general_settings'),
              children: [
                const Divider(thickness: .1),
                const ListTileWidget(
                  lead: Icon(Icons.settings),
                  tileTitle: LocaleText('sarafi'),
                ),
                const Divider(thickness: .1),
                ListTileWidget(
                  lead: const Icon(Icons.settings),
                  tileTitle: const LocaleText('internal_companies'),
                  callBack: navigateCompaniesCallBack,
                ),
                const Divider(thickness: .1),
                const ListTileWidget(
                  lead: Icon(Icons.settings),
                  tileTitle: LocaleText('fabric'),
                ),
                const Divider(thickness: .1),
                const ListTileWidget(
                  lead: Icon(Icons.settings),
                  tileTitle: LocaleText('ٰvendor_companies'),
                ),
                const Divider(thickness: .1),
                const ListTileWidget(
                  lead: Icon(Icons.settings),
                  tileTitle: LocaleText('ٰtransport'),
                ),
                const Divider(thickness: .1),
                const ListTileWidget(
                  lead: Icon(Icons.settings),
                  tileTitle: LocaleText('ٰwarehouses'),
                ),
                const Divider(thickness: .1),
                const ListTileWidget(
                  lead: Icon(Icons.settings),
                  tileTitle: LocaleText('customers'),
                ),
                const Divider(thickness: .1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
