import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter_locales/flutter_locales.dart';

class CalculationBottomNavigationBar extends StatelessWidget {
  final List<RowData> rowsData;

  const CalculationBottomNavigationBar({
    Key? key,
    required this.rowsData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallete.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 0,
            offset: const Offset(0, -0.3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: rowsData.map(
          (rowData) {
            return Row(
              children: [
                Icon(rowData.icon, color: rowData.iconColor),
                const SizedBox(width: 5),
                LocaleText(
                  rowData.textKey,
                  style: TextStyle(color: rowData.textColor),
                ),
                const SizedBox(width: 5),
                Text(
                  rowData.remainingValue,
                  style: TextStyle(color: rowData.textColor),
                ),
                const SizedBox(width: 20),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}

class RowData {
  final IconData icon;
  final String textKey;
  final String remainingValue;
  final Color iconColor;
  final Color textColor;

  RowData({
    required this.icon,
    required this.textKey,
    required this.remainingValue,
    this.iconColor = Pallete.blueColor,
    this.textColor = Pallete.blueColor,
  });
}
