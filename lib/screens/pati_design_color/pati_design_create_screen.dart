import 'package:fabricproject/controller/draw_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/screens/forex/forex_bottom_sheet.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/date_picker.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class PatiDesignColorCreateScreen extends StatefulWidget {
  const PatiDesignColorCreateScreen({super.key});

  @override
  State<PatiDesignColorCreateScreen> createState() => _PatiDesignColorCreateScreenState();
}

class _PatiDesignColorCreateScreenState extends State<PatiDesignColorCreateScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final drawController = Provider.of<DrawController>(context);

    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'create_draw'),
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
                    controller: drawController.dollarPriceController,
                    // customValidator: customFormValidator,
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    controller: drawController.yenPriceController,
                    lblText: const LocaleText('yen_price'),
                    //  customValidator: customFormValidator
                  ),
                  CustomTextFieldWithController(
                    controller: drawController.exchangeRateController,
                    lblText: const LocaleText('exchange_rate'),
                    // customValidator: customFormValidator,
                  ),
                  CustomTextFieldWithController(
                    controller: drawController.descriptionController,
                    lblText: const LocaleText('description'),
                    // customValidator: customFormValidator,
                  ),
                  CustomTextFieldWithController(
                    controller: drawController.bankPhotoController,
                    lblText: const LocaleText('photo'),
                    // customValidator: customFormValidator,
                  ),
                  DatePicker(
                    controller: drawController.dateController,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const ForexBottomSheet();
                        },
                      );
                    },
                    child: CustomTextFieldWithController(
                      customValidator: (value) =>
                          customValidator(value, currentLocale),
                      isDisabled: true,
                      controller: drawController.selectedForexController,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('forex'),
                    ),
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
                        drawController.createDraw();
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
