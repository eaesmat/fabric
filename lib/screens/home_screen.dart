import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

var currentIndex = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        child: Text("This is the home screen!"),
      ),
      //BottomNavigation comes from its widget class to display bottomNavigationBar
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
