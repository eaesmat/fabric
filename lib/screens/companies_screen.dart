import 'package:flutter/material.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("comapnies"),
      ),
      body: Center(child: Text("Companies")),
    );
  }
}