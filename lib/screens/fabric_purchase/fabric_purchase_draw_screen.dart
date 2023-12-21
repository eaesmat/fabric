import 'package:fabricproject/controller/fabric_purchase_controller.dart';
import 'package:fabricproject/screens/fabric_purchase/fabric_purchase_details.dart';
import 'package:fabricproject/screens/fabric_purchase/fabric_purchase_item_details.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class FabricPurchaseDrawScreen extends StatefulWidget {
  final int vendorCompanyId;
  final String vendorCompanyName;
  const FabricPurchaseDrawScreen(
      {Key? key,
      required this.vendorCompanyId,
      required this.vendorCompanyName})
      : super(key: key);

  @override
  State<FabricPurchaseDrawScreen> createState() =>
      _FabricPurchaseDrawScreenState();
}

class _FabricPurchaseDrawScreenState extends State<FabricPurchaseDrawScreen> {
  @override
  Widget build(BuildContext context) {
    final fabricPurchaseController =
        Provider.of<FabricPurchaseController>(context);

    return Column(
      children: [
        Consumer<FabricPurchaseController>(
          builder: (context, fabricPurchaseController, child) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomTextFieldWithController(
                iconBtn: IconButton(
                    icon: const Icon(
                      Icons.add_box,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      fabricPurchaseController.navigateToFabricPurchaseCreate();
                    }),
                lblText: const LocaleText('search'),
                onChanged: (value) {
                  fabricPurchaseController.searchFabricPurchasesMethod(value);
                },
              ),
            );
          },
        ),
        Expanded(
          child: Consumer<FabricPurchaseController>(
            builder: (context, vendorCompanyController, child) {
              return ListView.builder(
                itemCount:
                    fabricPurchaseController.searchFabricPurchases?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data =
                      fabricPurchaseController.searchFabricPurchases![index];
                  fabricPurchaseController.vendorCompanyId =
                      data.vendorcompanyId;

                  return ListTileWidget(
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return FabricDetailsBottomSheet(
                              data: data,
                              fabricName: data.fabric!.name.toString());
                        },
                      );
                    },
                    tileTitle: Text(
                      data.fabric!.name.toString(),
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
