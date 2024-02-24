import 'package:fabricproject/controller/dokan_pati_in_controller.dart';
import 'package:fabricproject/screens/dokan_pati/dokan_pati_in_details_screen.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class AllDokanPatiIn extends StatefulWidget {
  // gets this data from controller

  const AllDokanPatiIn({
    super.key,
  });

  @override
  State<AllDokanPatiIn> createState() => _AllDokanPatiInState();
}

class _AllDokanPatiInState extends State<AllDokanPatiIn> {
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
          Consumer<DokanInPatiController>(
            builder: (context, dokanInPatiController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
                  // create new item here

                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // passes search text to the controller
                    dokanInPatiController.searchDokanInPatiMethod(value);
                  },
                ),
              );
            },
          ),
          // data list view
          Expanded(
            child: Consumer<DokanInPatiController>(
              builder: (context, dokanInPatiController, child) {
                final searchSaraiInFabric =
                    dokanInPatiController.searchDokanInPati ?? [];

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
                              return DokanPatiInDetailsBottomSheet(
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
                              data.fabricPurchaseCode.toString(),
                            ),
                            const Spacer(),
                            Text(
                              data.inDate.toString(),
                            ),
                          ],
                        ),
                        // subtitle
                        tileSubTitle: Row(
                          children: [
                            Text(
                              data.bundleName.toString(),
                            ),
                            const Spacer(),
                            Text(
                              data.patiName.toString(),
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
