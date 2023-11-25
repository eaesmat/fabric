import 'package:fabricproject/screens/fabric_screen.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FabricScreen(),
          ),
        );
      },
      child: Chip(
        avatar: CircleAvatar(
          backgroundColor: Colors.grey.shade800,
          child: const Text('AB'),
        ),
        label: const Text('Aaron Burr'),
      ),
    ));
  }
}
