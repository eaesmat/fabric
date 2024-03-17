import 'package:fabricproject/model/fabric_design_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class FabricDesignDetailsBottomSheet extends StatelessWidget {
  final Data data;
  final String fabricDesignName;
  final String fabricPurchaseCode;

  const FabricDesignDetailsBottomSheet({
    Key? key,
    required this.data,
    required this.fabricDesignName,
    required this.fabricPurchaseCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        color: Pallete.whiteColor,
        height: screenHeight * 0.9, // 90% of the screen height
        width: double.infinity,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextTitle(
                        text: fabricPurchaseCode,
                      ),
                      CustomTextTitle(
                        text: fabricDesignName,
                      ),
                    ],
                  ),
                ),
                DataTable(
                  columns: const [
                    DataColumn(
                      label: Text(
                        'attribute',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'value',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: [
                    buildDataRow(
                      LocaleText('bundle'),
                      Text(data.bundle.toString()),
                    ),
                    buildDataRow(
                      LocaleText('war'),
                      Text(data.war.toString()),
                    ),
                    buildDataRow(
                      LocaleText('toop'),
                      Text(data.toop.toString()),
                    ),
                    buildDataRow(
                      LocaleText('colors'),
                      Text(
                        data.colors.toString(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to build DataRow
  DataRow buildDataRow(Widget attribute, Widget value) {
    return DataRow(
      cells: [
        DataCell(attribute),
        DataCell(value),
      ],
    );
  }
}
