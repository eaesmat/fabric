import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';

class DrawerExpansionTile extends StatelessWidget {
  final Widget lead;
  final Widget expansionTitle;
  final List<Widget> children;

  const DrawerExpansionTile({
    Key? key,
    required this.children,
    required this.lead,
    required this.expansionTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const Border(),
      childrenPadding: const EdgeInsets.only(left: 10, right: 10),
      iconColor: Pallete.blueColor,
      leading: lead,
      title: expansionTitle,
      children: [
        ...children,
      ],
    );
  }
}
