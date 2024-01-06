import 'package:fabricproject/controller/all_fabric_purchase_controller.dart';
import 'package:fabricproject/controller/transport_deal_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/screens/all_fabric_purchase/all_fabric_purchase_meter_convertor.dart';
import 'package:fabricproject/screens/company/company_bottom_sheet.dart';
import 'package:fabricproject/screens/fabric/fabric_bottom_sheet.dart';
import 'package:fabricproject/screens/transport/transport_bottom_sheet.dart';
import 'package:fabricproject/screens/vendor_company/vendor_company_bottom_sheet.dart';
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
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // controller provider
    final allFabricPurchaseController =
        Provider.of<AllFabricPurchaseController>(context);
    final transportDealController =
        Provider.of<TransportDealController>(context);
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
                          return const VendorCompanyBottomSheet();
                        },
                      );
                    },
                    child: CustomTextFieldWithController(
                      customValidator: (value) =>
                          customValidator(value, currentLocale),
                      isDisabled: true,
                      controller:
                          allFabricPurchaseController.selectedVendorCompanyName,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('vendor_companies'),
                    ),
                  ),

                  // company bottom sheet to select the company
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
                      controller: allFabricPurchaseController
                          .selectedCompanyNameController,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('companies'),
                    ),
                  ),
                  // fabric bottom sheet to select the fabrics
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
                      controller: allFabricPurchaseController
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
                        allFabricPurchaseController.amountOfBundlesController,
                  ),
                  const AllFabricPurchaseMeterConverter(),
                  Row(
                    children: [
                      Expanded(
                        child: DatePicker(
                          controller:
                              allFabricPurchaseController.dateController,
                        ),
                      ),
                      Expanded(
                        child: CustomTextFieldWithController(
                          customValidator: (value) =>
                              customValidator(value, currentLocale),
                          lblText: const LocaleText('fabric_code'),
                          controller:
                              allFabricPurchaseController.fabricCodeController,
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
                          allFabricPurchaseController.selectedTransportName,
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
                    controller:
                        allFabricPurchaseController.bankReceivedPhotoController,
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('package_photo'),
                    controller:
                        allFabricPurchaseController.packagePhotoController,
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
                      // Check if the selected company is not empty
                      if (formKey.currentState!.validate()) {
                        // Inside the method where the transport deal is created
                        // Inside the method where the transport deal is created
                        await allFabricPurchaseController
                            .createFabricPurchase();
                        Navigator.pop(context);
// Fetch updated transport deals immediately after creation
                        await allFabricPurchaseController
                            .getAllFabricPurchases();

                        if (allFabricPurchaseController.isAdded) {
                          // print(allFabricPurchaseController
                          //     .selectedTransportId.text);
                          // print(allFabricPurchaseController
                          //     .selectedTransportName.text);
                          int? lastFabricPurchaseId =
                              allFabricPurchaseController
                                  .getLastFabricPurchaseId();
                          // print(lastTransportDealId);
                          String selectedTransportId =
                              allFabricPurchaseController
                                  .selectedTransportId.text;
                          int? transportId = int.tryParse(selectedTransportId);

                          if (lastFabricPurchaseId != null) {
                            // assign container name to the container controller
                            transportDealController
                                .selectedFabricPurchaseIdController
                                .text = lastFabricPurchaseId.toString();

                            transportDealController.transportId = transportId;
                            await transportDealController.createTransportDeal();
                          }
                        }
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
