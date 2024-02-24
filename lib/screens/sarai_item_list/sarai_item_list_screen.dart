import 'package:fabricproject/controller/sarai_in_fabric_controller.dart';
import 'package:fabricproject/controller/sarai_item_controller.dart';
import 'package:fabricproject/controller/sarai_out_fabric_controller.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/sarai_in_fabric_widget.dart';
import 'package:fabricproject/widgets/sarai_fabric_card_widget.dart';
import 'package:fabricproject/widgets/sarai_out_fabric_widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class SaraiItemListScreen extends StatefulWidget {
  final int saraiId;
  const SaraiItemListScreen({Key? key, required this.saraiId})
      : super(key: key);

  @override
  State<SaraiItemListScreen> createState() => _SaraiItemListScreenState();
}

class _SaraiItemListScreenState extends State<SaraiItemListScreen> {
  int? outFabricId;
  int? outSaraiId;
  int? inFabricId;
  int? inSaraiId;
  final HelperServices helper = HelperServices.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<SaraiInFabricController>(context, listen: false)
          .resetSearchFilter();
      Provider.of<SaraiItemController>(context, listen: false)
          .resetSearchFilter();
      Provider.of<SaraiOutFabricController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    final saraiInFabricController =
        Provider.of<SaraiInFabricController>(context);
    final saraiOutFabricController =
        Provider.of<SaraiOutFabricController>(context);

    final screenWidth = MediaQuery.of(context).size.width;

    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<SaraiItemController>(context, listen: false)
            .getAllSaraiItems(widget.saraiId);
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<SaraiItemController>(
              builder: (context, saraiItemController, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomTextFieldWithController(
                    lblText: const LocaleText('search'),
                    onChanged: (value) {
                      saraiItemController.searchSaraiItemMethod(value);
                    },
                  ),
                );
              },
            ),

            // data list view
            Consumer<SaraiItemController>(
              builder: (context, saraiItemController, child) {
                final searchSaraiItems =
                    saraiItemController.searchSaraiItems ?? [];

                return searchSaraiItems.isNotEmpty
                    ? SizedBox(
                        height: screenWidth *
                            0.8, // Adjust the height based on screen width
                        child: ListView.builder(
                          itemCount: searchSaraiItems.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final reversedList =
                                searchSaraiItems.reversed.toList();
                            final data = reversedList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SaraiFabricsCardWidget(
                                name: data.name.toString(),
                                totalBundle: data.total.toString(),
                                inItems: data.inbundle.toString(),
                                outItems: data.outbundle.toString(),
                                inDate: data.indate.toString(),
                                onGreenButtonPressed: () {
                                  if (data.fabricId != null &&
                                      data.inbundle != 0) {
                                    inFabricId = data.fabricId!.toInt();
                                    inSaraiId = data.saraiId!.toInt();
                                    saraiInFabricController.getAllSaraiFabrics(
                                      data.fabricId!.toInt(),
                                      data.saraiId,
                                    );
                                  }
                                },
                                onRedButtonPressed: () {
                                  if (data.fabricId != null &&
                                      data.outbundle != 0) {
                                    outFabricId = data.fabricId!.toInt();
                                    outSaraiId = data.saraiId!.toInt();
                                    saraiOutFabricController
                                        .getAllSaraiOutFabrics(
                                      data.fabricId!.toInt(),
                                      data.saraiId,
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Image.asset(
                          'assets/images/noData.png',
                          width: screenWidth *
                              0.4, // Set the width based on screen width
                          height: screenWidth *
                              0.4, // Set the height based on screen width
                        ),
                      );
              },
            ),

            // search part 1
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth *
                        0.0001, // Adjust the padding based on screen width
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        if (inFabricId != null &&
                            inFabricId != 0 &&
                            inSaraiId != null &&
                            inSaraiId != 0) {
                          saraiInFabricController.navigateToAllSaraiInFabric();
                        } else {
                          helper.showMessage(
                            const LocaleText('select_fabric_first'),
                            Colors.deepOrange,
                            const Icon(
                              Icons.warning,
                              color: Pallete.whiteColor,
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.all_out_outlined, size: 30),
                      color: Colors.green,
                    ),
                  ),
                ),
                const LocaleText(
                  'view_all',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),

            // search part 2
            Consumer<SaraiInFabricController>(
              builder: (context, saraiInFabricController, child) {
                return Container(
                  height: screenWidth *
                      0.4, // Adjust the height based on screen width
                  child: saraiInFabricController
                              .searchSaraiInFabrics?.isNotEmpty ==
                          true
                      ? ListView.builder(
                          itemCount: saraiInFabricController
                              .searchSaraiInFabrics!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final reversedList = saraiInFabricController
                                .searchSaraiInFabrics!.reversed
                                .toList();
                            final data = reversedList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SaraiInFabricWidget(
                                title: data.fabricpurchasecode.toString(),
                                backgroundColor: Pallete.whiteColor,
                                bundle: data.bundletoop.toString(),
                                indate: data.indate.toString(),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Image.asset(
                            'assets/images/noData.png',
                            width: screenWidth *
                                0.4, // Set the width based on screen width
                            height: screenWidth *
                                0.4, // Set the height based on screen width
                          ),
                        ),
                );
              },
            ),

            const SizedBox(
              height: 20,
            ),

            // search part 3
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth *
                        0.0001, // Adjust the padding based on screen width
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        if (outFabricId != null &&
                            outFabricId != 0 &&
                            outSaraiId != null &&
                            outSaraiId != 0) {
                          saraiOutFabricController
                              .navigateToAllSaraiOutFabric();
                        } else {
                          helper.showMessage(
                            const LocaleText('select_fabric_first'),
                            Colors.deepOrange,
                            const Icon(
                              Icons.warning,
                              color: Pallete.whiteColor,
                            ),
                          );
                        }
                      },
                      icon: Icon(Icons.all_out_outlined, size: 30),
                      color: Pallete.redColor,
                    ),
                  ),
                ),
                LocaleText(
                  'view_all',
                  style: TextStyle(color: Pallete.redColor),
                ),
              ],
            ),

            // search part 4
            Consumer<SaraiOutFabricController>(
              builder: (context, saraiOutFabricController, child) {
                return Container(
                  height: screenWidth *
                      0.6, // Adjust the height based on screen width
                  child: saraiOutFabricController
                              .searchSaraiOutFabrics?.isNotEmpty ==
                          true
                      ? ListView.builder(
                          itemCount: saraiOutFabricController
                              .searchSaraiOutFabrics!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final reversedList = saraiOutFabricController
                                .searchSaraiOutFabrics!.reversed
                                .toList();
                            final data = reversedList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SaraiOutFabricWidget(
                                title: data.fabricpurchasecode.toString(),
                                backgroundColor: Pallete.whiteColor,
                                bundle: data.bundletoop.toString(),
                                indate: data.indate.toString(),
                                outDate: data.outdate.toString(),
                                outPlace: (data.saraitoname != null)
                                    ? data.saraitoname.toString()
                                    : (data.customername != null)
                                        ? data.customername.toString()
                                        : data.branchname.toString(),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Image.asset(
                            'assets/images/noData.png',
                            width: screenWidth *
                                0.4, // Set the width based on screen width
                            height: screenWidth *
                                0.4, // Set the height based on screen width
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
