import 'package:fabricproject/controller/all_fabric_purchase_controller.dart';
import 'package:fabricproject/controller/fabric_design_controller.dart';
import 'package:fabricproject/screens/fabric_purchase/fabric_purchase_item_details.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
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
      Provider.of<AllFabricPurchaseController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    final fabricDesignController = Provider.of<FabricDesignController>(context);

    return Column(
      children: [
        // Search Text field
        Consumer<AllFabricPurchaseController>(
          builder: (context, allFabricPurchaseController, child) {
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
                      allFabricPurchaseController
                          .navigateToFabricPurchaseCreate();
                    }),
                lblText: const LocaleText('search'),
                onChanged: (value) {
                  // pass the data to the search method controller
                  allFabricPurchaseController
                      .searchFabricPurchasesMethod(value);
                },
              ),
            );
          },
        ),
        // data list
        Expanded(
          child: Consumer<AllFabricPurchaseController>(
            builder: (context, allFabricPurchaseController, child) {
              return ListView.builder(
                itemCount:
                    allFabricPurchaseController.searchFabricPurchases?.length ??
                        0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // data vars takes data from controller
                  final reversedList = allFabricPurchaseController
                      .searchFabricPurchases!.reversed
                      .toList();
                  final data = reversedList[index];

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
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return FabricDetailsBottomSheet(
                              // pass the these data to the widget
                              data: data,
                              fabricName: data.fabric!.name.toString());
                        },
                      );
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
                          allFabricPurchaseController
                              .navigateToFabricPurchaseEdit(
                            data,
                            data.fabricpurchaseId!.toInt(),
                          );
                        }
                        if (value == "delete") {
                          allFabricPurchaseController.deleteFabricPurchase(
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
