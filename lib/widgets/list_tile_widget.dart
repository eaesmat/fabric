import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final Widget? lead;
  final Widget tileTitle;
  final Widget? tileSubTitle;
  final Widget? trail;
  final Function? callBack;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final String? isComplete;

  const ListTileWidget(
      {Key? key,
      this.lead,
      required this.tileTitle,
      this.tileSubTitle,
      this.trail,
      this.callBack,
      this.onLongPress,
      this.onTap,
      this.isComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    if (isComplete == 'incomplete') {
      backgroundColor = Colors.red.shade300;
    }

    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          ListTile(
            leading: lead,
            title: tileTitle,
            subtitle: tileSubTitle,
            trailing: trail,
            onTap: onTap,
            onLongPress: onLongPress,
            
          ),
        ],
      ),
    );
  }
}
