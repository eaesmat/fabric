import 'package:fabricproject/controller/all_fabric_purchase_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class AllFabricPurchaseMeterConverter extends StatefulWidget {
  const AllFabricPurchaseMeterConverter({super.key});

  @override
  State<AllFabricPurchaseMeterConverter> createState() =>
      _AllFabricPurchaseMeterConverterState();
}

class _AllFabricPurchaseMeterConverterState
    extends State<AllFabricPurchaseMeterConverter> {
  double yenPriceValue = 0.0;
  double totalYenPriceValue = 0.0;
  double exchangeRateValue = 0.0;
  double dollarPriceValue = 0.0;
  double meterValue = 0.0;
  double ttCommission = 0.0;
  double totalDollarPriceValue = 0.0;
  double varValue = 0.0;

  @override
  Widget build(BuildContext context) {
    final allFabricPurchaseMeterConverter =
        Provider.of<AllFabricPurchaseController>(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _showMeterDollarDialog(context);
                },
                child: CustomTextFieldWithController(
                  isDisabled: true,
                  controller:
                      allFabricPurchaseMeterConverter.dollarPriceController,
                  iconBtn: const Icon(
                    size: 30,
                    Icons.add_box_rounded,
                    color: Pallete.blueColor,
                  ),
                  lblText: const LocaleText('dollar_price'),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _showMeterYenDialog(context);
                },
                child: CustomTextFieldWithController(
                  isDisabled: true,
                  controller:
                      allFabricPurchaseMeterConverter.yenPriceController,
                  iconBtn: const Icon(
                    size: 30,
                    Icons.add_box_rounded,
                    color: Pallete.blueColor,
                  ),
                  lblText: const LocaleText('yen_price'),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextFieldWithController(
                isDisabled: true,
                controller:
                    allFabricPurchaseMeterConverter.amountOfMetersController,
                lblText: const LocaleText('meter'),
              ),
            ),
            Expanded(
              child: CustomTextFieldWithController(
                isDisabled: true,
                controller:
                    allFabricPurchaseMeterConverter.amountOfWarsController,
                lblText: const LocaleText('war'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextFieldWithController(
                isDisabled: true,
                controller:
                    allFabricPurchaseMeterConverter.totalDollarPriceController,
                lblText: const LocaleText('total_dollar_price'),
              ),
            ),
            Expanded(
              child: CustomTextFieldWithController(
                isDisabled: true,
                controller:
                    allFabricPurchaseMeterConverter.totalYenPriceController,
                lblText: const LocaleText('total_yen_price'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextFieldWithController(
                isDisabled: true,
                controller:
                    allFabricPurchaseMeterConverter.exchangeRateController,
                lblText: const LocaleText('exchange_rate'),
              ),
            ),
            Expanded(
              child: CustomTextFieldWithController(
                isDisabled: true,
                controller:
                    allFabricPurchaseMeterConverter.ttCommissionController,
                lblText: const LocaleText('tt_commission'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showMeterDollarDialog(BuildContext context) async {
    double screenHeight = MediaQuery.of(context).size.height;
    double modalHeight = screenHeight * 0.9;
    Locale currentLocale = Localizations.localeOf(context);
    final formKey = GlobalKey<FormState>();
    final allFabricPurchaseController =
        Provider.of<AllFabricPurchaseController>(context, listen: false);
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
                  const LocaleTexts(localeText: 'dollar_price_convertor'),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('meter'),
                    controller:
                        allFabricPurchaseController.amountOfMetersController,
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                    onChanged: (value) {
                      setState(() {
                        meterValue = double.tryParse(value) ?? 0.0;
                        // _calculateDollarValues();
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextFieldWithController(
                    controller:
                        allFabricPurchaseController.dollarPriceController,
                    lblText: const LocaleText('dollar_price'),
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                    onChanged: (value) {
                      setState(() {
                        dollarPriceValue = double.tryParse(value) ?? 0.0;
                        // _calculateDollarValues();
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextFieldWithController(
                    controller:
                        allFabricPurchaseController.ttCommissionController,
                    lblText: const LocaleText('tt_commission'),
                    onChanged: (value) {
                      setState(() {
                        ttCommission = double.tryParse(value) ?? 0.0;
                        // _calculateDollarValues();
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomDropDownButton(
                    bgColor: Pallete.blueColor,
                    btnWidth: 1,
                    btnIcon: const Icon(
                      Icons.check,
                      color: Pallete.whiteColor,
                    ),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        _calculateDollarValues();
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

  Future<void> _showMeterYenDialog(BuildContext context) async {
    double screenHeight = MediaQuery.of(context).size.height;
    double modalHeight = screenHeight * 0.9;
    Locale currentLocale = Localizations.localeOf(context);
    final allFabricPurchaseMeterConverter =
        Provider.of<AllFabricPurchaseController>(context, listen: false);
    final formKey = GlobalKey<FormState>();

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
                  const LocaleTexts(localeText: 'yen_price_convertor'),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldWithController(
                    controller: allFabricPurchaseMeterConverter
                        .amountOfMetersController,
                    lblText: const LocaleText('meter'),
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                    onChanged: (value) {
                      setState(() {
                        meterValue = double.tryParse(value) ?? 0.0;
                        // _calculateDollarValues();
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextFieldWithController(
                    controller:
                        allFabricPurchaseMeterConverter.yenPriceController,
                    lblText: const LocaleText('yen_price'),
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                    onChanged: (value) {
                      setState(() {
                        yenPriceValue = double.tryParse(value) ?? 0.0;
                        // _calculateDollarValues();
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextFieldWithController(
                    controller:
                        allFabricPurchaseMeterConverter.exchangeRateController,
                    lblText: const LocaleText('exchange_rate'),
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                    onChanged: (value) {
                      setState(() {
                        exchangeRateValue = double.tryParse(value) ?? 0.0;
                        // _calculateDollarValues();
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomDropDownButton(
                    bgColor: Pallete.blueColor,
                    btnWidth: 1,
                    btnIcon: const Icon(
                      Icons.check,
                      color: Pallete.whiteColor,
                    ),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        _calculateYenValues();
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

  void _calculateDollarValues() {
    setState(
      () {
        _resetValues();
        meterValue = meterValue;
        ttCommission = ttCommission;
        varValue = (meterValue / 0.914);
        dollarPriceValue = dollarPriceValue;
        totalDollarPriceValue = meterValue * dollarPriceValue;
      },
    );
  }

  void _calculateYenValues() {
    setState(
      () {
        ttCommission = 0;
        meterValue = meterValue;
        yenPriceValue = yenPriceValue;
        exchangeRateValue = exchangeRateValue;
        totalYenPriceValue = meterValue * yenPriceValue;
        totalDollarPriceValue = totalYenPriceValue / exchangeRateValue;
        dollarPriceValue = totalDollarPriceValue / meterValue;
        varValue = (meterValue / 0.914);
      },
    );
  }

  void _postDataToController() {
    final allFabricPurchaseMeterConverter =
        Provider.of<AllFabricPurchaseController>(context, listen: false);
    allFabricPurchaseMeterConverter.amountOfMetersController.text =
        meterValue.toStringAsFixed(2);
    allFabricPurchaseMeterConverter.yenPriceController.text =
        yenPriceValue.toStringAsFixed(2);
    allFabricPurchaseMeterConverter.exchangeRateController.text =
        exchangeRateValue.toStringAsFixed(2);
    allFabricPurchaseMeterConverter.totalYenPriceController.text =
        totalYenPriceValue.toStringAsFixed(2);
    allFabricPurchaseMeterConverter.totalDollarPriceController.text =
        totalDollarPriceValue.toStringAsFixed(2);
    allFabricPurchaseMeterConverter.dollarPriceController.text =
        dollarPriceValue.toStringAsFixed(2);
    allFabricPurchaseMeterConverter.amountOfWarsController.text =
        varValue.toStringAsFixed(2);
    allFabricPurchaseMeterConverter.ttCommissionController.text =
        ttCommission.toStringAsFixed(2);
  }

  void _resetValues() {
    yenPriceValue = 0;
    exchangeRateValue = 0;
    totalYenPriceValue = 0;
    varValue = 0;
  }
}
