import 'package:fabricproject/controller/transport_deals_controller.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/screens/fabric_purchase/fabric_purchase_button_sheet.dart';
import 'package:fabricproject/screens/transport_deals/select_sarai_bottom_sheet.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/date_picker.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class TransportDealsCreateScreen extends StatefulWidget {
  final int curTransportId;
  const TransportDealsCreateScreen({super.key, required this.curTransportId});

  @override
  State<TransportDealsCreateScreen> createState() =>
      _TransportDealsCreateScreenState();
}

class _TransportDealsCreateScreenState
    extends State<TransportDealsCreateScreen> {
  final HelperServices helper = HelperServices.instance;

  final formKey = GlobalKey<FormState>();

  double totalCost = 0.0;
  double costPerKhat = 0.0;
  double amountOfKhat = 0.0;
  double war = 0.0;
  double costPerWar = 0.0;

  @override
  Widget build(BuildContext context) {
    // controller provider instance
    final transportDealsController =
        Provider.of<TransportDealsController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'create_transport_deal'),
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
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return const FabricPurchasesButtonSheet();
                              },
                            );
                          },
                          child: CustomTextFieldWithController(
                            customValidator: (value) =>
                                customValidator(value, currentLocale),
                            isDisabled: true,
                            controller: transportDealsController
                                .selectedFabricPurchaseCodeController,
                            iconBtn: const Icon(
                              size: 30,
                              Icons.add_box_rounded,
                              color: Pallete.blueColor,
                            ),
                            lblText: const LocaleText('fabric'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomTextFieldWithController(
                          isDisabled: true,
                          controller: transportDealsController
                              .selectedFabricPurchaseNameController,
                          lblText: const LocaleText('item_name'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFieldWithController(
                          customValidator: (value) =>
                              customValidator(value, currentLocale),
                          controller: transportDealsController
                              .amountOfBundlesController,
                          lblText: const LocaleText('bundle'),
                        ),
                      ),
                      Expanded(
                        child: CustomTextFieldWithController(
                          customValidator: (value) =>
                              customValidator(value, currentLocale),
                          controller:
                              transportDealsController.containerNameController,
                          lblText: const LocaleText('container_name'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _showKhatConverterDialog(context);
                          },
                          child: CustomTextFieldWithController(
                            customValidator: (value) =>
                                customValidator(value, currentLocale),
                            isDisabled: true,
                            controller: transportDealsController
                                .singleKhatPriceController,
                            iconBtn: const Icon(
                              size: 30,
                              Icons.add_box_rounded,
                              color: Pallete.blueColor,
                            ),
                            lblText: const LocaleText('khat_cost'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomTextFieldWithController(
                          customValidator: (value) =>
                              customValidator(value, currentLocale),
                          isDisabled: true,
                          controller:
                              transportDealsController.amountOfKhatController,
                          lblText: const LocaleText('khat_amount'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFieldWithController(
                          customValidator: (value) =>
                              customValidator(value, currentLocale),
                          isDisabled: true,
                          controller:
                              transportDealsController.totalCostController,
                          lblText: const LocaleText('total_cost'),
                        ),
                      ),
                      Expanded(
                        child: CustomTextFieldWithController(
                          customValidator: (value) =>
                              customValidator(value, currentLocale),
                          isDisabled: true,
                          controller:
                              transportDealsController.warPriceController,
                          lblText: const LocaleText('war_cost'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return const SelectSaraiBottomSheet();
                              },
                            );
                          },
                          child: CustomTextFieldWithController(
                            customValidator: (value) =>
                                customValidator(value, currentLocale),
                            isDisabled: true,
                            controller: transportDealsController
                                .selectedSaraiNameController,
                            iconBtn: const Icon(
                              size: 30,
                              Icons.add_box_rounded,
                              color: Pallete.blueColor,
                            ),
                            lblText: const LocaleText('sarai'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: DatePicker(
                          controller:
                              transportDealsController.startDateController,
                        ),
                      ),
                    ],
                  ),
                  CustomTextFieldWithController(
                    controller: transportDealsController.photoController,
                    lblText: const LocaleText('photo'),
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
                        transportDealsController
                            .createTransportDeals(widget.curTransportId);
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

  Future<void> _showKhatConverterDialog(BuildContext context) async {
    double screenHeight = MediaQuery.of(context).size.height;
    double modalHeight = screenHeight * 0.9;
    final formKey = GlobalKey<FormState>();
    final transportDealsController =
        Provider.of<TransportDealsController>(context, listen: false);

    _calculateKhatValues(); // Calculate values before showing dialog

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Container(
            color: Pallete.whiteColor,
            height: modalHeight,
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const LocaleTexts(
                    localeText: 'khat_converter',
                  ),
                  const SizedBox(height: 20),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('khat_cost'),
                    controller:
                        transportDealsController.singleKhatPriceController,
                    onChanged: (value) {
                      setState(() {
                        costPerKhat = double.tryParse(value) ?? 0.0;
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextFieldWithController(
                    controller: transportDealsController.amountOfKhatController,
                    lblText: const LocaleText('khat_amount'),
                    onChanged: (value) {
                      setState(() {
                        amountOfKhat = double.tryParse(value) ?? 0.0;
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  CustomDropDownButton(
                    bgColor: Pallete.blueColor,
                    btnWidth: 1,
                    btnIcon: const Icon(
                      Icons.check,
                      color: Pallete.whiteColor,
                    ),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        _calculateKhatValues();
                        _postDataToController();
                        Navigator.pop(context);
                      }
                    },
                    btnText: const LocaleText(
                      'create',
                      style: TextStyle(color: Pallete.whiteColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _calculateKhatValues() {
    totalCost = amountOfKhat * costPerKhat;
  }

  void _postDataToController() {
    final transportDealsController =
        Provider.of<TransportDealsController>(context, listen: false);

    double? parsedWar =
        double.tryParse(transportDealsController.warPriceFromUIController.text);

    if (parsedWar != null && parsedWar != 0) {
      war = parsedWar;
      totalCost = amountOfKhat * costPerKhat;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          transportDealsController.warPriceController.text =
              (totalCost / war).toStringAsFixed(2);
          transportDealsController.amountOfKhatController.text =
              amountOfKhat.toStringAsFixed(2);
          transportDealsController.singleKhatPriceController.text =
              costPerKhat.toStringAsFixed(2);
          transportDealsController.totalCostController.text =
              totalCost.toStringAsFixed(2);
        });
      });
    } else {
      helper.showMessage(
        const LocaleText('no_bundle_is_selected'),
        Colors.deepOrange,
        const Icon(
          Icons.warning,
          color: Pallete.whiteColor,
        ),
      );
    }
  }
}
