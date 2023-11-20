import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/login_sreen_appbar.dart';
import 'package:fabricproject/widgets/texts_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Pallete.blueColor,
            title: const LoginScreenAppBar()),
        body: Stack(
          children: [
            Container(
              height: size.height * 0.1,
              decoration: const BoxDecoration(
                color: Pallete.blueColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.0001),
              decoration: BoxDecoration(
                color: Pallete.whiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.height * 0.04),
                    topRight: Radius.circular(size.height * 0.04)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.05),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    width: size.width * 0.4,
                    color: Pallete.blueColor,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  TextsField(
                    controller: emailController,
                    lblText: const LocaleText('email'),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextsField(
                    controller: passwordController,
                    lblText: const LocaleText('password'),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  const LocaleText('forgotـpassword',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Pallete.blueColor, fontSize: 12)),
                          SizedBox(
                    height: size.height * 0.01,
                  ),
                  TextsField(
                    controller: passwordController,
                    lblText: const LocaleText('password'),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
