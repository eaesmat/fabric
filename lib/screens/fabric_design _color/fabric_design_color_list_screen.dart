import 'package:fabricproject/controller/fabric_design_color_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/screens/fabric_design%20_color/fabric_design_color_button_sheet.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class FabricDesignColorListScreen extends StatefulWidget {
  final int fabricDesignId;
  final String fabricDesignName;
  const FabricDesignColorListScreen({
    Key? key,
    required this.fabricDesignId,
    required this.fabricDesignName,
  }) : super(key: key);

  @override
  State<FabricDesignColorListScreen> createState() =>
      _FabricDesignColorListScreenState();
}

class _FabricDesignColorListScreenState
    extends State<FabricDesignColorListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                          return const FabricDesignColorSheet();
                        },
                      );
                    }),
                lblText: const LocaleText('search'),
                onChanged: (value) {
                  fabricDesignColorController
                      .searchFabricDesignColorMethod(value);
                },
              ),
            );
          },
        ),
        Expanded(
          child: Consumer<FabricDesignColorController>(
            builder: (context, fabricDesignColorController, child) {
              return ListView.builder(
                itemCount: fabricDesignColorController
                        .searchFabricDesignColors?.length ??
                    0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = fabricDesignColorController
                      .searchFabricDesignColors![index];
                  fabricDesignColorController.fabricDesignId =
                      data.fabricdesignId;

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
                            )),
                      ],
                      onSelected: (String value) {
                        if (value == "delete") {
                          fabricDesignColorController.deleteFabricDesignColor(
                              data.fabricdesigncolorId, index);
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
