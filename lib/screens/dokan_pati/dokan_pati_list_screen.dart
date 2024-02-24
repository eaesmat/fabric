import 'package:fabricproject/controller/dokan_pati_controller.dart';
import 'package:fabricproject/controller/dokan_pati_in_controller.dart';
import 'package:fabricproject/controller/dokan_pati_out_controller.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/sarai_fabric_card_widget.dart';
import 'package:fabricproject/widgets/sarai_in_fabric_widget.dart';
import 'package:fabricproject/widgets/sarai_out_fabric_widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class DokanPatiListScreen extends StatefulWidget {
  final int dokanId;
  const DokanPatiListScreen({Key? key, required this.dokanId})
      : super(key: key);

  @override
  State<DokanPatiListScreen> createState() => _DokanPatiListScreenState();
}

class _DokanPatiListScreenState extends State<DokanPatiListScreen> {
  int? outFabricId;
  String? outDokanId;
  int? inFabricId;
  int? inDokanId;
  final HelperServices helper = HelperServices.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<DokanInPatiController>(context, listen: false);
      //     .resetSearchFilter();
      Provider.of<DokanPatiController>(context, listen: false)
          .resetSearchFilter();
      Provider.of<DokanOutPatiController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dokanInPatiController = Provider.of<DokanInPatiController>(context);
    final dokanOutPatiController = Provider.of<DokanOutPatiController>(context);

    final screenWidth = MediaQuery.of(context).size.width;

    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<DokanPatiController>(context, listen: false)
            .getDokanPati(widget.dokanId);
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<DokanPatiController>(
              builder: (context, dokanPatiController, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomTextFieldWithController(
                    lblText: const LocaleText('search'),
                    onChanged: (value) {
                      dokanPatiController.searchDokanPatiMethod(value);
                    },
                  ),
                );
              },
            ),

            // data list view
            Consumer<DokanPatiController>(
              builder: (context, dokanPatiController, child) {
                final searchDokanPati =
                    dokanPatiController.searchAllDokanPati ?? [];

                return searchDokanPati.isNotEmpty
                    ? Container(
                        height: screenWidth *
                            0.9, // Adjust the height based on screen width
                        child: ListView.builder(
                          itemCount: searchDokanPati.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final reversedList =
                                searchDokanPati.reversed.toList();
                            final data = reversedList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SaraiFabricsCardWidget(
                                name: data.name.toString(),
                                totalBundle: data.totalbundle.toString(),
                                inItems: data.inpati.toString(),
                                outItems: data.outpati.toString(),
                                inDate: data.indate.toString(),
                                totalPati: data.totalpati.toString(),
                                onGreenButtonPressed: () {
                                  if (data.fabricId != null &&
                                      data.inpati != 0) {
                                    inFabricId = data.fabricId!.toInt();
                                    inDokanId = int.parse(
                                      data.saraiId.toString(),
                                    );
                                    dokanInPatiController.getAllDokanPatiIn(
                                      data.fabricId!.toInt(),
                                      data.saraiId,
                                    );
                                  }
                                },
                                onRedButtonPressed: () {
                                  if (data.fabricId != null &&
                                      data.inpati != 0) {
                                    outFabricId = data.fabricId!.toInt();
                                    outDokanId = data.saraiId.toString();
                                    dokanOutPatiController.getAllDokanPatiOut(
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
                            inDokanId != null &&
                            inDokanId != 0) {
                          dokanInPatiController.navigateToAllDokanPatiIn();
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

            // // search part 2
            Consumer<DokanInPatiController>(
              builder: (context, dokanInPatiController, child) {
                return SizedBox(
                  height: screenWidth *
                      0.5, // Adjust the height based on screen width
                  child: dokanInPatiController.searchDokanInPati?.isNotEmpty ==
                          true
                      ? ListView.builder(
                          itemCount:
                              dokanInPatiController.searchDokanInPati!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final reversedList = dokanInPatiController
                                .searchDokanInPati!.reversed
                                .toList();
                            final data = reversedList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SaraiInFabricWidget(
                                title: data.fabricPurchaseCode.toString(),
                                backgroundColor: Pallete.whiteColor,
                                patiName: data.patiName.toString(),
                                bundle: data.bundleName.toString(),
                                indate: data.inDate.toString(),
                                patiWar: data.patiWar.toString(),
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

            // // search part 3
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
                            outDokanId != null &&
                            outDokanId != 0) {
                          dokanOutPatiController.navigateToAllDokanPatiOut();
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
            Consumer<DokanOutPatiController>(
              builder: (context, dokanOutPatiController, child) {
                return Container(
                  height: screenWidth *
                      0.7, // Adjust the height based on screen width
                  child: dokanOutPatiController
                              .searchDokanOutPati?.isNotEmpty ==
                          true
                      ? ListView.builder(
                          itemCount:
                              dokanOutPatiController.searchDokanOutPati!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final reversedList = dokanOutPatiController
                                .searchDokanOutPati!.reversed
                                .toList();
                            final data = reversedList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SaraiOutFabricWidget(
                                title: data.fabricPurchaseCode.toString(),
                                backgroundColor: Pallete.whiteColor,
                                bundle: data.bundleName.toString(),
                                indate: data.outDate.toString(),
                                outDate: data.outDate.toString(),
                                outPlace: data.placeTo.toString(),
                                patiName: data.patiName.toString(),
                                patiWar: data.patiWar.toString(),
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
