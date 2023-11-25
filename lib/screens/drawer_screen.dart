// drawer_widget.dart

import 'package:fabricproject/widgets/drawer/expansion_tile.dart';
import 'package:fabricproject/widgets/language_item.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          ListTileWidget(
            lead: CircleAvatar(
              child: Icon(Icons.person_2_rounded),
            ),
            tileTitle: Text("Esmatullah Ahamdzai"),
            tileSubTitle: Text("ea.ahmadzai2020@gmail.com"),
            trail: Icon(Icons.notification_add),
          ),
          Divider(
            thickness: .3,
          ),
          ListTileWidget(
            lead: Icon(Icons.edit),
            tileTitle: LocaleText('edit_profile'),
          ),
          Divider(
            thickness: .3,
          ),
          // expansion tile of app language
          // this comes as a widget
          DrawerLanguageExpansionTile(
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
          Divider(
            thickness: .3,
          ),
        ],
      ),
    );
  }
}





 // Card(
          //   color: Pallete.whiteColor,
          //   child: Column(
          //     children: [
          //       SizedBox(
          //         width: double.infinity,
          //         child: Card(
          //           shape: ContinuousRectangleBorder(
          //               borderRadius: BorderRadius.circular(20)),
          //           // elevation: 10,
          //           child: ClipRRect(
          //             borderRadius: BorderRadius.circular(20),
          //             child: BackdropFilter(
          //               filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          //               child: Padding(
          //                 padding: EdgeInsets.all(12.0),
          //                 child: Column(
          //                   children: [
          //                     ExpansionTile(
          //                       // backgroundColor: Pallete.whiteColor,
          //                       shape: Border(),
          //                       title: const Text("Companies"),
          //                       leading: const Icon(Icons.person),
          //                       children: [
          //                         ListTile(
          //                           title: const Text("Ahmad Shah Baba"),
          //                           onTap: () {},
          //                         ),
          //                         ListTile(
          //                           title: const Text("Paktai Gardez"),
          //                           onTap: () {
          //                             Navigator.push(
          //                               context,
          //                               MaterialPageRoute(
          //                                 builder: (context) => const Test(),
          //                               ),
          //                             );
          //                           },
          //                         ),
          //                       ],
          //                     ),
          //                     Divider(),
          //                     ListTile(
          //                       title: const Text("Paktai Gardez"),
          //                       onTap: () {
          //                         Navigator.push(
          //                           context,
          //                           MaterialPageRoute(
          //                             builder: (context) => const Test(),
          //                           ),
          //                         );
          //                       },
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          //  Card(
          //   color: Pallete.whiteColor,
          //   child: Column(
          //     children: [
          //       SizedBox(
          //         width: double.infinity,
          //         child: Card(
          //           shape: ContinuousRectangleBorder(
          //               borderRadius: BorderRadius.circular(20)),
          //           // elevation: 10,
          //           child: ClipRRect(
          //             borderRadius: BorderRadius.circular(20),
          //             child: BackdropFilter(
          //               filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          //               child: Padding(
          //                 padding: EdgeInsets.all(12.0),
          //                 child: Column(
          //                   children: [
          //                     ExpansionTile(
          //                       // backgroundColor: Pallete.whiteColor,
          //                       shape: Border(),
          //                       title: const Text("Companies"),
          //                       leading: const Icon(Icons.person),
          //                       children: [
          //                         ListTile(
          //                           title: const Text("Ahmad Shah Baba"),
          //                           onTap: () {},
          //                         ),
          //                         ListTile(
          //                           title: const Text("Paktai Gardez"),
          //                           onTap: () {
          //                             Navigator.push(
          //                               context,
          //                               MaterialPageRoute(
          //                                 builder: (context) => const Test(),
          //                               ),
          //                             );
          //                           },
          //                         ),
          //                       ],
          //                     ),
          //                     Divider(),
          //                     ListTile(
          //                       title: const Text("Paktai Gardez"),
          //                       onTap: () {
          //                         Navigator.push(
          //                           context,
          //                           MaterialPageRoute(
          //                             builder: (context) => const Test(),
          //                           ),
          //                         );
          //                       },
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          