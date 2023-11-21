import 'package:auto_direction/auto_direction.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class TextsField extends StatefulWidget {
  final TextEditingController? controller;
  final LocaleText lblText;
  const TextsField(
      {super.key, required this.controller, required this.lblText});

  @override
  State<TextsField> createState() => _TextsFieldState();
}

class _TextsFieldState extends State<TextsField> {
  String text = "";
  bool isRTL = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal:  size.width * 0.03),
      child: AutoDirection(
        onDirectionChange: (isRTL) {
          setState(() {
            this.isRTL = isRTL;
          });
        },
        text: text,
        child: TextField(
          onChanged: (str) {
            setState(() {
              text = str;
            });
          },
          controller: widget.controller!,
          decoration: InputDecoration(
            label: widget.lblText,
            labelStyle: const TextStyle(color: Pallete.blueColor, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 10), // Adjust the value as needed
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: Pallete.blueColor, // Assuming Pallete.blueColor is defined
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: Pallete.blueColor, // Assuming Pallete.blueColor is defined
                width: 1.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: Pallete.redColor, // Assuming Pallete.blueColor is defined
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
