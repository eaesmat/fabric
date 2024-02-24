import 'package:flutter/material.dart';

class Pallete {
  // Colors F3E8E2
  static const whiteColor = Color.fromRGBO(243, 233, 226, 1);
  static const dividerColor = Color.fromARGB(255, 215, 220, 222);
  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const greyColor = Color.fromRGBO(26, 39, 45, 1); // secondary color
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const blueColor = Color.fromRGBO(0, 104, 177, 1);
  static var redColor = Colors.red.shade500;
  static const disabledBorder = Color.fromARGB(255, 147, 168, 172);

  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Bahij-Pashto',
        ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      dense: true,
      minLeadingWidth: 0,
      minVerticalPadding: 0.0,
      visualDensity: VisualDensity.compact, // Else theme will be use
    ),
    scaffoldBackgroundColor: blackColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: drawerColor,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: drawerColor,
    ),
    primaryColor: redColor,
    // ignore: deprecated_member_use
    backgroundColor:
        drawerColor, // will be used as alternative background color
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Bahij-Pashto',
        ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      dense: true,
      minLeadingWidth: 0,
      minVerticalPadding: 0.0,
      visualDensity: VisualDensity.compact,
      // Else theme will be use
    ),
    
    scaffoldBackgroundColor: whiteColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: blackColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: whiteColor,
    // ignore: deprecated_member_use
    backgroundColor: whiteColor,
  );
}
