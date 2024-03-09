import 'package:fabricproject/controller/transport_deals_controller.dart';
import 'package:fabricproject/model/transport_deal_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class TransportItemDetailsBottomSheet extends StatelessWidget {
  final Data data;
  final String transportName;
  final List<ContainerModel> containerList;

  const TransportItemDetailsBottomSheet({
    Key? key,
    required this.data,
    required this.containerList,
    required this.transportName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final transportDealsController =
        Provider.of<TransportDealsController>(context);

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
                      LocaleText('start_date'),
                      Text(data.startdate.toString()),
                    ),
                    buildDataRow(
                      LocaleText('arrivale_date'),
                      Text(data.arrivaldate.toString()),
                    ),
                    buildDataRow(
                      LocaleText('code'),
                      Text(data.fabricpurchase!.fabricpurchasecode.toString()),
                    ),
                    buildDataRow(
                      LocaleText('khat_amount'),
                      Text(data.khatamount.toString()),
                    ),
                    buildDataRow(
                      LocaleText('cost_per_khat'),
                      Text(data.costperkhat.toString()),
                    ),
                    buildDataRow(
                      LocaleText('total_cost'),
                      Text(data.totalcost.toString()),
                    ),
                    buildDataRow(
                      LocaleText('transport'),
                      Text(data.transport!.name.toString()),
                    ),
                    buildDataRow(
                      LocaleText('status'),
                      Text(data.status.toString()),
                    ),
                    buildDataRow(
                      LocaleText('duration'),
                      Text(data.duration.toString()),
                    ),
                    buildDataRow(
                      LocaleText('bundle'),
                      Text(data.bundle.toString()),
                    ),
                    buildDataRow(
                      LocaleText('war_cost'),
                      Text(data.warcost.toString()),
                    ),
                    // Add the rows from the designColors list
                    ...containerList.map((data) {
                      transportDealsController.containerNameController.text =
                          data.name!;
                      return buildDataRow(
                        LocaleText('container'),
                        Text(
                          data.name.toString(),
                        ),
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
