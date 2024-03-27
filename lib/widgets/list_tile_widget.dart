import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final Widget? lead;
  final Widget tileTitle;
  final Widget? tileSubTitle;
  final Widget? trail;
  final Function? callBack;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const ListTileWidget({
    Key? key,
    this.lead,
    required this.tileTitle,
    this.tileSubTitle,
    this.trail,
    this.callBack,
    this.onLongPress,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: lead,
          title: tileTitle,
          subtitle: tileSubTitle,
          trailing: trail,
          onTap: onTap,
          onLongPress: onLongPress,
        ),
        const Divider(
          thickness: 0.2,
        ),
      ],
    );
  }
}
