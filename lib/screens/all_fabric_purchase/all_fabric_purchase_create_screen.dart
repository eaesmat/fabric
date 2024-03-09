import 'package:fabricproject/bottom_sheets/vendor_company_bottom_sheet.dart';
import 'package:fabricproject/constants/screen_type_constants.dart';
import 'package:fabricproject/controller/all_fabric_purchases_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/screens/all_fabric_purchase/all_fabric_purchase_meter_convertor.dart';
import 'package:fabricproject/screens/all_fabric_purchase/all_fabric_purchase_company_bottom_sheet.dart';
import 'package:fabricproject/screens/all_fabric_purchase/all_fabric_purchase_fabric_bottom_sheet.dart';
import 'package:fabricproject/screens/all_fabric_purchase/all_fabric_purchase_transport_bottom_sheet.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/date_picker.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class AllFabricPurchaseCreateScreen extends StatefulWidget {
  const AllFabricPurchaseCreateScreen({super.key});

  @override
  State<AllFabricPurchaseCreateScreen> createState() =>
      _AllFabricPurchaseCreateScreenState();
}

class _AllFabricPurchaseCreateScreenState
    extends State<AllFabricPurchaseCreateScreen> {
  // @override
  // void dispose() {
  //   final allFabricPurchasesController =
  //       Provider.of<AllFabricPurchasesController>(context, listen: false);
  //   allFabricPurchasesController.dispose(); // Dispose controllers here
  //   super.dispose();
  // }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final allFabricPurchasesController =
        Provider.of<AllFabricPurchasesController>(context);
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
                          return const VendorCompanyBottomSheet(
                            screenType:
                                ScreenTypeConstants.allFabricPurchasesScreen,
                          );
                        },
                      );
                    },
                    child: CustomTextFieldWithController(
                      customValidator: (value) =>
                          customValidator(value, currentLocale),
                      isDisabled: true,
                      controller: allFabricPurchasesController
                          .selectedVendorCompanyName,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('vendor_companies'),
                    ),
                  ),
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
                      controller: allFabricPurchasesController
                          .selectedCompanyNameController,
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
                      controller: allFabricPurchasesController
                          .selectedFabricNameController,
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
                        allFabricPurchasesController.amountOfBundlesController,
                  ),
                  const AllFabricPurchaseMeterConverter(),
                  Row(
                    children: [
                      Expanded(
                        child: DatePicker(
                          controller:
                              allFabricPurchasesController.dateController,
                        ),
                      ),
                      Expanded(
                        child: CustomTextFieldWithController(
                          customValidator: (value) =>
                              customValidator(value, currentLocale),
                          lblText: const LocaleText('fabric_code'),
                          controller:
                              allFabricPurchasesController.fabricCodeController,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const TransportBottomSheet();
                        },
                      );
                    },
                    child: CustomTextFieldWithController(
                      customValidator: (value) =>
                          customValidator(value, currentLocale),
                      isDisabled: true,
                      controller:
                          allFabricPurchasesController.selectedTransportName,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('transports'),
                    ),
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('bank_receipt_photo'),
                    controller: allFabricPurchasesController
                        .bankReceivedPhotoController,
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('package_photo'),
                    controller:
                        allFabricPurchasesController.packagePhotoController,
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
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        allFabricPurchasesController.createFabricPurchase();

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
