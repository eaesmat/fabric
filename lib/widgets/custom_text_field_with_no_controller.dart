import 'package:auto_direction/auto_direction.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class CustomTextFieldWithNoController extends StatefulWidget {
  // All of them comes from other widgets where CustomTextFieldWithNoControllers is used
  // final TextEditingController? controller;
  final LocaleText lblText;
  final Function? onChanged;

  const CustomTextFieldWithNoController({
    super.key,
    required this.lblText,
    this.onChanged,
  });

  @override
  State<CustomTextFieldWithNoController> createState() => _CustomTextFieldWithNoControllerState();
}

class _CustomTextFieldWithNoControllerState extends State<CustomTextFieldWithNoController> {
  // These vars are used for Auto-Direction
  // package to make text fields direction according to the language of keyboard
  String text = "";
  bool isRTL = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
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
              widget.onChanged!(str);
            });
          },
          decoration: InputDecoration(
            label: widget.lblText,
            labelStyle: const TextStyle(
              color: Pallete.blueColor,
              fontSize: 14,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: Pallete.blueColor,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: Pallete.blueColor,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
