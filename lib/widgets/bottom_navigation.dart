// bottom_navigation.dart

import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentPage;
  final Function(int) onPageChanged;

  CustomBottomNavigationBar({required this.currentPage, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Pallete.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Pallete.whiteColor,
            elevation: 0,
            unselectedFontSize: 0,
            selectedFontSize: 0,
            iconSize: 25,
            currentIndex: currentPage,
            onTap: onPageChanged,
            items: [
              _buildAnimatedPaddedNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: "",
                index: 0,
              ),
              _buildAnimatedPaddedNavigationBarItem(
                icon: Icon(Icons.shop),
                label: "",
                index: 1,
              ),
              _buildAnimatedPaddedNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "",
                index: 2,
              ),
              _buildAnimatedPaddedNavigationBarItem(
                icon: Icon(Icons.menu),
                label: "",
                index: 3,
              ),
            ],
            selectedItemColor: Pallete.blueColor,
            unselectedItemColor: Pallete.blackColor,
            // Set the color for the selected item
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                4,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: size.width * .160,
                  height: index == currentPage ? size.width * .014 : 0,
                  decoration: const BoxDecoration(
                    color: Pallete.blueColor,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildAnimatedPaddedNavigationBarItem({
    required Icon icon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: AnimatedPadding(
        padding: EdgeInsets.only(bottom: index == currentPage ? 8 : 0),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
        child: icon,
      ),
      label: label,
    );
  }
}
