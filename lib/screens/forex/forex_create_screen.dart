import 'package:fabricproject/controller/forex_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class ForexCreateScreen extends StatefulWidget {
  const ForexCreateScreen({super.key});

  @override
  State<ForexCreateScreen> createState() => _ForexCreateScreenState();
}

class _ForexCreateScreenState extends State<ForexCreateScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // controller provider
    final forexController = Provider.of<ForexController>(context);
    // current language of context it will be passed to the validator method
    // to show the message according to.
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'create_forex'),
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
                    // controller gets data from forex controller
                    controller: forexController.fullNameController,
                    // this method validates the textfield
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    controller: forexController.descriptionController,
                    lblText: const LocaleText('description'),
                  ),
                  CustomTextFieldWithController(
                    controller: forexController.phoneController,
                    lblText: const LocaleText('phone'),
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextFieldWithController(
                    controller: forexController.shopNoController,
                    lblText: const LocaleText('shop_no'),
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextFieldWithController(
                    controller: forexController.locationController,
                    lblText: const LocaleText('location'),
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
                      // check if the form is validated
                      if (formKey.currentState!.validate()) {
                        // calls the controller create method to create new
                        forexController.createForex();
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
