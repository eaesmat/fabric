import 'package:fabricproject/screens/main_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/login_screen_appbar.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // form text controllers will be assign to the button constructor
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final size = MediaQuery.of(context).size;
    // function to be called on button click of widget button

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Pallete.blueColor,
            // login screen app bar comes as a widget here
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
            SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.03),
                    child: SvgPicture.asset(
                      'assets/images/logo.svg',
                      width: size.width * 0.6,
                      // ignore: deprecated_member_use
                      color: Pallete.blueColor,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  CustomTextFieldWithController(
                    controller: emailController,
                    lblText: const LocaleText('email'),
                  ),
                  CustomTextFieldWithController(
                    controller: passwordController,
                    lblText: const LocaleText(
                      'password',
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  const LocaleText('forgotـpassword',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Pallete.blueColor,
                          fontSize: 12)),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  CustomDropDownButton(
                    btnWidth: 1,
                    btnIcon: const Icon(Icons.login, color: Pallete.whiteColor),
                    btnText: const LocaleText(
                      'signin',
                      style: TextStyle(fontSize: 12, color: Pallete.whiteColor),
                    ),
                    bgColor: Pallete.blueColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  const Divider(
                    color: Pallete.blueColor,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  CustomDropDownButton(
                    btnWidth: 1,
                    btnIcon: const Icon(Icons.email),
                    btnText: const LocaleText(
                      'sign_in_with_google',
                      style: TextStyle(fontSize: 12),
                    ),
                    bgColor: Pallete.redColor,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  const CustomDropDownButton(
                    btnWidth: 1,
                    btnIcon: Icon(Icons.facebook_sharp),
                    btnText: LocaleText(
                      'sign_in_with_facebook',
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
