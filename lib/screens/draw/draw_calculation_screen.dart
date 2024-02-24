// Import necessary dependencies and files
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import 'package:fabricproject/controller/draw_controller.dart';
import 'package:fabricproject/controller/fabric_purchase_controller.dart';

// Define a StatefulWidget for DrawCalculation
class DrawCalculation extends StatefulWidget {
  const DrawCalculation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DrawCalculationState();
}

// Define the state for _DrawCalculationState
class _DrawCalculationState extends State<DrawCalculation> {
  @override
  Widget build(BuildContext context) {
    // Use Consumer2 to listen to changes in both DrawController and FabricPurchaseController
    return Consumer2<DrawController, FabricPurchaseController>(
      builder: (context, drawController, fabricPurchaseController, child) {
        // Get the total values from both controllers
        double drawTotalDollar = drawController.sumOfDrawTotalDollar;
        double drawTotalYen = drawController.sumOfDrawTotalYen;
        double fabricPurchaseTotalDollar =
            fabricPurchaseController.sumOfFabricPurchaseTotalDollar;
        double fabricPurchaseTotalYen =
            fabricPurchaseController.sumOfFabricPurchaseTotalYen;

        // Calculate the remaining total values
        double totalDollar = fabricPurchaseTotalDollar - drawTotalDollar;
        double totalYen = fabricPurchaseTotalYen - drawTotalYen;

        // Determine the color based on the remaining values
        Color yenColor = totalYen < 0 ? Colors.red : Colors.black;
        Color dollarColor = totalDollar < 0 ? Colors.red : Colors.black;

        // Display the remaining values in a DataTable
        return Column(
          children: [
            DataTable(
              columns: const [
                DataColumn(
                  label: LocaleText(
                    'yen',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: LocaleText(
                    'dollar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: [
                buildDataRow(
                  totalYen.toStringAsFixed(2),
                  totalDollar.toStringAsFixed(2),
                  yenColor,
                  dollarColor,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Function to build a DataRow with specified attributes
  DataRow buildDataRow(
    String attribute,
    String value,
    Color attributeColor,
    Color valueColor,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            attribute,
            style: TextStyle(color: attributeColor),
          ),
        ),
        DataCell(
          Text(
            value,
            style: TextStyle(color: valueColor),
          ),
        ),
      ],
    );
  }
}
