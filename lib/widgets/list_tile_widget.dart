import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final Widget lead;
  final Widget tileTitle;
  final Widget? tileSubTitle;
  final Widget? trail;

  const ListTileWidget({
    Key? key,
    required this.lead,
    required this.tileTitle,
    this.tileSubTitle,
    this.trail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: lead,
      title: tileTitle,
      subtitle: tileSubTitle,
      trailing: trail,
    );
  }
}
