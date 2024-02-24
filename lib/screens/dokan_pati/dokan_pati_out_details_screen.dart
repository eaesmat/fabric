import 'package:fabricproject/model/dokan_pati_out_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class DokanPatiOutDetailsBottomSheet extends StatelessWidget {
  final Data data;

  const DokanPatiOutDetailsBottomSheet({
    Key? key,
    required this.data,
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
                      LocaleText('fabric_code'),
                      Text(data.fabricPurchaseCode.toString()),
                    ),
                    buildDataRow(
                      LocaleText('out_date'),
                      Text(data.outDate.toString()),
                    ),
                    buildDataRow(
                      LocaleText('bundle_name'),
                      Text(data.bundleName.toString()),
                    ),
                    buildDataRow(
                      LocaleText('pati_name'),
                      Text(data.patiName.toString()),
                    ),
                    buildDataRow(
                      LocaleText('pati_war'),
                      Text(data.patiWar.toString()),
                    ),
                    buildDataRow(
                      LocaleText('out_place'),
                      Text(
                        data.placeTo.toString(),
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

  DataRow buildDataRow(Widget attribute, Widget value) {
    return DataRow(
      cells: [
        DataCell(attribute),
        DataCell(value),
      ],
    );
  }
}
