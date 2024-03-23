import 'package:fabricproject/constants/api_url.dart';
import 'package:fabricproject/model/all_fabric_purchases_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class FabricDetailsBottomSheet extends StatelessWidget {
  // gets this dat from the fabric purchase list screen directly
  final Data data;
  final String fabricName;

  const FabricDetailsBottomSheet(
      {Key? key, required this.data, required this.fabricName})
      : super(key: key);

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
                    buildDataRow(
                        'vendor_company', data.vendorcompany.toString()),
                    buildDataRow(
                        'fabric_code', data.fabricpurchasecode.toString()),
                    buildDataRow('item', data.fabricName.toString()),
                    buildDataRow('marka', data.marka.toString()),
                    buildDataRow('bundle', data.bundle.toString()),
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    if (data.bankreceiptphoto != null &&
                        data.bankreceiptphoto!.isNotEmpty)
                      buildImageIcon(
                        imageUrl: "$fabricPurchaseURL${data.bankreceiptphoto}",
                        context: context,
                      ),
                    if (data.packagephoto != null &&
                        data.packagephoto!.isNotEmpty)
                      buildImageIcon(
                        imageUrl: "$fabricPurchaseURL${data.packagephoto}",
                        context: context,
                      ),
                  ],
                )
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

  Widget buildImageIcon(
      {required String imageUrl, required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        _showImageFullScreen(imageUrl, context);
      },
      child: const Icon(Icons.image),
    );
  }

  void _showImageFullScreen(String imageUrl, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Image.network(imageUrl),
        );
      },
    );
  }
}
