import 'package:fabricproject/model/fabric_purchase_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class FabricDetailsBottomSheet extends StatelessWidget {
  final Data data;
  final String fabricName;

  FabricDetailsBottomSheet({required this.data, required this.fabricName});

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
                    text: fabricName,
                  ),
                ),
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
                    buildDataRow('code', data.fabricpurchasecode.toString()),
                    buildDataRow('item', data.fabric!.name.toString()),
                    buildDataRow('marka', data.company!.marka.toString()),
                    // buildDataRow('Company', widget.vendorCompanyName),
                    buildDataRow('bundle', data.bundle.toString()),
                    // Add more rows as needed
                    buildDataRow('meter', data.meter.toString()),
                    buildDataRow('war', data.war.toString()),
                    buildDataRow('yen_price', data.yenprice.toString()),
                    buildDataRow(
                        'total_yen_price', data.totalyenprice.toString()),
                    buildDataRow('dollar_price', data.dollerprice.toString()),
                    buildDataRow(
                        'total_dollar_price', data.totaldollerprice.toString()),
                    buildDataRow('tt_commission', data.ttcommission.toString()),
                    buildDataRow('tamam_shoda', data.dollerprice.toString()),
                    buildDataRow('exchange_rate', data.yenexchange.toString()),
                    buildDataRow('date', data.date.toString()),
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
