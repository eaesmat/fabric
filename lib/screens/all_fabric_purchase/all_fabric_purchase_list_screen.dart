import 'package:fabricproject/controller/all_fabric_purchases_controller.dart';
import 'package:fabricproject/controller/fabric_design_controller.dart';
import 'package:fabricproject/screens/fabric_purchase/fabric_purchase_item_details.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class AllFabricPurchaseListScreen extends StatefulWidget {
  const AllFabricPurchaseListScreen({super.key});

  @override
  State<AllFabricPurchaseListScreen> createState() =>
      _AllFabricPurchaseListScreenState();
}

class _AllFabricPurchaseListScreenState
    extends State<AllFabricPurchaseListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<AllFabricPurchasesController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    final fabricDesignController = Provider.of<FabricDesignController>(context);
    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<AllFabricPurchasesController>(context, listen: false)
            .getAllFabricPurchases();
      },
      child: Column(
        children: [
          // Search Text field
          Consumer<AllFabricPurchasesController>(
            builder: (context, allFabricPurchasesController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                // Search text filed
                child: CustomTextFieldWithController(
                  iconBtn: IconButton(
                      icon: const Icon(
                        Icons.add_box,
                        color: Pallete.blueColor,
                      ),
                      onPressed: () {
                        // navigate to new create screen
                        allFabricPurchasesController
                            .navigateToFabricPurchaseCreate();
                      }),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // pass the data to the search method controller
                    allFabricPurchasesController
                        .searchAllFabricPurchasesMethod(value);
                  },
                ),
              );
            },
          ),
          // data list
          Expanded(
            child: Consumer<AllFabricPurchasesController>(
              builder: (context, allFabricPurchasesController, child) {
                final reversedList = allFabricPurchasesController
                    .searchAllFabricPurchases.reversed
                    .toList();

                if (reversedList.isEmpty) {
                  // If no data, display the "noData.png" image
                  return const NoDataFoundWidget();
                }

                return ListView.builder(
                  itemCount: reversedList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = reversedList[index];

                    return ListTileWidget(
                      onTap: () {
                        fabricDesignController.navigateToFabricDesignListScreen(
                          data.fabricpurchasecode.toString(),
                          data.fabricpurchaseId!.toInt(),
                        );
                      },
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return FabricDetailsBottomSheet(
                              data: data,
                              fabricName: data.fabricName.toString(),
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
                          Text(
                            data.fabricName.toString(),
                          ),
                          const Spacer(),
                          Text(
                            data.fabricpurchasecode.toString(),
                          ),
                        ],
                      ),
                      tileSubTitle: Row(
                        children: [
                          Text(
                            data.bundle.toString(),
                          ),
                          const Spacer(),
                          Text(
                            data.war.toString(),
                          ),
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
                              )),
                        ],
                        onSelected: (String value) {
                          if (value == "edit") {
                            // allFabricPurchaseController
                            //     .navigateToFabricPurchaseEdit(
                            //   data,
                            //   data.fabricpurchaseId!.toInt(),
                            // );
                          }
                          if (value == "delete") {
                            allFabricPurchasesController.deleteFabricPurchase(
                              data.fabricpurchaseId!.toInt(),
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
    );
  }
}
