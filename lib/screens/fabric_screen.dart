import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';

var currentIndex = 0;

class FabricScreen extends StatefulWidget {
  const FabricScreen({super.key});

  @override
  State<FabricScreen> createState() => _FabricScreenState();
}

class _FabricScreenState extends State<FabricScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fabric",
          style: TextStyle(color: Pallete.blackColor),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("This is the Fabric screen!"),
      ),
      //BottomNavigation comes from its widget class to display bottomNavigationBar
      // bottomNavigationBar: const BottomNavigation(),
    );
  }
}
