import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../model/customer_payment_model.dart';

class CustomerPaymentDetailsBottomSheet extends StatelessWidget {
  // gets this dat from the fabric purchase list screen directly
  final Data data;

  const CustomerPaymentDetailsBottomSheet({super.key, required this.data});

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
                    buildDataRow('date', data.date.toString()),
                    buildDataRow('person', data.person.toString()),
                    buildDataRow('dollar', data.amountdoller.toString()),
                    buildDataRow('afghani', data.amountafghani.toString()),
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
