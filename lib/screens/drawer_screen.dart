// drawer_widget.dart

import 'package:fabricproject/widgets/language_item.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.person_2_rounded)),
            title: Text(
              "Esmatullah Ahmadzai",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("ea.ahmadzai2020@gmail.com"),
            trailing: Icon(Icons.notification_add),
          ),
          Divider(
            thickness: .3,
          ),
          ListTile(
            minVerticalPadding: 0, // else 2px still present
            dense: true, // else 2px still present
            visualDensity: VisualDensity.compact, // Else theme will be use
            contentPadding: EdgeInsets.symmetric(horizontal: 20),

            leading: Icon(
              Icons.edit,
              size: 16,
            ),
            title: Text(
              "Edit Profile",
              style: TextStyle(fontSize: 14),
            ),
            // trailing: Icon(
            //   Icons.ads_click,
            //   size: 16,
            // ),
          ),
          Divider(
            thickness: .3,
          ),
          ExpansionTile(
            shape: Border(),
            leading: Icon(Icons.language),
            title: Text("Languages"),
            childrenPadding: EdgeInsets.only(left: 10, right: 10),
            // trailing: Icon(Icons.arrow_drop_down),
            children: [
              LanguageItem(languageAbr: 'en', languageName: 'English'),
              LanguageItem(languageAbr: 'fa', languageName: 'دری'),
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
          