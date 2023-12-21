import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  // All of them comes from the login screen to handle buttons and their on click events
  final Widget btnIcon;
  final Widget btnText;
  final Color bgColor;
  final Function? onTap;
  final double btnWidth;
  const CustomDropDownButton(
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
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Column(
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                minimumSize: Size(size.width * btnWidth, size.height * 0.065),
                backgroundColor: bgColor),
            onPressed: () {
              onTap!();
            },
            icon: btnIcon,
            label: btnText,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
