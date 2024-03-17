import 'package:fabricproject/controller/fabric_design_color_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/screens/fabric_design%20_color/fabric_design_color_button_sheet.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:fabricproject/widgets/no_bundle_color_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';

class FabricDesignColorListScreen extends StatefulWidget {
  final int fabricDesignId;
  final String fabricDesignName;
  final String fabricPurchaseCode;
  final int colorCount;
  final int colorLength;
  const FabricDesignColorListScreen({
    Key? key,
    required this.fabricDesignId,
    required this.fabricDesignName,
    required this.fabricPurchaseCode,
    required this.colorCount,
    required this.colorLength,
  }) : super(key: key);

  @override
  State<FabricDesignColorListScreen> createState() =>
      _FabricDesignColorListScreenState();
}

class _FabricDesignColorListScreenState
    extends State<FabricDesignColorListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextTitle(
          text: '${widget.fabricDesignName} (${widget.fabricPurchaseCode})',
        ),
        centerTitle: true,
      ), // Add your app bar here if needed
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await Provider.of<FabricDesignColorController>(context, listen: false)
              .getAllFabricDesignColors(widget.fabricDesignId);
        },
        child: Column(
          children: [
            Consumer<FabricDesignColorController>(
              builder: (context, fabricDesignColorController, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomTextFieldWithController(
                    iconBtn: IconButton(
                      icon: const Icon(
                        Icons.add_box,
                        color: Pallete.blueColor,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return const ColorListScreenBottomSheet();
                          },
                        );
                      },
                    ),
                    lblText: const LocaleText('search'),
                    onChanged: (value) {
                      fabricDesignColorController
                          .searchFabricDesignColorsMethod(value);
                    },
                  ),
                );
              },
            ),
            Expanded(
              child: Consumer<FabricDesignColorController>(
                builder: (context, fabricDesignColorController, child) {
                  final fabricDesignColors =
                      fabricDesignColorController.searchFabricDesignColors;
                  if (fabricDesignColors.isEmpty) {
                    // If no data, display the "noData.png" image
                    return const NoDataFoundWidget();
                  }
                  return ListView.builder(
                    itemCount: fabricDesignColors.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final data = fabricDesignColors[index];
                      return ListTileWidget(
                        lead: CircleAvatar(
                          backgroundColor:
                              getColorFromName(data.colorname.toString()),
                        ),
                        tileTitle: Text(
                          data.colorname.toString(),
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
                                  LocaleText('update')
                                ],
                              ),
                            ),
                          ],
                          onSelected: (String value) {
                            if (value == "edit") {
                              fabricDesignColorController
                                  .navigateToFabricDesignColorEdit(
                                data,
                                data.fabricdesigncolorId!.toInt(),
                              );
                            }
                            if (value == "delete") {
                              fabricDesignColorController
                                  .deleteFabricDesignColor(
                                data.fabricdesigncolorId!.toInt(),
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
    );
  }
}
