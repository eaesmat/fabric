import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter_locales/flutter_locales.dart';

class RemainingWarAndBundleBottomNavigationBar extends StatelessWidget {
  final String remainingWar;
  final String remainingBundle;

  const RemainingWarAndBundleBottomNavigationBar({
    Key? key,
    required this.remainingWar,
    required this.remainingBundle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallete.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 0,
            offset: const Offset(0, -0.3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const Icon(Icons.timelapse, color: Pallete.blueColor),
              const SizedBox(width: 5),
              const LocaleText('bundle',
                  style: TextStyle(color: Pallete.blueColor)),
              const SizedBox(width: 5),
              Text(
                remainingBundle,
                style: const TextStyle(color: Pallete.blueColor),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.timelapse, color: Pallete.blueColor),
              const SizedBox(width: 5),
              const LocaleText('war',
                  style: TextStyle(color: Pallete.blueColor)),
              const SizedBox(width: 5),
              Text(
                remainingWar,
                style: const TextStyle(color: Pallete.blueColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
