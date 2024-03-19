import 'package:fabricproject/constants/screen_type_constants.dart';
import 'package:fabricproject/controller/khalid_gereft_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/bottom_sheets/forex_bottom_sheet.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/date_picker.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class KhalidGereftCreateScreen extends StatefulWidget {
  const KhalidGereftCreateScreen({super.key});

  @override
  State<KhalidGereftCreateScreen> createState() =>
      _KhalidGereftCreateScreenState();
}

class _KhalidGereftCreateScreenState extends State<KhalidGereftCreateScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final khalidGereftController = Provider.of<KhalidGereftController>(context);

    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'withdrawal'),
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
                    lblText: const LocaleText('dollar_price'),
                    controller: khalidGereftController.dollarPriceController,
                    // customValidator: customFormValidator,
                    customValidator: (value) =>
                        customValidatorCheckNumberOnly(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('description'),
                    controller: khalidGereftController.descriptionController,
                  ),
                  DatePicker(
                    controller: khalidGereftController.dateController,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const ForexBottomSheet(
                            screenName: ScreenTypeConstants.khalidGereftScreen,
                          );
                        },
                      );
                    },
                    child: CustomTextFieldWithController(
                      
                      isDisabled: true,
                      controller:
                          khalidGereftController.selectedForexNameController,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('forex'),
                    ),
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
                        khalidGereftController.createKhalidGereft();
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
