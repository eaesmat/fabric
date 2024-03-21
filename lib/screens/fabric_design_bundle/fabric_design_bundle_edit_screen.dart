import 'package:fabricproject/controller/fabric_design_bundle_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/fabric_design_bundle_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/calculation_bottom_navigation.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class FabricDesignBundleEditScreen extends StatefulWidget {
  final Data fabricDesignBundleData;
  final int fabricDesignBundleId;
  const FabricDesignBundleEditScreen(
      {super.key,
      required this.fabricDesignBundleData,
      required this.fabricDesignBundleId});

  @override
  State<FabricDesignBundleEditScreen> createState() =>
      _FabricDesignBundleEditScreenState();
}

class _FabricDesignBundleEditScreenState
    extends State<FabricDesignBundleEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final fabricDesignBundleController =
        Provider.of<FabricDesignBundleController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'update_bundle'),
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
                    lblText: const LocaleText('bundle_name'),
                    controller:
                        fabricDesignBundleController.bundleNameController,
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('bundle_toop'),
                    controller: fabricDesignBundleController
                        .amountOfBundleToopController,
                    customValidator: (value) =>
                        customValidatorCheckNumberOnly(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('war_bundle'),
                    controller:
                        fabricDesignBundleController.warBundleController,
                    customValidator: (value) =>
                        customValidatorCheckNumberOnly(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('description'),
                    controller:
                        fabricDesignBundleController.descriptionController,
                  ),
                  CustomDropDownButton(
                    btnWidth: 1,
                    btnIcon: const Icon(
                      Icons.check,
                      color: Pallete.whiteColor,
                    ),
                    btnText: const LocaleText(
                      'update',
                      style: TextStyle(color: Pallete.whiteColor),
                    ),
                    bgColor: Pallete.blueColor,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        fabricDesignBundleController.editFabricDesignBundle(
                          widget.fabricDesignBundleId,
                          widget.fabricDesignBundleData,
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
      bottomNavigationBar: CalculationBottomNavigationBar(
        rowsData: [
          RowData(
            icon: Icons.timelapse,
            textKey: 'bundle',
            remainingValue:
                fabricDesignBundleController.remainingBundle.toString(),
            iconColor: Pallete.blueColor,
            textColor: Pallete.blueColor,
          ),
          RowData(
            icon: Icons.timelapse,
            textKey: 'toop',
            remainingValue:
                fabricDesignBundleController.remainingToop.toString(),
          ),
          // Add more RowData objects as needed
        ],
      ),
    );
  }
}
