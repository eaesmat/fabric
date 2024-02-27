import 'package:fabricproject/model/transport_deals_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class TransportItemDetailsBottomSheet extends StatelessWidget {
  final Data data;
  final String transportName;

  const TransportItemDetailsBottomSheet({
    Key? key,
    required this.data,
    required this.transportName,
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
                    text: transportName,
                  ),
                ),
                DataTable(
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Attribute',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Value',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: [
                    buildDataRow(
                      LocaleText('start_date'),
                      Text(data.startdate ?? ''),
                    ),
                    buildDataRow(
                      LocaleText('arrival_date'),
                      Text(data.arrivaldate ?? ''),
                    ),
                   
                    buildDataRow(
                      LocaleText('khat_amount'),
                      Text(data.khatamount?.toString() ?? ''),
                    ),
                    buildDataRow(
                      LocaleText('cost_per_khat'),
                      Text(data.costperkhat?.toString() ?? ''),
                    ),
                    buildDataRow(
                      LocaleText('status'),
                      Text(data.status ?? ''),
                    ),
                    buildDataRow(
                      LocaleText('duration'),
                      Text(data.duration?.toString() ?? ''),
                    ),
                    buildDataRow(
                      LocaleText('bundle'),
                      Text(data.bundle?.toString() ?? ''),
                    ),
                    buildDataRow(
                      LocaleText('photo'),
                      Text(data.photo ?? ''),
                    ),
                    buildDataRow(
                      LocaleText('total_cost'),
                      Text(data.totalcost?.toString() ?? ''),
                    ),
                    buildDataRow(
                      LocaleText('war_cost'),
                      Text(data.warcost?.toString() ?? ''),
                    ),
                    buildDataRow(
                      LocaleText('fabric_purchase_code'),
                      Text(data.fabricpurchasecode ?? ''),
                    ),
                    buildDataRow(
                      LocaleText('war'),
                      Text(data.war?.toString() ?? ''),
                    ),
                    buildDataRow(
                      LocaleText('container_name'),
                      Text(data.containerName ?? ''),
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
