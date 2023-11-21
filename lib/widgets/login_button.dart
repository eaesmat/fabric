import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LoginButton extends StatelessWidget {
  // All of them comes from the login screen to handle buttons and their on click events
  final Icon btnIcon;
  final LocaleText btnText;
  final Color bgColor;
  final VoidCallback? callBack;
  const LoginButton(
      {super.key,
      required this.btnIcon,
      required this.btnText,
      this.bgColor = Colors.blue,
      this.callBack});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(size.width * 1, size.height * 0.07),
            backgroundColor: bgColor),
        onPressed: callBack,
        icon: btnIcon,
        label: btnText,
      ),
    );
  }
}
