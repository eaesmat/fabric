// drawer_widget.dart

import 'package:fabricproject/screens/external_companies_screen.dart';
import 'package:fabricproject/screens/forex_screen.dart';
import 'package:fabricproject/screens/internal_companies_screen.dart';
import 'package:fabricproject/screens/sarai_screen.dart';
import 'package:fabricproject/screens/transport.dart';
import 'package:fabricproject/widgets/expansion_tile.dart';
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
          builder: (_) => const InternalCompaniesScreen(),
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // User profile
            const ListTileWidget(
              lead: FaIcon(
                FontAwesomeIcons.circleUser,
                size: 20,
              ),
              tileTitle: Text(
                "Esmatullah Ahamdzai",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              tileSubTitle: Text("ea.ahmadzai2020@gmail.com"),
              trail: Icon(Icons.notification_add),
            ),
// User profile ends

// Khalid section
            const ListTileWidget(
              lead: FaIcon(
                FontAwesomeIcons.user,
                size: 20,
              ),
              tileTitle: LocaleText('khalid_account'),
            ),
// Khalid section ends

// General Settings
            ExpansionTileWidget(
              lead: FaIcon(
                FontAwesomeIcons.gear,
                size: 20,
              ),
              expansionTitle: const LocaleText('general_settings'),
              children: [
                const Divider(
                  thickness: 0.1,
                ),
                ExpansionTileItemWidget(
                  lead: const FaIcon(FontAwesomeIcons.wallet, size: 20),
                  tileTitle: const LocaleText('sarafi'),
                  callBack: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForexScreen(),
                      ),
                    );
                  },
                ),
                ExpansionTileItemWidget(
                  lead: const FaIcon(FontAwesomeIcons.buildingWheat, size: 18),
                  tileTitle: const LocaleText('internal_companies'),
                  callBack: navigateCompaniesCallBack,
                ),
                ExpansionTileItemWidget(
                  lead: Image.asset(
                    'assets/images/fabricIcon.png',
                    height: 23,
                  ),
                  tileTitle: const LocaleText('fabric'),
                ),
                ExpansionTileItemWidget(
                  callBack: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExternalCompaniesScreen(),
                      ),
                    );
                  },
                  lead: FaIcon(FontAwesomeIcons.buildingWheat, size: 18),
                  tileTitle: LocaleText('ٰvendor_companies'),
                ),
                ExpansionTileItemWidget(
                  callBack: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TransportScreen(),
                      ),
                    );
                  },
                  lead: Icon(Icons.local_shipping),
                  tileTitle: LocaleText('ٰtransport'),
                ),
                ExpansionTileItemWidget(
                  callBack: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SaraiScreen(),
                      ),
                    );
                  },
                  lead: Icon(Icons.warehouse),
                  tileTitle: LocaleText('ٰwarehouses'),
                ),
                const ExpansionTileItemWidget(
                  lead: FaIcon(FontAwesomeIcons.users, size: 20),
                  tileTitle: LocaleText('customers'),
                ),
              ],
            ),
            // General settings ends
            //Desires section
            const ExpansionTileWidget(
              lead: FaIcon(
                FontAwesomeIcons.users,
                size: 20,
              ),
              expansionTitle: LocaleText('desires'),
              children: [
                Divider(
                  thickness: 0.1,
                ),
                ExpansionTileItemWidget(
                  lead: FaIcon(
                    FontAwesomeIcons.circleDollarToSlot,
                    size: 20,
                  ),
                  tileTitle: LocaleText(
                    'chineseـaccounts',
                  ),
                ),
                ExpansionTileItemWidget(
                  lead: FaIcon(
                    FontAwesomeIcons.circleDollarToSlot,
                    size: 20,
                  ),
                  tileTitle: LocaleText(
                    'buying_for_others',
                  ),
                ),
                ExpansionTileItemWidget(
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
// Desires section ends
// Goods on the way
            const ListTileWidget(
              lead: Icon(Icons.local_shipping),
              tileTitle: LocaleText("goods_on_the_way"),
            ),
// Goods on the way ends
// Transport
            const ListTileWidget(
              lead: FaIcon(FontAwesomeIcons.truckFast, size: 20),
              tileTitle: LocaleText("ٰtransport"),
            ),
// Transport ends
// Warehouse starts
            const ExpansionTileWidget(
              lead: FaIcon(
                FontAwesomeIcons.warehouse,
                size: 20,
              ),
              expansionTitle: LocaleText("warehouse_goods"),
              children: [
                ExpansionTileItemWidget(
                  lead: Icon(Icons.warehouse),
                  tileTitle: LocaleText("sarai"),
                ),
                ExpansionTileItemWidget(
                    lead: Icon(Icons.list),
                    tileTitle: LocaleText("list_of_items"))
              ],
            ),
//Warehouse ends
// Hamid accounts section
            const ListTileWidget(
              lead: FaIcon(
                FontAwesomeIcons.user,
                size: 20,
              ),
              tileTitle: LocaleText('hamid_account'),
            ),
// Hamid accounts section ends
// Customers accounts section
            const ListTileWidget(
              lead: FaIcon(
                FontAwesomeIcons.peopleArrows,
                size: 20,
              ),
              tileTitle: LocaleText('customers_accounts'),
            ),
// Customers accounts section ends
// Forex
            const ListTileWidget(
              lead: FaIcon(
                FontAwesomeIcons.wallet,
                size: 20,
              ),
              tileTitle: LocaleText('sarafi'),
            ),
//  Forex section ends
// Users section
            const ListTileWidget(
              lead: FaIcon(
                FontAwesomeIcons.users,
                size: 20,
              ),
              tileTitle: LocaleText('users'),
            ),
//  Users section ends
          ],
        ),
      ),
    );
  }
}
