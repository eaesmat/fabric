import 'package:auto_direction/auto_direction.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class CustomTextFieldWithController extends StatefulWidget {
  final TextEditingController? controller;
  final bool? isDisabled;
  final LocaleText lblText;
  final Widget? iconBtn;
  final Function? onChanged;
  final Function(String?)? customValidator;
  final TextInputType? keyboardType;

  const CustomTextFieldWithController(
      {Key? key,
      this.controller,
      required this.lblText,
      this.onChanged,
      this.customValidator,
      this.iconBtn,
      this.keyboardType,
      this.isDisabled})
      : super(key: key);

  @override
  State<CustomTextFieldWithController> createState() =>
      _CustomTextFieldWithControllerState();
}

class _CustomTextFieldWithControllerState
    extends State<CustomTextFieldWithController> {
  String text = "";
  bool isRTL = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      child: Column(
        children: [
          AutoDirection(
            onDirectionChange: (isRTL) {
              setState(() {
                this.isRTL = isRTL;
              });
            },
            text: text,
            child: TextFormField(
              enabled: !(widget.isDisabled ?? false),
              keyboardType: widget.keyboardType,
              onChanged: (str) {
                setState(() {
                  text = str;
                  widget.onChanged?.call(str);
                });
              },
              controller: widget.controller,
              validator: (value) {
                return widget.customValidator?.call(value);
              },
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: widget.isDisabled != null && widget.isDisabled!
                      ? Pallete
                          .disabledBorder // Use Pallete.blackColor when disabled
                      : Pallete
                          .blueColor, // Use Pallete.blueColor when enabled or null
                  fontSize: 14,
                ),
                // enabled: widget.isDisabled,
                prefixIcon: widget.iconBtn,
                label: widget.lblText,

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
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Pallete.disabledBorder,
                    width: 1.0,
                  ),
                ),

                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: Pallete.redColor,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
        ],
      ),
    );
  }
}
