import 'package:flutter/material.dart';
import 'package:fabricproject/controller/customer_rasidat_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CustomerRasidatCreateScreen extends StatefulWidget {
  final int customerId;
  const CustomerRasidatCreateScreen({
    Key? key,
    required this.customerId,
  }) : super(key: key);

  @override
  State<CustomerRasidatCreateScreen> createState() =>
      _CustomerRasidatCreateScreenState();
}

class _CustomerRasidatCreateScreenState
    extends State<CustomerRasidatCreateScreen> {
  final formKey = GlobalKey<FormState>();
  String? _selectedAmountType = "دالر";

  @override
  Widget build(BuildContext context) {
    // controller provider instance
    Locale currentLocale = Localizations.localeOf(context);

    final customerRasidatController =
        Provider.of<CustomerRasidatController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'create_receipt'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFieldWithController(
                  customValidator: (value) =>
                      customValidatorCheckNumberOnly(value, currentLocale),
                  controller: customerRasidatController.amountController,
                  lblText: const LocaleText('amount'),
                ),
                CustomTextFieldWithController(
                  lblText: const LocaleText('by_person'),
                  controller: customerRasidatController.byPersonController,
                ),
                CustomTextFieldWithController(
                  controller: customerRasidatController.descriptionController,
                  lblText: const LocaleText('description'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const LocaleText('dollar'),
                        value: 'دالر',
                        groupValue: _selectedAmountType,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedAmountType = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const LocaleText('afghani'),
                        value: 'افغانی',
                        groupValue: _selectedAmountType,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedAmountType = value;
                          });
                        },
                      ),
                    ),
                  ],
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
                       customerRasidatController.amountTypeController =
                              _selectedAmountType.toString();
                      customerRasidatController
                          .createCustomerRasidat(widget.customerId);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
