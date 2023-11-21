// home_screen.dart

import 'package:fabricproject/screens/drawer_scree.dart';
import 'package:fabricproject/screens/fabric_screen.dart';
import 'package:fabricproject/screens/home_screen.dart';
import 'package:fabricproject/screens/setting_screen.dart';
import 'package:fabricproject/widgets/bottom_navigation.dart'; // Import the new file
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPage = 0;
  List<Widget> pages = [const HomeScreen(), const FabricScreen(), const SettingScreen(), const DrawerScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: currentPage,
              children: pages,
            ),
          ),
          CustomBottomNavigationBar(
            currentPage: currentPage,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
          ),
        ],
      ),
    );
  }
}
