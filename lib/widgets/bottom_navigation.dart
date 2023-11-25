import 'package:fabricproject/screens/drawer_screen.dart';
import 'package:fabricproject/screens/fabric_screen.dart';
import 'package:fabricproject/screens/home_screen.dart';
import 'package:fabricproject/screens/setting_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
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
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
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
        barItems: <BarItem>[
          BarItem(
            icon: Icons.home_filled,
            title: 'Home',
          ),
          BarItem(
            icon: Icons.shopping_basket_sharp,
            title: 'Fabric',
          ),
          BarItem(
            icon: Icons.settings_applications_rounded,
            title: 'Setting',
          ),
          BarItem(
            icon: Icons.tune_rounded,
            title: 'More',
          ),
        ],
      ),
    );
  }
}

// icon size:24 for fontAwesomeIcons
// icons size: 30 for MaterialIcons

List<Widget> _listOfWidget = <Widget>[
  Container(
    alignment: Alignment.center,
    child: const HomeScreen(),
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
