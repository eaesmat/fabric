import 'package:fabricproject/controller/sarai_out_fabric_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/screens/sarai_item_list/sarai_fabric_out_details_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class AllSaraiOutFabric extends StatefulWidget {
  // gets this data from controller

  const AllSaraiOutFabric({
    super.key,
  });

  @override
  State<AllSaraiOutFabric> createState() => _AllSaraiOutFabricState();
}

class _AllSaraiOutFabricState extends State<AllSaraiOutFabric> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextTitle(text: 'asdf'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // search part
          Consumer<SaraiOutFabricController>(
            builder: (context, saraiOutFabricController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
                  // create new item here

                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // passes search text to the controller
                    saraiOutFabricController.searchSaraiFabricsMethod(value);
                  },
                ),
              );
            },
          ),
          // data list view
          Expanded(
            child: Consumer<SaraiOutFabricController>(
              builder: (context, saraiOutFabricController, child) {
                final searchCompanies =
                    saraiOutFabricController.searchSaraiOutFabrics ?? [];

                if (searchCompanies.isNotEmpty) {
                  return ListView.builder(
                    itemCount: searchCompanies.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // data holds result of controller
                      final reversedList = searchCompanies.reversed.toList();
                      final data = reversedList[index];
                      return ListTileWidget(
                         onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return SaraiFabricOutDetailsBottomSheet(
                                // pass the these data to the widget
                                data: data,
                              );
                            },
                          );
                        },
                        // circular avatar

                        tileTitle: Row(
                          children: [
                            Text(
                              data.fabricpurchasecode.toString(),
                            ),
                            const Spacer(),
                            Text(
                              data.indate.toString(),
                            ),
                          ],
                        ),
                        // subtitle
                        tileSubTitle: Row(
                          children: [
                            Text(
                              data.bundlename.toString(),
                            ),
                            const Spacer(),
                            Text(
                              data.bundletoop.toString(),
                            ),
                          ],
                        ),
                        // trailing hold delete and update buttons
                      );
                    },
                  );
                } else {
                  // If no data, display the "noData.png" image
                  return Center(
                    child: Image.asset(
                      'assets/images/noData.png',
                      width: 200, // Set the width as needed
                      height: 200, // Set the height as needed
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
