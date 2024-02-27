import 'package:fabricproject/controller/fabric_design_controller.dart';
import 'package:fabricproject/controller/fabric_purchase_controller.dart';
import 'package:fabricproject/screens/fabric_purchase/fabric_purchase_item_details.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class FabricPurchaseListScreen extends StatefulWidget {
  // Gets the data from the controller
  final int vendorCompanyId;
  final String vendorCompanyName;
  const FabricPurchaseListScreen(
      {Key? key,
      required this.vendorCompanyId,
      required this.vendorCompanyName})
      : super(key: key);

  @override
  State<FabricPurchaseListScreen> createState() =>
      _FabricPurchaseListScreenState();
}

class _FabricPurchaseListScreenState extends State<FabricPurchaseListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<FabricPurchaseController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    final fabricDesignController = Provider.of<FabricDesignController>(context);

    return Column(
      children: [
        // Search Text field
        Consumer<FabricPurchaseController>(
          builder: (context, fabricPurchaseController, child) {
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
                    fabricPurchaseController.navigateToFabricPurchaseCreate();
                  },
                ),
                lblText: const LocaleText('search'),
                onChanged: (value) {
                  // pass the data to the search method controller
                  fabricPurchaseController.searchFabricPurchasesMethod(value);
                },
              ),
            );
          },
        ),
        // data list
        Expanded(
          child: Consumer<FabricPurchaseController>(
            builder: (context, fabricPurchaseController, child) {
              return ListView.builder(
                itemCount:
                    fabricPurchaseController.searchFabricPurchases?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // data vars takes data from controller
                  final reversedList = fabricPurchaseController
                      .searchFabricPurchases!.reversed
                      .toList();
                  final data = reversedList[index];
                  fabricPurchaseController.vendorCompanyId =
                      data.vendorcompanyId;

                  return ListTileWidget(
                    onTap: () {
                      // pass the fabric Id to the fabric design controller
                      fabricDesignController.navigateToFabricDesignListScreen(
                        data.fabricpurchasecode.toString(),
                        data.fabricpurchaseId!.toInt(),
                      );
                    },
                    onLongPress: () {
                      // show bottom modal sheet to view more details of the fabric purchase
                      // showModalBottomSheet(
                      //   context: context,
                      //   isScrollControlled: true,
                      //   builder: (BuildContext context) {
                      //     return FabricDetailsBottomSheet(
                      //         // pass the these data to the widget
                      //         data: data,
                      //         fabricName: data.fabric!.name.toString());
                      //   },
                      // );
                    },
                    tileTitle: Row(
                      children: [
                        Text(
                          data.fabric!.name.toString(),
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
                    // delete and update actions
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
                          fabricPurchaseController.navigateToFabricPurchaseEdit(
                            data,
                            data.fabricpurchaseId!.toInt(),
                          );
                        }
                        if (value == "delete") {
                          fabricPurchaseController.deleteFabricPurchase(
                              data.fabricpurchaseId, index);
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
    );
  }
}
