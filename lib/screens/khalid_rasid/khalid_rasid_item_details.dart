import 'package:fabricproject/model/khalid_rasid_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class KhalidRasidItemDetailsBottomSheet extends StatelessWidget {
  // gets this dat from the fabric purchase list screen directly
  final Data data;
  final String vendorCompanyName;

  const KhalidRasidItemDetailsBottomSheet(
      {Key? key, required this.data, required this.vendorCompanyName})
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
                    text: vendorCompanyName,
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
                    buildDataRow('date', data.drawDate.toString()),
                    buildDataRow('yen', data.yen.toString()),
                    buildDataRow('dollar', data.doller.toString()),
                    buildDataRow('exchange_rate', data.exchangerate.toString()),
                    buildDataRow('photo', data.photo.toString()),
                    buildDataRow(
                        'vendor_company', data.vendorcompanyName.toString()),
                    buildDataRow('forex', data.sarafiName.toString()),
                  ],
                ),
                const SizedBox(height: 20),
                // Row(
                //   children: [
                //     if (data.bankreceiptphoto != null &&
                //         data.bankreceiptphoto!.isNotEmpty)
                //       buildImageIcon(
                //         imageUrl: "$fabricPurchaseURL${data.bankreceiptphoto}",
                //         context: context,
                //       ),
                //     if (data.packagephoto != null &&
                //         data.packagephoto!.isNotEmpty)
                //       buildImageIcon(
                //         imageUrl: "$fabricPurchaseURL${data.packagephoto}",
                //         context: context,
                //       ),
                //   ],
                // )
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
