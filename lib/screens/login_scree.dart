import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/login_sreen_appbar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const LoginScreenAppBar()),
      body: const Center(child: Text("Home screen", style: TextStyle(color: Pallete.blueColor),)),
    );
  }
}
