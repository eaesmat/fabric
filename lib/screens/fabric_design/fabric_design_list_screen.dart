import 'package:fabricproject/controller/fabric_design_color_controller.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/calculation_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/controller/fabric_design_controller.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import 'package:fabricproject/screens/fabric_design/fabric_design_item_details.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';

class FabricDesignListScreen extends StatefulWidget {
  final int fabricPurchaseId;

  final String fabricPurchaseCode;
  const FabricDesignListScreen({
    Key? key,
    required this.fabricPurchaseId,
    required this.fabricPurchaseCode,
  }) : super(key: key);

  @override
  State<FabricDesignListScreen> createState() => _FabricDesignListScreenState();
}

class _FabricDesignListScreenState extends State<FabricDesignListScreen> {
  final HelperServices helper = HelperServices.instance;

  @override
  Widget build(BuildContext context) {
    final fabricDesignController = Provider.of<FabricDesignController>(context);
    final fabricDesignColorController =
        Provider.of<FabricDesignColorController>(context);

    return Scaffold(
      appBar: AppBar(
        title: CustomTextTitle(text: widget.fabricPurchaseCode),
        centerTitle: true,
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          // Implement your refresh logic here
          await Provider.of<FabricDesignController>(context, listen: false)
              .getAllFabricDesigns(widget.fabricPurchaseId);
        },
        child: Column(
          children: [
            Consumer<FabricDesignController>(
              builder: (context, fabricDesignController, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomTextFieldWithController(
                    iconBtn: IconButton(
                      icon: const Icon(
                        Icons.add_box,
                        color: Pallete.blueColor,
                      ),
                      onPressed: () {
                        final fabricDesignController =
                            Provider.of<FabricDesignController>(context,
                                listen: false);
                        int bundle =
                            fabricDesignController.remainingBundle ?? 0;
                        int war = fabricDesignController.remainingWar ?? 0;

                        if (bundle > 0 && war > 0) {
                          fabricDesignController.navigateToFabricDesignCreate(
                              widget.fabricPurchaseId);
                        } else {
                          helper.showMessage(
                            const LocaleText('no_wars_bundles'),
                            Colors.deepOrange,
                            const Icon(
                              Icons.warning,
                              color: Pallete.whiteColor,
                            ),
                          );
                        }
                      },
                    ),
                    lblText: const LocaleText('search'),
                    onChanged: (value) {
                      fabricDesignController.searchFabricDesignMethod(value);
                    },
                  ),
                );
              },
            ),
            Expanded(
              child: Consumer<FabricDesignController>(
                builder: (context, fabricDesignController, child) {
                  final searchFabricDesigns =
                      fabricDesignController.searchFabricDesigns;
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
                        onTap: () {
                          fabricDesignColorController
                              .navigateToFabricDesignDetails(
                            data.name.toString(),
                            data.fabricdesignId!.toInt(),
                            data.countColor,
                            data.colorsLength
                          );
                        },
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return FabricDesignDetailsBottomSheet(
                                data: data,
                                fabricDesignName: data.name.toString(),
                                fabricPurchaseCode: widget.fabricPurchaseCode,
                              );
                            },
                          );
                        },
                        lead: data.status == 'complete'
                            ? // Check if status is complete
                            const Icon(Icons.check, color: Colors.green)
                            : const Icon(Icons.close, color: Colors.red),
                        tileTitle: Row(
                          children: [
                            Text(data.name?.toString() ?? ''),
                            const Spacer(),
                            Text(data.bundle?.toString() ?? ''),
                          ],
                        ),
                        tileSubTitle: Row(
                          children: [
                            Text(data.war?.toString() ?? ''),
                            const Spacer(),
                            Text(data.toop?.toString() ?? ''),
                          ],
                        ),
                        trail: PopupMenuButton(
                          color: Pallete.whiteColor,
                          child: const Icon(Icons.more_vert_sharp),
                          itemBuilder: (context) => <PopupMenuEntry<String>>[
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
                                )),
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
                              fabricDesignController.navigateToFabricDesignEdit(
                                data,
                                data.fabricdesignId!.toInt(),
                                widget.fabricPurchaseId,
                              );
                            }
                            if (value == "delete") {
                              fabricDesignController.deleteFabricDesign(
                                data.fabricdesignId!.toInt(),
                                widget.fabricPurchaseId,
                              );
                            }
                          },
                        ),
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
            remainingValue: fabricDesignController.remainingBundle.toString(),
            iconColor: Pallete.blueColor,
            textColor: Pallete.blueColor,
          ),
          RowData(
            icon: Icons.timelapse,
            textKey: 'war',
            remainingValue: fabricDesignController.remainingWar.toString(),
          ),
          // Add more RowData objects as needed
        ],
      ),
    );
  }
}
