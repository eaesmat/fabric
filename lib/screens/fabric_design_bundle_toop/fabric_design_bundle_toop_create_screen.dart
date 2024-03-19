import 'package:fabricproject/controller/fabric_design_toop_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/screens/fabric_design_bundle_toop/fabric_design_bundle_toop_color_button_sheet.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:fabricproject/widgets/calculation_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class FabricDesignBundleToopColorCreateScreen extends StatefulWidget {
  final int fabricDesignBundleId;
  const FabricDesignBundleToopColorCreateScreen({
    super.key,
    required this.fabricDesignBundleId,
  });

  @override
  State<FabricDesignBundleToopColorCreateScreen> createState() =>
      _FabricDesignBundleToopColorCreateScreenState();
}

class _FabricDesignBundleToopColorCreateScreenState
    extends State<FabricDesignBundleToopColorCreateScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final fabricDesignBundleToopColorController =
        Provider.of<FabricDesignToopController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'create_new_color'),
        centerTitle: true,
      ),
      body: Dialog.fullscreen(
        backgroundColor: Pallete.whiteColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFieldWithController(
                    lblText: const LocaleText('war_toop'),
                    controller:
                        fabricDesignBundleToopColorController.warToopController,
                    customValidator: (value) => customValidatorCheckNumberOnly(
                      value,
                      currentLocale,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const FabricDesignBundleToopColorBottomSheet();
                        },
                      );
                    },
                    child: CustomTextFieldWithController(
                      customValidator: (value) =>
                          customValidator(value, currentLocale),
                      isDisabled: true,
                      controller: fabricDesignBundleToopColorController
                          .selectedColorNameController,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('colors'),
                    ),
                  ),
                  CustomDropDownButton(
                    btnWidth: 1,
                    btnIcon: const Icon(
                      Icons.check,
                      color: Pallete.whiteColor,
                    ),
                    btnText: const LocaleText(
                      'create',
                      style: TextStyle(color: Pallete.whiteColor),
                    ),
                    bgColor: Pallete.blueColor,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        fabricDesignBundleToopColorController
                            .createFabricDesignBundleToopColor(
                          widget.fabricDesignBundleId,
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: CalculationBottomNavigationBar(
      //   rowsData: [
      //     RowData(
      //       icon: Icons.timelapse,
      //       textKey: 'bundle',
      //       remainingValue: fabricDesignController.remainingBundle.toString(),
      //       iconColor: Pallete.blueColor,
      //       textColor: Pallete.blueColor,
      //     ),
      //     RowData(
      //       icon: Icons.timelapse,
      //       textKey: 'war',
      //       remainingValue: fabricDesignController.remainingWar.toString(),
      //     ),
      //   ],
      // ),
    );
  }
}
