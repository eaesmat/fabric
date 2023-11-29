import 'package:fabricproject/screens/drawer_screen.dart';
import 'package:fabricproject/screens/fabric_screen.dart';
import 'package:fabricproject/screens/home_screen.dart';
import 'package:fabricproject/screens/setting_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(
      selectedIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuad,
    );
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);

    String getTitleForLanguageCode(String languageCode, String page) {
      if (languageCode == 'en') {
        switch (page) {
          case 'home':
            return "Home";
          case 'fabric':
            return "Fabric";
          case 'setting':
            return "Setting";
          case 'more':
            return "More";
          default:
            return "";
        }
      } else if (languageCode == 'fa') {
        switch (page) {
          case 'home':
            return "صفحه نخست";
          case 'fabric':
            return "تکه";
          case 'setting':
            return "تنظیمات";
          case 'more':
            return "بیشتر";
          default:
            return "";
        }
      } else if (languageCode == 'ps') {
        switch (page) {
          case 'home':
            return "کور پاڼه";
          case 'fabric':
            return "ټوکر";
          case 'setting':
            return "ترتیبات";
          case 'more':
            return "نور";
          default:
            return "";
        }
      } else {
        return "";
      }
    }

    List<BarItem> barItems = <BarItem>[
      BarItem(
        icon: Icons.home_filled,
        title: getTitleForLanguageCode(currentLocale.languageCode, 'home'),
      ),
      BarItem(
        icon: Icons.shopping_basket_sharp,
        title: getTitleForLanguageCode(currentLocale.languageCode, 'fabric'),
      ),
      BarItem(
        icon: Icons.settings_applications_rounded,
        title: getTitleForLanguageCode(currentLocale.languageCode, 'setting'),
      ),
      BarItem(
        icon: Icons.tune_rounded,
        title: getTitleForLanguageCode(currentLocale.languageCode, 'more'),
      ),
    ];

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _listOfWidget,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Pallete.whiteColor,
        onButtonPressed: onButtonPressed,
        iconSize: 30,
        activeColor: Pallete.blueColor,
        inactiveColor: Pallete.greyColor,
        selectedIndex: selectedIndex,
        barItems: barItems,
      ),
    );
  }
}

List<Widget> _listOfWidget = <Widget>[
  Container(
    alignment: Alignment.center,
    child:  const HomeScreen(),
  ),
  Container(
    alignment: Alignment.center,
    child: const FabricScreen(),
  ),
  Container(
    alignment: Alignment.center,
    child: const SettingScreen(),
  ),
  Container(
    alignment: Alignment.center,
    child: const DrawerScreen(),
  ),
];
