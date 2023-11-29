import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String content;
  final Color backgroundColor;

  const CustomSnackBar({
    Key? key,
    required this.content,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(content),
      backgroundColor: backgroundColor,
    );
  }

  static show({
    required BuildContext context,
    required String content,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(
        content: content,
        backgroundColor: backgroundColor,
      ) as SnackBar,
    );
  }
}
