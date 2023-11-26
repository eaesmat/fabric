import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';

class ExpansionTileWidget extends StatelessWidget {
  final Widget lead;
  final Widget expansionTitle;
  final List<Widget> children;

  const ExpansionTileWidget({
    Key? key,
    required this.children,
    required this.lead,
    required this.expansionTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          shape: const Border(),
          childrenPadding: const EdgeInsets.only(left: 10, right: 10),
          iconColor: Pallete.blueColor,
          leading: lead,
          title: expansionTitle,
          children: [
            ...children,
          ],
        ),
        const Divider(
          thickness: .3,
        ),
      ],
    );
  }
}
