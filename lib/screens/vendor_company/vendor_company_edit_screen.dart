import 'package:fabricproject/controller/vendor_company_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/vendor_company_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class VendorCompanyEditScreen extends StatefulWidget {
  // gets this data from controller

  final Data vendorCompanyData;
  final int vendorCompanyId;

  const VendorCompanyEditScreen(
      {super.key,
      required this.vendorCompanyData,
      required this.vendorCompanyId});

  @override
  State<VendorCompanyEditScreen> createState() =>
      _VendorCompanyEditScreenState();
}

class _VendorCompanyEditScreenState extends State<VendorCompanyEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // gets and sends data to the controller using

    final vendorCompanyController =
        Provider.of<VendorCompanyController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'update_vendor_company'),
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
                    // This comes from helper method to validate the field
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    controller: vendorCompanyController.phoneController,
                    lblText: const LocaleText('phone'),
                  ),
                  CustomTextFieldWithController(
                    controller: vendorCompanyController.descriptionController,
                    lblText: const LocaleText('description'),
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
                        // if form is validate will be edited

                        vendorCompanyController
                            // passes the id to the controller to all edit method

                            .editVendorCompany(widget.vendorCompanyId);
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
