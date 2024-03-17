import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../model/customer_deal_model.dart';

class CustomerDealDetailsBottomSheet extends StatelessWidget {
  // gets this dat from the fabric purchase list screen directly
  final Data data;

  const CustomerDealDetailsBottomSheet({super.key, required this.data});

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
                // data table to show the details
                DataTable(
                  columns: const [
                    DataColumn(
                      label: LocaleText(
                        'attribute',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: LocaleText(
                        'value',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: [
                    buildDataRow('bundle', data.bundlecount.toString()),
                    buildDataRow('pati', data.paticount.toString()),
                    buildDataRow('war', data.totalwar.toString()),
                    buildDataRow('cost', data.totalcost.toString()),
                    buildDataRow('begaknumber', data.begaknumber.toString()),
                    buildDataRow('date', data.date.toString()),
                    buildDataRow('begakdue', data.begakdue.toString()),
                    buildDataRow('begakphoto', data.begakphoto.toString()),
                    buildDataRow('description', data.description.toString()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataRow buildDataRow(String attribute, String value) {
    return DataRow(
      cells: [
        DataCell(LocaleText(attribute)),
        DataCell(Text(value)),
      ],
    );
  }
}
