import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/fabric_design_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class FabricDesignDetailsBottomSheet extends StatelessWidget {
  final Data data;
  final String fabricDesignName;
  final List<Fabricdesigncolor> designColors;

  const FabricDesignDetailsBottomSheet({
    Key? key,
    required this.data,
    required this.fabricDesignName,
    required this.designColors,
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
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextTitle(
                    text: fabricDesignName,
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
                      LocaleText('code'),
                      Text(data.fabricpurchase!.fabricpurchasecode.toString()),
                    ),
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
                    // Add the rows from the designColors list
                    ...designColors.map((data) {
                      return buildDataRow(
                        CircleAvatar(
                          radius: 12,
                          backgroundColor:
                              getColorFromName(data.colorname.toString()),
                        ),
                        Text(data.colorname.toString()),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataRow buildDataRow(Widget attribute, Widget value) {
    return DataRow(
      cells: [
        DataCell(attribute),
        DataCell(value),
      ],
    );
  }
}
