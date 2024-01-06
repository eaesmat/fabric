// home_screen.dart

import 'package:fabricproject/screens/drawer_screen.dart';
import 'package:fabricproject/screens/fabric_screen.dart';
import 'package:fabricproject/screens/home_screen.dart';
import 'package:fabricproject/screens/setting_screen.dart';
import 'package:fabricproject/screens/vendor_company/vendor_company_list_screen.dart';
import 'package:fabricproject/widgets/bottom_navigation.dart'; // Import the new file
import 'package:fabricproject/screens/vendor_company/vendor_company_details_screen.dart';
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
    const VendorCompanyListScreen(),
    const SettingScreen(),
    const DrawerScreen()
  ];

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

          //This widget comes to display bottom navigation and control page routes
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