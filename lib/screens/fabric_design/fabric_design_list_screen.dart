import 'package:fabricproject/controller/fabric_design_color_controller.dart';
import 'package:fabricproject/controller/fabric_design_controller.dart';
import 'package:fabricproject/model/fabric_design_model.dart';
import 'package:fabricproject/screens/fabric_design/fabric_design_item_details.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    final fabricDesignController = Provider.of<FabricDesignController>(context);
    final fabricDesignColorController =
        Provider.of<FabricDesignColorController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fabricPurchaseCode),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<FabricDesignController>(
            builder: (context, fabricDesignController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
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
                return ListView.builder(
                  itemCount:
                      fabricDesignController.searchFabricDesigns?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data =
                        fabricDesignController.searchFabricDesigns![index];
                    return ListTileWidget(
                      onTap: () {
                        fabricDesignColorController
                            .navigateToFabricDesignDetails(data.name.toString(),
                                data.fabricdesignId!.toInt());
                      },
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            List<Fabricdesigncolor> fabricDesignColors =
                                (data.fabricdesigncolor ?? [])
                                    .cast<Fabricdesigncolor>();

                            return FabricDesignDetailsBottomSheet(
                              data: data,
                              fabricDesignName: data.name.toString(),
                              designColors: fabricDesignColors,
                            );
                          },
                        );
                      },
                      tileTitle: Text(
                        data.name.toString(),
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
                                data, data.fabricdesignId!.toInt());
                          }
                          if (value == "delete") {
                            fabricDesignController.deleteFabricDesign(
                                data.fabricdesignId, index);
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.blueColor,
        onPressed: () {
          fabricDesignController.navigateToFabricDesignCreate();
        },
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
        ),
      ),
    );
  }
}
