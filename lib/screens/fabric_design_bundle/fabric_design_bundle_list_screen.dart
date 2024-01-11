import 'package:fabricproject/controller/fabric_design_bundle_controller.dart';
import 'package:fabricproject/controller/pati_controller.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class FabricDesignBundleListScreen extends StatefulWidget {
  final int fabricDesignId;
  final String fabricDesignName;
  const FabricDesignBundleListScreen({
    Key? key,
    required this.fabricDesignId,
    required this.fabricDesignName,
  }) : super(key: key);

  @override
  State<FabricDesignBundleListScreen> createState() =>
      _FabricDesignBundleListScreenState();
}

class _FabricDesignBundleListScreenState
    extends State<FabricDesignBundleListScreen> {
  @override
  Widget build(BuildContext context) {
    final patiController = Provider.of<PatiController>(context);

    return Column(
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
                      .searchFabricDesignBundleMethod(value);
                },
              ),
            );
          },
        ),
        Expanded(
          child: Consumer<FabricDesignBundleController>(
            builder: (context, fabricDesignBundleController, child) {
              return ListView.builder(
                itemCount: fabricDesignBundleController
                        .searchFabricDesignBundles?.length ??
                    0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = fabricDesignBundleController
                      .searchFabricDesignBundles![index];
                  return ListTileWidget(
                    onTap: () {
                      // pass the fabric Id to the fabric design controller
                      patiController.navigateToPatiListScreen(
                        data.designbundleId!.toInt(),
                        widget.fabricDesignId,
                        widget.fabricDesignName,
                      );
                      print(widget.fabricDesignName.toString());
                    },
                    lead: CircleAvatar(
                      backgroundColor: Pallete.blueColor,
                      child: Text(
                        data.bundlename!.toUpperCase(),
                        style: const TextStyle(color: Pallete.whiteColor),
                      ),
                    ),
                    tileTitle: Text(
                      "${data.bundletoop}",
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
                          fabricDesignBundleController
                              .navigateToFabricDesignBundleEdit(
                                  data, data.designbundleId!.toInt());
                        }
                        if (value == "delete") {
                          fabricDesignBundleController.deleteFabricDesignBundle(
                              data.designbundleId, index);
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
      // ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Pallete.blueColor,
      //   onPressed: () {
      //     drawController.navigateToDrawCreate();
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     color: Pallete.whiteColor,
      //   ),
      // ),
    );
  }
}
