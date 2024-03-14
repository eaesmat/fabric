import 'package:fabricproject/controller/colors_controller.dart';
import 'package:fabricproject/controller/fabric_design_color_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class ColorBottomSheet extends StatefulWidget {
  const ColorBottomSheet({Key? key}) : super(key: key);

  @override
  State<ColorBottomSheet> createState() => _ColorBottomSheetState();
}

class _ColorBottomSheetState extends State<ColorBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // controller provider
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
                    ? const NoDataFoundWidget()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: colorsController.searchColors.length,
                        itemBuilder: (context, index) {
                          // data gets data from controller
                          final reversedList =
                              colorsController.searchColors.reversed.toList();
                          final data = reversedList[index];

                          return ListTileWidget(
                            onTap: () {
                              fabricDesignColorController
                                  .selectedColorIdController
                                  .text = data.colorId.toString();
                              fabricDesignColorController
                                  .selectedColorNameController
                                  .text = data.colorname.toString();
                              Navigator.pop(context);
                            },
                            lead: CircleAvatar(
                              backgroundColor:
                                  getColorFromName(data.colorname.toString()),
                            ),
                            tileTitle: Text(data.colorname ?? ''),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
