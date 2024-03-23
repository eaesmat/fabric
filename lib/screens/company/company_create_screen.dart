import 'package:fabricproject/controller/company_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CompanyCreateScreen extends StatefulWidget {
  const CompanyCreateScreen({super.key});

  @override
  State<CompanyCreateScreen> createState() => _CompanyCreateScreenState();
}

class _CompanyCreateScreenState extends State<CompanyCreateScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // controller provider instance
    final companyController = Provider.of<CompanyController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'create_company'),
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
                    controller: companyController.nameController,
                    // comes from helper validates the field
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    controller: companyController.markaController,
                    lblText: const LocaleText('marka'),
                  ),
                  CustomTextFieldWithController(
                    controller: companyController.descriptionController,
                    lblText: const LocaleText('description'),
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
                      // validates the form to create the new item
                      if (formKey.currentState!.validate()) {
                        companyController.createCompany();
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
