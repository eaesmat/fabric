import 'package:fabricproject/model/forex_talabat_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class ForexTalabatDetailsBottomSheet extends StatelessWidget {
  final Data data;

  const ForexTalabatDetailsBottomSheet({
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextTitle(
                        text: data.name?.toString() ?? '',
                      ),
                    ],
                  ),
                ),
                DataTable(
                  columns: const [
                    DataColumn(
                      label: LocaleTexts(
                        localeText: 'attribute',
                      ),
                    ),
                    DataColumn(
                      label: LocaleTexts(
                        localeText: 'value',
                      ),
                    ),
                  ],
                  rows: [
                    buildDataRow(
                      const LocaleText('by_person'),
                      Text(data.name?.toString() ?? ''),
                    ),
                    buildDataRow(
                      const LocaleText('dollar'),
                      Text(data.doller?.toString() ?? ''),
                    ),
                    buildDataRow(
                      const LocaleText('yen'),
                      Text(data.yen?.toString() ?? ''),
                    ),
                    buildDataRow(
                      const LocaleText('exchange_rate'),
                      Text(
                        data.exchangerate?.toString() ?? '',
                      ),
                    ),
                    buildDataRow(
                      const LocaleText('vendor_company'),
                      Text(
                        data.vendorcompanyName?.toString() ?? '',
                      ),
                    ),
                    buildDataRow(
                      const LocaleText('date'),
                      Text(
                        data.drawDate?.toString() ?? '',
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

  // Method to build DataRow
  DataRow buildDataRow(Widget attribute, Widget value) {
    return DataRow(
      cells: [
        DataCell(attribute),
        DataCell(value),
      ],
    );
  }
}
