// home_screen.dart

import 'package:fabricproject/screens/drawer_screen.dart';
import 'package:fabricproject/screens/fabric_screen.dart';
import 'package:fabricproject/screens/home_screen.dart';
import 'package:fabricproject/screens/setting_screen.dart';
import 'package:fabricproject/widgets/bottom_navigation.dart'; // Import the new file
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPage = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const FabricScreen(),
    const SettingScreen(),
    const DrawerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  CustomBottomNavigation(),
    );
  }
}
