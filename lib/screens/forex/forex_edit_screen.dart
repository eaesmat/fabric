import 'package:fabricproject/controller/forex_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/forex_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class ForexEditScreen extends StatefulWidget {
  // gets this data from controller using constructor
  final Data forexData;
  final int forexId;

  const ForexEditScreen(
      {super.key, required this.forexData, required this.forexId});

  @override
  State<ForexEditScreen> createState() => _ForexEditScreenState();
}

class _ForexEditScreenState extends State<ForexEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // controller provider
    final forexController =
        Provider.of<ForexController>(context);
    // current language of context it will be passed to the validator method
    // to show the message according to.
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
        appBar: AppBar(
          title: const LocaleTexts(localeText: 'update_forex'),
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
                      controller: forexController.fullNameController,
                      // this methods comes from helper methods file to to validate the textfield
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
                        'update',
                        style: TextStyle(color: Pallete.whiteColor),
                      ),
                      bgColor: Pallete.blueColor,
                      onTap: () {
                        // if form is validate will be submitted
                        if (formKey.currentState!.validate()) {
                          // passes the id to the controller to edit the item
                          forexController.editForex(widget.forexId);
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
