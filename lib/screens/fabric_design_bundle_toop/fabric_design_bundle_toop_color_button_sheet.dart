import 'package:fabricproject/controller/fabric_design_toop_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class FabricDesignBundleToopColorBottomSheet extends StatefulWidget {
  const FabricDesignBundleToopColorBottomSheet({Key? key}) : super(key: key);

  @override
  State<FabricDesignBundleToopColorBottomSheet> createState() =>
      _FabricDesignBundleToopColorBottomSheetState();
}

class _FabricDesignBundleToopColorBottomSheetState
    extends State<FabricDesignBundleToopColorBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // controller provider
    final fabricDesignBundleToopColorsController =
        Provider.of<FabricDesignToopController>(context);

    return ClipRRect(
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
                lblText: const LocaleText('search'),
                onChanged: (value) {
                  fabricDesignBundleToopColorsController
                      .searchFabricDesignToopColorMethod(value);
                },
              ),
            ),
            Expanded(
              child: fabricDesignBundleToopColorsController
                      .searchFabricDesignToopColors.isEmpty
                  ? const NoDataFoundWidget()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: fabricDesignBundleToopColorsController
                          .searchFabricDesignToopColors.length,
                      itemBuilder: (context, index) {
                        // data gets data from controller
                        final reversedList =
                            fabricDesignBundleToopColorsController
                                .searchFabricDesignToopColors.reversed
                                .toList();
                        final data = reversedList[index];

                        return ListTileWidget(
                          onTap: () {
                            fabricDesignBundleToopColorsController
                                .selectedColorIdController
                                .text = data.fabricdesigncolorId.toString();
                            fabricDesignBundleToopColorsController
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
    );
  }
}
