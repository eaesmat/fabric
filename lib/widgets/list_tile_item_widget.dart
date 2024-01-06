import 'package:flutter/material.dart';

class ExpansionTileItemWidget extends StatelessWidget {
  final Widget? lead;
  final Widget tileTitle;
  final Widget? tileSubTitle;
  final Widget? trail;
  final VoidCallback? callBack;

  const ExpansionTileItemWidget({
    Key? key,
     this.lead,
    required this.tileTitle,
    this.tileSubTitle,
    this.trail,
    this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBack,
      child: Column(
        children: [
          ListTile(
            leading: lead,
            title: tileTitle,
            subtitle: tileSubTitle,
            trailing: trail,
          ),
          const Divider(
            thickness: 0.1,
          )
        ],
      ),
    );
  }
}
