import 'package:fabricproject/controller/all_fabric_purchases_controller.dart';
import 'package:fabricproject/controller/fabric_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class FabricBottomSheet extends StatefulWidget {
  const FabricBottomSheet({super.key});

  @override
  State<FabricBottomSheet> createState() => _FabricBottomSheetState();
}

class _FabricBottomSheetState extends State<FabricBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<FabricController>(context, listen: false).resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
// controller class providers
    FabricController fabricController = Provider.of<FabricController>(context);

    final allFabricPurchasesController =
        Provider.of<AllFabricPurchasesController>(context);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.all(16.0),
        color: Pallete.whiteColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                // search item widget
                child: CustomTextFieldWithController(
                  iconBtn: IconButton(
                    icon: const Icon(
                      size: 30,
                      Icons.add_box_rounded,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      // to create new item from here
                      fabricController.navigateToFabricCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // passes the search text to the controller
                    fabricController.searchFabricsMethod(value);
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              // list data here
              ListView.builder(
                shrinkWrap: true,
                itemCount: fabricController.searchFabrics?.length ?? 0,
                itemBuilder: (context, index) {
                  // data from controller
                  final reversedList =
                      fabricController.searchFabrics!.reversed.toList();
                  final data = reversedList[index];
                  return ListTileWidget(
                    onTap: () {
                      // passes the id and name to the controller class
                      // pass id
                      allFabricPurchasesController.fabricCodeController.text =
                          '${data.abr}-${allFabricPurchasesController.dateController.text}';
                      allFabricPurchasesController.selectedFabricIdController
                          .text = data.fabricId!.toString();
                      // pass the name and others
                      allFabricPurchasesController
                              .selectedFabricNameController.text =
                          '${data.name},  ${data.description} (${data.abr} )';

                      Navigator.pop(context);
                    },
                    lead: CircleAvatar(
                      backgroundColor: Pallete.blueColor,
                      child: Text(
                        data.abr!.toUpperCase(),
                        style: const TextStyle(color: Pallete.whiteColor),
                      ),
                    ),
                    tileTitle: Text(
                      data.name.toString(),
                    ),
                    tileSubTitle: Text(data.description.toString()),
                    // delete and update
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
                          ),
                        ),
                      ],
                      onSelected: (String value) {
                        if (value == "edit") {
                          // edit and pass the id to the controller to edit
                          fabricController.navigateToFabricEdit(
                              data, data.fabricId!.toInt());
                        }
                        if (value == "delete") {
                          // delete the item
                          fabricController.deleteFabric(data.fabricId!);
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
