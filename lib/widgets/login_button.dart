import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LoginButton extends StatelessWidget {
  final Icon btnIcon;
  final LocaleText btnText;
  final Color bgColor;
  // final CallbackAction func;
  const LoginButton(
      {super.key,
      required this.btnIcon,
      required this.btnText,
      this.bgColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(size.width * 1, size.height * 0.07),
            backgroundColor: bgColor),
        onPressed: () {},
        icon: btnIcon,
        label: btnText,
      ),
    );
  }
}
