import 'package:auto_direction/auto_direction.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
class CustomTextFieldWithNoController extends StatefulWidget {
  final LocaleText lblText;
  // final Function(String?)? customValidator;

  const CustomTextFieldWithNoController({
    Key? key,
    required this.lblText,
    // this.customValidator,
  }) : super(key: key);

  @override
  State<CustomTextFieldWithNoController> createState() =>
      _CustomTextFieldWithNoControllerState();
}

class _CustomTextFieldWithNoControllerState
    extends State<CustomTextFieldWithNoController> {
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
        child: TextFormField(
          onChanged: (str) {
            setState(() {
              text = str;
            
            });
          },
          // validator: (value) {
          //   if (widget.customValidator != null) {
          //     return widget.customValidator!(value);
          //   }
          //   return null; // Return null for valid input
          // },
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
