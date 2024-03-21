import 'package:fabricproject/controller/fabric_design_toop_controller.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/calculation_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';

class FabricDesignBundleToopListScreen extends StatefulWidget {

  final int fabricDesignBundleId;
  final String fabricPurchaseCode;
  final String fabricBundleName;
  final String fabricDesignName;
  const FabricDesignBundleToopListScreen({
    Key? key,
    required this.fabricPurchaseCode,
    required this.fabricDesignBundleId,
    required this.fabricBundleName,
    required this.fabricDesignName,
  }) : super(key: key);

  @override
  State<FabricDesignBundleToopListScreen> createState() =>
      _FabricDesignBundleToopListScreenState();
}

class _FabricDesignBundleToopListScreenState
    extends State<FabricDesignBundleToopListScreen> {
  final HelperServices helper = HelperServices.instance;

  @override
  Widget build(BuildContext context) {
    final fabricDesignBundleToopController =
        Provider.of<FabricDesignToopController>(context);

    return Scaffold(
      appBar: AppBar(
        title: CustomTextTitle(
          text:
              '| ${widget.fabricBundleName} | ${widget.fabricDesignName} | ${widget.fabricPurchaseCode} |',
        ),
        centerTitle: true,
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          // Implement your refresh logic here
          await Provider.of<FabricDesignToopController>(context, listen: false)
              .getAllFabricDesignToop(widget.fabricDesignBundleId);
        },
        child: Column(
          children: [
            Consumer<FabricDesignToopController>(
              builder: (context, fabricDesignToopController, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomTextFieldWithController(
                    iconBtn: IconButton(
                      icon: const Icon(
                        Icons.add_box,
                        color: Pallete.blueColor,
                      ),
                      onPressed: () {
                        //   final fabricDesignController =
                        //       Provider.of<FabricDesignController>(context,
                        //           listen: false);
                        //   int bundle =
                        //       fabricDesignController.remainingBundle ?? 0;
                        //   int war = fabricDesignController.remainingWar ?? 0;

                        //   if (bundle > 0 && war > 0) {
                        //     fabricDesignController.navigateToFabricDesignCreate(
                        //         widget.fabricPurchaseId);
                        //   } else {
                        //     helper.showMessage(
                        //       const LocaleText('no_wars_bundles'),
                        //       Colors.deepOrange,
                        //       const Icon(
                        //         Icons.warning,
                        //         color: Pallete.whiteColor,
                        //       ),
                        //     );
                        //   }

                        fabricDesignBundleToopController
                            .navigateToFabricDesignBundleToopColorCreate(
                          widget.fabricDesignBundleId,
                        );
                      },
                    ),
                    lblText: const LocaleText('search'),
                    onChanged: (value) {
                      fabricDesignBundleToopController
                          .searchFabricDesignToopMethod(value);
                    },
                  ),
                );
              },
            ),
            Expanded(
              child: Consumer<FabricDesignToopController>(
                builder: (context, fabricDesignBundleToopController, child) {
                  final searchFabricDesigns =
                      fabricDesignBundleToopController.searchFabricDesignToop;
                  if (searchFabricDesigns.isEmpty) {
                    // If no data, display the "noData.png" image
                    return const NoDataFoundWidget();
                  }
                  return ListView.builder(
                    itemCount: searchFabricDesigns.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final data = searchFabricDesigns[index];
                      return ListTileWidget(
                        lead: data.status == 'complete'
                            ? // Check if status is complete
                            const Icon(Icons.check, color: Colors.green)
                            : const Icon(Icons.close, color: Colors.red),
                        tileTitle: Row(
                          children: [
                            Text(data.colorname?.toString() ?? ''),
                            const Spacer(),
                            Text(data.war?.toString() ?? ''),
                          ],
                        ),
                        trail: data.status != "complete"
                            ? PopupMenuButton(
                                color: Pallete.whiteColor,
                                child: const Icon(Icons.more_vert_sharp),
                                itemBuilder: (context) =>
                                    <PopupMenuEntry<String>>[
                                  const PopupMenuItem(
                                    value: "delete",
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        LocaleText('delete'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: "edit",
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        LocaleText('update')
                                      ],
                                    ),
                                  ),
                                ],
                                onSelected: (String value) {
                                  if (value == "edit") {
                                    fabricDesignBundleToopController
                                        .navigateToFabricDesignBundleToopEdit(
                                      data.fabricdesigncolorId!,
                                      data.patidesigncolorId,
                                      data,
                                    );
                                  }
                                  if (value == "delete") {
                                    fabricDesignBundleToopController
                                        .deleteFabricDesignBundleToop(
                                            data.patidesigncolorId!,
                                            data.fabricdesigncolorId!);
                                  }
                                },
                              )
                            : null,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CalculationBottomNavigationBar(
        rowsData: [
          RowData(
            icon: Icons.timelapse,
            textKey: 'toop',
            remainingValue:
                fabricDesignBundleToopController.remainingToop.toString(),
            iconColor: Pallete.blueColor,
            textColor: Pallete.blueColor,
          ),
          RowData(
            icon: Icons.format_list_numbered,
            textKey: 'total_toop',
            remainingValue:
                fabricDesignBundleToopController.totalWar.toString(),
          ),
          // Add more RowData objects as needed
        ],
      ),
    );
  }
}
