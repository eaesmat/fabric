import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;


  const CustomRefreshIndicator({
    Key? key,
    required this.child,
    required this.onRefresh,
    // Default indicator color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Pallete.blueColor,
      color: Pallete.whiteColor,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
