import 'package:fabricproject/controller/fabric_design_bundle_controller.dart';
import 'package:fabricproject/screens/fabric_design_bundle/fabric_design_bundle_item_details.dart';
import 'package:fabricproject/widgets/calculation_bottom_navigation.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class FabricDesignBundleListScreen extends StatefulWidget {
  final int fabricDesignId;
  final String fabricDesignName;
  final String fabricPurchaseCode;
  final int colorLength;
  const FabricDesignBundleListScreen({
    Key? key,
    required this.fabricDesignId,
    required this.fabricDesignName,
    required this.fabricPurchaseCode,
    required this.colorLength,
  }) : super(key: key);

  @override
  State<FabricDesignBundleListScreen> createState() =>
      _FabricDesignBundleListScreenState();
}

class _FabricDesignBundleListScreenState
    extends State<FabricDesignBundleListScreen> {
  @override
  Widget build(BuildContext context) {
    final fabricDesignBundleController =
        Provider.of<FabricDesignBundleController>(context);
    return Scaffold(
      appBar: AppBar(
        title: CustomTextTitle(
          text: '${widget.fabricDesignName} (${widget.fabricPurchaseCode})',
        ),
        centerTitle: true,
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await Provider.of<FabricDesignBundleController>(context,
                  listen: false)
              .getAllFabricDesignBundles(widget.fabricDesignId);
        },
        child: Column(
          children: [
            Consumer<FabricDesignBundleController>(
              builder: (context, fabricDesignBundleController, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomTextFieldWithController(
                    iconBtn: IconButton(
                        icon: const Icon(
                          Icons.add_box,
                          color: Pallete.blueColor,
                        ),
                        onPressed: () {
                          fabricDesignBundleController
                              .navigateToFabricDesignBundleCreate();
                        }),
                    lblText: const LocaleText('search'),
                    onChanged: (value) {
                      fabricDesignBundleController
                          .searchFabricDesignBundlesMethod(value);
                    },
                  ),
                );
              },
            ),
            Expanded(
              child: Consumer<FabricDesignBundleController>(
                builder: (context, fabricDesignBundleController, child) {
                  final searchFabricDesignBundles =
                      fabricDesignBundleController.searchFabricDesignBundles;

                  if (searchFabricDesignBundles.isEmpty) {
                    return const NoDataFoundWidget();
                  }

                  return ListView.builder(
                    itemCount: searchFabricDesignBundles.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final data = searchFabricDesignBundles[index];
                      bool showTrail = data.status == 'incomplete';

                      return ListTileWidget(
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return FabricDesignBundleDetailsBottomSheet(
                                data: data,
                                fabricDesignName: widget.fabricDesignName,
                                fabricPurchaseCode: widget.fabricPurchaseCode,
                              );
                            },
                          );
                        },
                        onTap: () {
                          print(data.designBundleWar);
                        },
                        lead: data.status == 'complete'
                            ? const Icon(Icons.check, color: Colors.green)
                            : const Icon(Icons.close, color: Colors.red),
                        tileTitle: Row(
                          children: [
                            Text(
                              data.bundlename?.toString().toUpperCase() ?? '',
                            ),
                            const Spacer(),
                            Text(
                              data.bundletoop?.toString() ?? '',
                            ),
                          ],
                        ),
                        tileSubTitle: Row(
                          children: [
                            Text(
                              data.bundlewar?.toString() ?? '',
                            ),
                            const Spacer(),
                            Text(
                              data.toopwar?.toString() ?? '',
                            ),
                          ],
                        ),
                        trail: showTrail
                            ? PopupMenuButton(
                                color: Pallete.whiteColor,
                                child: const Icon(Icons.more_vert_sharp),
                                itemBuilder: (context) =>
                                    <PopupMenuEntry<String>>[
                                  if (data.designBundleWar == null)
                                    const PopupMenuItem(
                                      value: "distribute",
                                      child: Row(
                                        children: [
                                          Icon(Icons.diversity_2_rounded),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          LocaleText('distribute'),
                                        ],
                                      ),
                                    ),
                                  if (data.designBundleWar == "true" &&
                                      data.status == "incomplete")
                                    const PopupMenuItem(
                                      value: "complete",
                                      child: Row(
                                        children: [
                                          Icon(Icons.check_circle),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          LocaleText('complete'),
                                        ],
                                      ),
                                    ),
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
                                        LocaleText('update'),
                                      ],
                                    ),
                                  ),
                                ],
                                onSelected: (String value) {
                                  if (value == "edit") {
                                    fabricDesignBundleController
                                        .navigateToFabricDesignBundleEdit(
                                            data, data.designbundleId!.toInt());
                                  }
                                  if (value == "delete") {
                                    fabricDesignBundleController
                                        .deleteFabricDesignBundle(
                                      data.designbundleId!,
                                    );
                                    print(data.designbundleId);
                                  }
                                  if (value == "complete") {
                                    // Handle completion action
                                    fabricDesignBundleController
                                        .completeDesignBundleStatus(
                                            data.designbundleId!);
                                    print("UI ID");

                                    print(data.designbundleId);
                                  }
                                  if (value == "distribute") {
                                    fabricDesignBundleController
                                        .distributeFabricDesignBundle(
                                      data.designbundleId!,
                                    );
                                    print("UI ID");
                                    print(data.designbundleId);
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
            textKey: 'bundle',
            remainingValue:
                fabricDesignBundleController.remainingBundle.toString(),
            iconColor: Pallete.blueColor,
            textColor: Pallete.blueColor,
          ),
          RowData(
            icon: Icons.timelapse,
            textKey: 'toop',
            remainingValue:
                fabricDesignBundleController.remainingToop.toString(),
          ),
          // Add more RowData objects as needed
        ],
      ),
    );
  }
}
