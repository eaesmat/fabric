import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';

class SelectedBundleCardWidget extends StatelessWidget {
  final String name;
  final String bundleName;
  final String war;

  const SelectedBundleCardWidget({
    Key? key,
    required this.name,
    required this.bundleName,
    required this.war,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        color: Pallete.whiteColor,
        elevation: 1,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Pallete.blackColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                bundleName,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Pallete.greyColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                war,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Pallete.greyColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
