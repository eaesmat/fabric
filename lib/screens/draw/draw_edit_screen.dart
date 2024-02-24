// Import necessary dependencies and files
import 'package:fabricproject/controller/draw_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/draw_model.dart';
import 'package:fabricproject/screens/forex/forex_bottom_sheet.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/date_picker.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

// Define a StatefulWidget for DrawEditScreen
class DrawEditScreen extends StatefulWidget {
  final Data drawData;
  final int drawId;

  // Constructor for DrawEditScreen
  const DrawEditScreen({
    Key? key,
    required this.drawData,
    required this.drawId,
  }) : super(key: key);

  @override
  State<DrawEditScreen> createState() => _DrawEditScreenState();
}

// Define the state for _DrawEditScreenState
class _DrawEditScreenState extends State<DrawEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get the DrawController from the Provider
    final drawController = Provider.of<DrawController>(context);
    // Get the current locale for validation
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'update_draw'),
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
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    controller: drawController.yenPriceController,
                    lblText: const LocaleText('yen_price'),
                  ),
                  CustomTextFieldWithController(
                    controller: drawController.exchangeRateController,
                    lblText: const LocaleText('exchange_rate'),
                  ),
                  CustomTextFieldWithController(
                    controller: drawController.descriptionController,
                    lblText: const LocaleText('description'),
                  ),
                  CustomTextFieldWithController(
                    controller: drawController.bankPhotoController,
                    lblText: const LocaleText('photo'),
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
                        drawController.editDraw(widget.drawId);
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
