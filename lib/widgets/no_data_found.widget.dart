import 'package:flutter/material.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/noData.png',
        width: 800, // Set the width as needed
        height: 500, // Set the height as needed
      ),
    );
  }
}
