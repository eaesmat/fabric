import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class CustomButton extends StatelessWidget {
  // All of them comes from the login screen to handle buttons and their on click events
  final Icon btnIcon;
  final LocaleText btnText;
  final Color bgColor;
  final Function? onTap;
  final double btnWidth;
  const CustomButton(
      {super.key,
      required this.btnIcon,
      required this.btnText,
      this.bgColor = Colors.blue,
     required this.btnWidth,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(size.width * btnWidth, size.height * 0.07),
            backgroundColor: bgColor),
        onPressed: () {
          onTap!();
        },
        icon: btnIcon,
        label: btnText,
      ),
    );
  }
}
