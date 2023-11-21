import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final Function(int) onTabTapped;
  const BottomNavigation({super.key, required this.onTabTapped});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // margin: EdgeInsets.only(left: size.width * 0.02, right: size.width * 0.02),
      height: size.width * .155,
      decoration: BoxDecoration(
        color: Pallete.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: size.width * .024),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            widget.onTabTapped(index);
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 1500),
                curve: Curves.fastLinearToSlowEaseIn,
                margin: EdgeInsets.only(
                  bottom: index == currentIndex ? 0 : size.width * .029,
                  right: size.width * .04,
                  left: size.width * .04,
                ),
                width: size.width * .160,
                height: index == currentIndex ? size.width * .014 : 0,
                decoration: const BoxDecoration(
                  color: Pallete.blueColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
              ),
              Icon(
                listOfIcons[index],
                size: size.width * .076,
                color: index == currentIndex
                    ? Pallete.blueColor
                    : Pallete.blackColor,
              ),
              SizedBox(height: size.width * .03),
            ],
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.shop_2_rounded,
    Icons.settings,
    Icons.menu_rounded,
  ];
}
