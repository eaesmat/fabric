import 'package:fabricproject/model/sarai_out_fabric_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class SaraiFabricOutDetailsBottomSheet extends StatelessWidget {
  final Data data;

  const SaraiFabricOutDetailsBottomSheet({
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
                      Text(data.fabricpurchasecode.toString()),
                    ),
                    buildDataRow(
                      LocaleText('indate'),
                      Text(data.indate.toString()),
                    ),
                    buildDataRow(
                      LocaleText('bundle_name'),
                      Text(data.bundlename.toString()),
                    ),
                    buildDataRow(
                      LocaleText('bundle'),
                      Text(data.bundletoop.toString()),
                    ),
                    buildDataRow(
                      LocaleText('out_date'),
                      Text(data.outdate.toString()),
                    ),
                    buildDataRow(
                      LocaleText('out_place'),
                      Text(
                        (data.saraitoname != null)
                            ? data.saraitoname.toString()
                            : (data.customername != null)
                                ? data.customername.toString()
                                : (data.branchname != null)
                                    ? data.branchname.toString()
                                    : 'N/A', // Or any default value you prefer
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
