import 'package:fabricproject/screens/all_fabric_purchase/all_fabric_purchase_fabric_bottom_sheet.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

import 'package:fabricproject/controller/fabric_purchase_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/fabric_purchase_model.dart';
import 'package:fabricproject/screens/all_fabric_purchase/all_fabric_purchase_company_bottom_sheet.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:fabricproject/widgets/meter_convertor.dart';

class FabricPurchaseEditScreen extends StatefulWidget {
  // gets the data from the controller
  final Data fabricPurchaseData;
  final int fabricPurchaseId;
  const FabricPurchaseEditScreen({
    Key? key,
    required this.fabricPurchaseData,
    required this.fabricPurchaseId,
  }) : super(key: key);

  @override
  State<FabricPurchaseEditScreen> createState() =>
      _FabricPurchaseEditScreenState();
}

class _FabricPurchaseEditScreenState extends State<FabricPurchaseEditScreen> {
  final formKey = GlobalKey<FormState>();
  late String buttonText;

  @override
  Widget build(BuildContext context) {
    // controller provider
    final fabricPurchaseController =
        Provider.of<FabricPurchaseController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'update_fabric_purchase'),
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
                  // show company bottom sheet to select the company
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const CompanyBottomSheet();
                        },
                      );
                    },
                    child: CustomTextFieldWithController(
                      customValidator: (value) =>
                          customValidator(value, currentLocale),
                      isDisabled: true,
                      controller: fabricPurchaseController.selectedCompanyNameController,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('companies'),
                    ),
                  ),
                  // show fabric bottom sheet to select the companies
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const FabricBottomSheet();
                        },
                      );
                    },
                    child: CustomTextFieldWithController(
                      customValidator: (value) =>
                          customValidator(value, currentLocale),
                      isDisabled: true,
                      controller:
                          fabricPurchaseController.selectedFabricNameController,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('fabrics'),
                    ),
                  ),
                  CustomTextFieldWithController(
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                    lblText: const LocaleText('bundle'),
                    controller:
                        fabricPurchaseController.amountOfBundlesController,
                  ),
                  const MeterConvertor(),
                  Row(
                    children: [
                      Expanded(
                        child: DatePicker(
                          controller: fabricPurchaseController.dateController,
                        ),
                      ),
                      Expanded(
                        child: CustomTextFieldWithController(
                          customValidator: (value) =>
                              customValidator(value, currentLocale),
                          lblText: const LocaleText('fabric_code'),
                          controller:
                              fabricPurchaseController.fabricCodeController,
                        ),
                      ),
                    ],
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('bank_receipt_photo'),
                    controller:
                        fabricPurchaseController.bankReceivedPhotoController,
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('package_photo'),
                    controller: fabricPurchaseController.packagePhotoController,
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
                      // Check if the selected company is not empty
                      if (formKey.currentState!.validate()) {
                        fabricPurchaseController
                            .editFabricPurchase(widget.fabricPurchaseId);
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
    );
  }
}
