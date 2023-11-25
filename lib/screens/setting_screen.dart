import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/drop_dwon.dart';
import 'package:flutter/material.dart';

var currentIndex = 0;

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Pallete.blackColor),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child:  DropDown(),
      ),
      //BottomNavigation comes from its widget class to display bottomNavigationBar
      // bottomNavigationBar: const BottomNavigation(),
    );
  }
}


