import 'package:fabricproject/controller/fabric_design_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/fabric_design_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:fabricproject/widgets/calculation_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class FabricDesignEditScreen extends StatefulWidget {
  final Data fabricDesignData;
  final int fabricDesignId;
  final int fabricPurchaseId;
  const FabricDesignEditScreen({
    super.key,
    required this.fabricDesignData,
    required this.fabricDesignId,
    required this.fabricPurchaseId,
  });

  @override
  State<FabricDesignEditScreen> createState() => _FabricDesignEditScreenState();
}

class _FabricDesignEditScreenState extends State<FabricDesignEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final fabricDesignController = Provider.of<FabricDesignController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'create_fabric_design'),
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
                    lblText: const LocaleText('design_name'),
                    controller: fabricDesignController.nameController,
                    customValidator: (value) => customValidator(
                      value,
                      currentLocale,
                    ),
                  ),
                  CustomTextFieldWithController(
                    controller:
                        fabricDesignController.amountOfBundlesController,
                    lblText: const LocaleText('bundle'),
                    customValidator: (value) => customValidator(
                      value,
                      currentLocale,
                    ),
                  ),
                  CustomTextFieldWithController(
                    controller: fabricDesignController.amountOfWarsController,
                    lblText: const LocaleText('war'),
                    customValidator: (value) => customValidator(
                      value,
                      currentLocale,
                    ),
                  ),
                  CustomTextFieldWithController(
                    controller: fabricDesignController.amountOfToopController,
                    lblText: const LocaleText('toop'),
                    customValidator: (value) => customValidator(
                      value,
                      currentLocale,
                    ),
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
                        fabricDesignController.editFabricDesign(
                            widget.fabricDesignId, widget.fabricPurchaseId);
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
            remainingValue: fabricDesignController.remainingBundle.toString(),
            iconColor: Pallete.blueColor,
            textColor: Pallete.blueColor,
          ),
          RowData(
            icon: Icons.timelapse,
            textKey: 'war',
            remainingValue: fabricDesignController.remainingWar.toString(),
          ),
          // Add more RowData objects as needed
        ],
      ),
    );
  }
}
