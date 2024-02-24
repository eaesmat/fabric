import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  final Widget btnIcon;
  final Widget? btnText;
  final Color bgColor;
  final Function? onTap;
  final double btnWidth;

  const CustomDropDownButton({
    Key? key,
    required this.btnIcon,
    this.btnText,
    this.bgColor = Colors.blue,
    required this.btnWidth,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              minimumSize: Size(size.width * btnWidth, size.height * 0.065),
              backgroundColor: bgColor,
            ),
            onPressed: onTap != null ? () => onTap!() : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                btnIcon,
                if (btnText != null)
                  SizedBox(width: 8), // Adjust spacing based on your needs
                if (btnText != null) btnText!,
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
