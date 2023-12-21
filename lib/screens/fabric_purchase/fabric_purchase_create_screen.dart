import 'package:fabricproject/controller/fabric_purchase_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/screens/company/company_bottom_sheet.dart';
import 'package:fabricproject/screens/fabric/fabric_bottom_sheet.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/date_picker.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:fabricproject/widgets/meter_convertor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class FabricPurchaseCreateScreen extends StatefulWidget {
  const FabricPurchaseCreateScreen({super.key});

  @override
  State<FabricPurchaseCreateScreen> createState() =>
      _FabricPurchaseCreateScreenState();
}

class _FabricPurchaseCreateScreenState
    extends State<FabricPurchaseCreateScreen> {
  final formKey = GlobalKey<FormState>();
  late String buttonText;
  TextEditingController companyName = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   buttonText = "";
  // }

  // void updateButtonText(String value) {
  //   setState(() {
  //     buttonText = value;
  //     companyName.text = value;
  //   });
  //   // widget.onItemSelected(value); // Add this line to notify the parent widget
  // }

  @override
  Widget build(BuildContext context) {
    final fabricPurchaseController =
        Provider.of<FabricPurchaseController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'new_purchase'),
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
                      controller: fabricPurchaseController.selectedCompany,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('companies'),
                    ),
                  ),
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
                      controller: fabricPurchaseController.selectedFabric,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('fabrics'),
                    ),
                  ),
                  CustomTextFieldWithController(
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
                          lblText: const LocaleText('fabric_code'),
                          controller:
                              fabricPurchaseController.fabricCodeController,
                        ),
                      ),
                    ],
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('bank_received_photo'),
                    controller:
                        fabricPurchaseController.bankReceivedPhotoController,
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('package_photo'),
                    controller: fabricPurchaseController.packagePhotoController,
                  ),
                  CustomButton(
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
                      // Check if the selected company is not empty
                      if (formKey.currentState!.validate()) {
                        fabricPurchaseController.createFabricPurchase();
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
