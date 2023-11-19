import 'package:auto_direction/auto_direction.dart';
import 'package:flag/flag.dart';
import 'package:flag/flag_widget.dart';
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
        home: const HomeScreen(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const LanguageScreen()))
        },
        child: const Icon(Icons.language_outlined),
      ),
    );
  }
}

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(
          "language",
          style: TextStyle(color: Pallete.blackColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Flag.fromCode(FlagsCode.US, height: 20, width: 20),
              const SizedBox(width: 10,),
                const Text(
                  'English',
                ),
              ],
            ),
            onTap: () {
              LocaleNotifier.of(context)?.change('en');
            },
          ),
          ListTile(
             title: Row(
              children: [
                Flag.fromCode(FlagsCode.AF, height: 20, width: 20),
              const SizedBox(width: 10,),
                const Text(
                  'دری',
                ),
              ],
            ),
            onTap: () {
              LocaleNotifier.of(context)?.change('fa');
            },
          ),
          ListTile(
             title: Row(
              children: [
                Flag.fromCode(FlagsCode.AF, height: 20, width: 20),
              const SizedBox(width: 10,),
                const Text(
                  'پښتو',
                ),
              ],
            ),
            onTap: () {
              LocaleNotifier.of(context)?.change('ps');
            },
          ),
        ],
      ),
    );
  }
}
