import 'package:fabricproject/controller/vendor_company_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class VendorCompanyCreateScreen extends StatefulWidget {
  const VendorCompanyCreateScreen({super.key,});

  @override
  State<VendorCompanyCreateScreen> createState() => _VendorCompanyCreateScreenState();
}

class _VendorCompanyCreateScreenState extends State<VendorCompanyCreateScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vendorCompanyController = Provider.of<VendorCompanyController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'create_vendor_company'),
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
                    lblText: const LocaleText('name'),
                    controller: vendorCompanyController.nameController,
                    // customValidator: customFormValidator,
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    controller: vendorCompanyController.phoneController,
                    lblText: const LocaleText('phone'),
                    //  customValidator: customFormValidator
                  ),
                  CustomTextFieldWithController(
                    controller: vendorCompanyController.desorptionController,
                    lblText: const LocaleText('description'),
                    // customValidator: customFormValidator,
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
                      if (formKey.currentState!.validate()) {
                        vendorCompanyController.createVendorCompany();
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
