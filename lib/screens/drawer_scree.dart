import 'package:flutter/material.dart';

var currentIndex = 0;

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: const Center(
        child: Text("This is the drawer screen!"),
      ),
      //BottomNavigation comes from its widget class to display bottomNavigationBar
      // bottomNavigationBar: const BottomNavigation(),
    );
  }
}
