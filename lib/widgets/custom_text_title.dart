import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';

class CustomTextTitle extends StatelessWidget {
  final String text;
  const CustomTextTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Pallete.blackColor, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
