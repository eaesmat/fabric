import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class NoBundleColorScreen extends StatelessWidget {
  final String warningText;

  const NoBundleColorScreen({Key? key, required this.warningText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/isComplete.png',
                      fit: BoxFit.contain, // Ensure the image fits within available space
                    ),
                    const SizedBox(height: 20), // Adding some spacing between image and icon
                    Icon(
                      Icons.warning,
                      size: 60,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(height: 10), // Adding some spacing between icon and text
                    LocaleText(
                      warningText,
                      style: const TextStyle(
                        color: Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
