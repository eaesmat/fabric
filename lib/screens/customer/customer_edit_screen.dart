import 'package:fabricproject/controller/customer_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/customer_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CustomerEditScreen extends StatefulWidget {
  final Data customerData;
  final int customerId;

  const CustomerEditScreen(
      {super.key, required this.customerData, required this.customerId});

  @override
  State<CustomerEditScreen> createState() => _CustomerEditScreenState();
}

class _CustomerEditScreenState extends State<CustomerEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final customerController = Provider.of<CustomerController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'update_customer'),
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
                    lblText: const LocaleText('first_name'),
                    controller: customerController.firstNameController,
                    // comes from helper validates the field
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    controller: customerController.lastNameController,
                    lblText: const LocaleText('last_name'),
                  ),
                  CustomTextFieldWithController(
                    controller: customerController.brunchController,
                    lblText: const LocaleText('branch'),
                  ),
                  CustomTextFieldWithController(
                    controller: customerController.provinceController,
                    lblText: const LocaleText('province'),
                  ),
                  CustomTextFieldWithController(
                    controller: customerController.phoneController,
                    lblText: const LocaleText('phone'),
                  ),
                  CustomTextFieldWithController(
                    controller: customerController.addressController,
                    lblText: const LocaleText('address'),
                  ),
                  CustomTextFieldWithController(
                    controller: customerController.photoController,
                    lblText: const LocaleText('photo'),
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
                        customerController.editCustomer(widget.customerId);
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
