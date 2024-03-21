import 'package:fabricproject/controller/colors_controller.dart';
import 'package:fabricproject/controller/fabric_design_color_controller.dart';
import 'package:fabricproject/controller/fabric_design_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:fabricproject/model/fabric_design_model.dart';

import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class ColorListScreenBottomSheet extends StatefulWidget {
  final Data fabricDesignData;
  const ColorListScreenBottomSheet({
    Key? key,
    required this.fabricDesignData,
  }) : super(key: key);

  @override
  State<ColorListScreenBottomSheet> createState() =>
      _ColorListScreenBottomSheetState();
}

class _ColorListScreenBottomSheetState
    extends State<ColorListScreenBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final colorsController = Provider.of<ColorsController>(context);
    final fabricDesignColorController =
        Provider.of<FabricDesignColorController>(context);

    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<ColorsController>(context, listen: false)
            .getAllColors();
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          margin: EdgeInsets.zero,
          height: MediaQuery.of(context).size.height * 0.9,
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          color: Pallete.whiteColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
                  iconBtn: IconButton(
                    icon: const Icon(
                      Icons.add_box,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      colorsController.navigateToColorCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    colorsController.searchColorsMethod(value);
                  },
                ),
              ),
              Expanded(
                child: colorsController.searchColors.isEmpty
                    ? const NoDataFoundWidget() // Show NoDataFoundWidget if the list is empty
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: colorsController.searchColors.length,
                        itemBuilder: (context, index) {
                          final reversedList =
                              colorsController.searchColors.reversed.toList();
                          final data = reversedList[index];
                          final isSelected =
                              colorsController.selectedColors?.contains(data);

                          return ListTileWidget(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  colorsController
                                      .removeColorFromSelected(data);
                                  fabricDesignColorController
                                      .removeItemFromData(
                                          "checkbox${data.colorId}");
                                } else {
                                  colorsController.addColorToSelected(data);
                                  fabricDesignColorController.addItemToData(
                                      "checkbox${data.colorId}",
                                      "${data.colorId}");
                                }
                              });
                            },
                            lead: CircleAvatar(
                              backgroundColor:
                                  getColorFromName(data.colorname.toString()),
                            ),
                            tileTitle: Text(data.colorname ?? ''),
                            trail: isSelected!
                                ? const Icon(Icons.check_circle,
                                    color: Pallete.blueColor)
                                : Icon(Icons.check_circle_outline,
                                    color: Colors.grey.shade700),
                          );
                        },
                      ),
              ),
              CustomDropDownButton(
                bgColor: Pallete.blueColor,
                onTap: () {
                  // add a colorLength to fabric Design to be able to go the
                  // fabric Design bundle screen
                  final data = widget.fabricDesignData;
                  Provider.of<FabricDesignController>(context, listen: false)
                      .updateFabricDesignLocally(
                    data.fabricdesignId!,
                    Data(
                      fabricdesignId: data.fabricdesignId,
                      bundle: data.bundle,
                      colors: data.colors,
                      colorsLength: 2,
                      countColor: data.countColor,
                      name: data.name,
                      status: data.status,
                      toop: data.toop,
                      war: data.war,
                    ),
                  );
                  fabricDesignColorController.createColors();
                  colorsController.clearAllControllers();
                  Navigator.pop(context);
                },
                btnText: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: Pallete.whiteColor,
                    ),
                    LocaleText(
                      'select',
                      style: TextStyle(color: Pallete.whiteColor),
                    ),
                  ],
                ),
                btnIcon: Text(
                  colorsController.selectedColors!.length.toString(),
                  style: const TextStyle(color: Pallete.whiteColor),
                ),
                btnWidth: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
