import 'package:fabricproject/controller/sarai_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/sarai_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class SaraiEditScreen extends StatefulWidget {
  final Data saraiData;
  final int saraiId;

  const SaraiEditScreen(
      {super.key, required this.saraiData, required this.saraiId});

  @override
  State<SaraiEditScreen> createState() => _SaraiEditScreenState();
}

class _SaraiEditScreenState extends State<SaraiEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final saraiController = Provider.of<SaraiController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
        appBar: AppBar(
          title: const LocaleTexts(localeText: 'update_sarai'),
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
                      lblText: const LocaleText('full_name'),
                      controller: saraiController.nameController,
                      // customValidator: customFormValidator,
                      customValidator: (value) =>
                          customValidator(value, currentLocale),
                    ),
                    CustomTextFieldWithController(
                      controller: saraiController.descriptionController,
                      lblText: const LocaleText('description'),
                      //  customValidator: customFormValidator
                    ),
                    CustomTextFieldWithController(
                      controller: saraiController.phoneController,
                      lblText: const LocaleText('phone'),
                      // customValidator: customFormValidator,
                    ),
                  
                    CustomTextFieldWithController(
                      controller: saraiController.locationController,
                      lblText: const LocaleText('location'),
                      // customValidator: customFormValidator,
                    ),
                    CustomButton(
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
                          saraiController.editSarai(widget.saraiId);
                        Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
