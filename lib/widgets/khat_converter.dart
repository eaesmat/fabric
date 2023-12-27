import 'package:flutter/material.dart';
import 'package:fabricproject/controller/transport_deal_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class KhatConverterDialog extends StatefulWidget {
  const KhatConverterDialog({Key? key}) : super(key: key);

  @override
  _KhatConverterDialogState createState() => _KhatConverterDialogState();
}

class _KhatConverterDialogState extends State<KhatConverterDialog> {
  double totalCost = 0.0;
  double costPerKhat = 0.0;
  double amountOfKhat = 0.0;
  double war = 0.0;
  double costPerWar = 0.0;

  @override
  Widget build(BuildContext context) {
    final transportDealController =
        Provider.of<TransportDealController>(context);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _showKhatConverterDialog(context);
                },
                child: CustomTextFieldWithController(
                  isDisabled: true,
                  controller: transportDealController.singleKhatPriceController,
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
                isDisabled: true,
                controller: transportDealController.amountOfKhatController,
                lblText: const LocaleText('khat_amount'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextFieldWithController(
                isDisabled: true,
                controller: transportDealController.totalCostController,
                lblText: const LocaleText('total_cost'),
              ),
            ),
            Expanded(
              child: CustomTextFieldWithController(
                isDisabled: true,
                controller: transportDealController.warPriceController,
                lblText: const LocaleText('war_cost'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showKhatConverterDialog(BuildContext context) async {
    double screenHeight = MediaQuery.of(context).size.height;
    double modalHeight = screenHeight * 0.9;
    final formKey = GlobalKey<FormState>();
    final transportDealController =
        Provider.of<TransportDealController>(context, listen: false);

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
                        transportDealController.singleKhatPriceController,
                    onChanged: (value) {
                      setState(() {
                        costPerKhat = double.tryParse(value) ?? 0.0;
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextFieldWithController(
                    controller: transportDealController.amountOfKhatController,
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
    final transportDealController =
        Provider.of<TransportDealController>(context, listen: false);

    war = double.parse(transportDealController.warPriceFromUIController.text);
    print(war);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        transportDealController.warPriceController.text =
            (totalCost / war).toStringAsFixed(2);
        transportDealController.amountOfKhatController.text =
            amountOfKhat.toStringAsFixed(2);
        transportDealController.singleKhatPriceController.text =
            costPerKhat.toStringAsFixed(2);
        transportDealController.totalCostController.text =
            totalCost.toStringAsFixed(2);
      });
    });
  }
}
