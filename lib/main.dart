import 'package:auto_direction/auto_direction.dart';
import 'package:fabricproject/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:fabricproject/theme/pallete.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'fa', 'ps']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (locale) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        locale: locale,
        theme: Pallete.lightModeAppTheme,
        home: const SplashScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          AutoDirection(
            text: text,
            child: TextField(
              onChanged: (str) {
                setState(() {
                  text = str;
                });
              },
            ),
          ),
          const Text('دری')
        ],
      )),
    );
  }
}
