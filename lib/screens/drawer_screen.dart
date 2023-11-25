// drawer_widget.dart

import 'package:fabricproject/screens/companies_screen.dart';
import 'package:fabricproject/widgets/expansion_tile.dart';
import 'package:fabricproject/widgets/language_item.dart';
import 'package:fabricproject/widgets/list_tile_item_widget.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

            const ListTileWidget(
              lead: Icon(Icons.edit),
              tileTitle: LocaleText('edit_profile'),
            ),

            // expansion tile of app language
            // this comes as a widget
            const DrawerExpansionTile(
              lead: Icon(Icons.language),
              expansionTitle: LocaleText('language'),
              children: [
                LanguageItem(languageAbr: 'en', languageName: 'English'),
                LanguageItem(languageAbr: 'fa', languageName: 'دری'),
                LanguageItem(languageAbr: 'ps', languageName: 'پښتو'),
              ],
            ),

            const ListTileWidget(
              lead: Icon(Icons.person),
              tileTitle: LocaleText('javid_account'),
            ),

            const DrawerExpansionTile(
              lead: FaIcon(
                FontAwesomeIcons.users,
                size: 20,
              ),
              expansionTitle: LocaleText('desires'),
              children: [
                Divider(
                  thickness: 0.1,
                ),
                ListTileItemWidget(
                  lead: FaIcon(
                    FontAwesomeIcons.circleDollarToSlot,
                    size: 20,
                  ),
                  tileTitle: LocaleText(
                    'chineseـaccounts',
                  ),
                ),
                ListTileItemWidget(
                  lead: FaIcon(
                    FontAwesomeIcons.circleDollarToSlot,
                    size: 20,
                  ),
                  tileTitle: LocaleText(
                    'buying_for_others',
                  ),
                ),
                ListTileItemWidget(
                  lead: FaIcon(
                    FontAwesomeIcons.circleDollarToSlot,
                    size: 20,
                  ),
                  tileTitle: LocaleText(
                    'cash_loan',
                  ),
                ),
              ],
            ),

            DrawerExpansionTile(
              lead: const Icon(Icons.settings),
              expansionTitle: const LocaleText('general_settings'),
              children: [
                const Divider(
                  thickness: 0.1,
                ),
                const ListTileItemWidget(
                  lead: Icon(Icons.settings),
                  tileTitle: LocaleText('sarafi'),
                ),
                ListTileItemWidget(
                  lead: const Icon(Icons.settings),
                  tileTitle: const LocaleText('internal_companies'),
                  callBack: navigateCompaniesCallBack,
                ),
                const ListTileItemWidget(
                  lead: Icon(Icons.settings),
                  tileTitle: LocaleText('fabric'),
                ),
                const ListTileItemWidget(
                  lead: Icon(Icons.settings),
                  tileTitle: LocaleText('ٰvendor_companies'),
                ),
                const ListTileItemWidget(
                  lead: Icon(Icons.settings),
                  tileTitle: LocaleText('ٰtransport'),
                ),
                const ListTileItemWidget(
                  lead: Icon(Icons.settings),
                  tileTitle: LocaleText('ٰwarehouses'),
                ),
                const ListTileItemWidget(
                  lead: Icon(Icons.settings),
                  tileTitle: LocaleText('customers'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
