import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(color: Pallete.blackColor),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("This is the Home screen!"),
      ),
      //BottomNavigation comes from its widget class to display bottomNavigationBar
      // bottomNavigationBar: const BottomNavigation(),
    );
  }
}
