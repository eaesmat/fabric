import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';

class DrawerLanguageExpansionTile extends StatelessWidget {
  final List<Widget> children;
  final Widget lead;
  final Widget expansionTitle;

  const DrawerLanguageExpansionTile({
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
        Divider(
          thickness: .1,
        ),
        ...children, // Spread the list of children
      ],
    );
  }
}
