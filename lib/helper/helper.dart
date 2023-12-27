import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class HelperServices {
  late GlobalKey<NavigatorState> navigationKey;

  static HelperServices instance = HelperServices();

  HelperServices() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  void navigate(Widget rn) {
    navigationKey.currentState!.push(
      MaterialPageRoute(builder: (context) => rn),
    );
  }

  goBack() {
    return navigationKey.currentState!.pop();
  }

  showLoader() {
    Future.delayed(
      Duration.zero,
      () {
        showDialog(
          context: navigationKey.currentContext!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Scaffold(
              body: SafeArea(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Pallete.blueColor,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  showMessage(LocaleText message, Color color, Icon icon) {
    ScaffoldMessenger.of(navigationKey.currentContext!).showSnackBar(
      SnackBar(
        content: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              const SizedBox(
                width: 5,
              ),
              message,
            ],
          ),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: color,
      ),
    );
  }

  showErrorMessage(String message) {
    Future.delayed(
      Duration.zero,
      () {
        showDialog(
          context: navigationKey.currentContext!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Scaffold(
              body: Center(
                  child: Text(
                'Server error$message',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Pallete.redColor),
              )),
            );
          },
        );
      },
    );
  }

  confirmDeletion(String message, Function(int index) deleteItem, int index) {
    Future.delayed(
      Duration.zero,
      () {
        showDialog(
          context: navigationKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              title: const Text('delete_confirmation'),
              content: const Text('are_you_sure_to_delete'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    deleteItem(index);
                  },
                  child: const Text(
                    "yes",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "no",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
