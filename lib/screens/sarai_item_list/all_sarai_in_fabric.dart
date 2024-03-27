import 'package:fabricproject/controller/sarai_in_fabric_controller.dart';
import 'package:fabricproject/screens/sarai_item_list/sarai_fabric_in_details_screen.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class AllSaraiInFabric extends StatefulWidget {
  // gets this data from controller

  const AllSaraiInFabric({
    super.key,
  });

  @override
  State<AllSaraiInFabric> createState() => _AllSaraiInFabricState();
}

class _AllSaraiInFabricState extends State<AllSaraiInFabric> {
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
          Consumer<SaraiInFabricController>(
            builder: (context, saraiInFabricController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
                  // create new item here

                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // passes search text to the controller
                    saraiInFabricController.searchSaraiFabricsMethod(value);
                  },
                ),
              );
            },
          ),
          // data list view
          Expanded(
            child: Consumer<SaraiInFabricController>(
              builder: (context, saraiInFabricController, child) {
                final searchSaraiInFabric =
                    saraiInFabricController.searchSaraiInFabrics ?? [];

                if (searchSaraiInFabric.isNotEmpty) {
                  return ListView.builder(
                    itemCount: searchSaraiInFabric.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // data holds result of controller
                      final reversedList =
                          searchSaraiInFabric.reversed.toList();
                      final data = reversedList[index];
                      return ListTileWidget(
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return SaraiFabricInDetailsBottomSheet(
                                // pass the these data to the widget
                                data: data,
                              );
                            },
                          );
                        },
                        // circular avatar

                        // Tile Title
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
