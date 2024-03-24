import 'package:fabricproject/constants/screen_type_constants.dart';
import 'package:fabricproject/controller/khalid_rasid_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/bottom_sheets/forex_bottom_sheet.dart';
import 'package:fabricproject/model/khalid_rasid_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/date_picker.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class VendorCompanyRasidEditScreen extends StatefulWidget {
  final Data data;
  final int khalidRasidId;
  const VendorCompanyRasidEditScreen({
    super.key,
    required this.data,
    required this.khalidRasidId,
  });

  @override
  State<VendorCompanyRasidEditScreen> createState() =>
      _VendorCompanyRasidEditScreenState();
}

class _VendorCompanyRasidEditScreenState
    extends State<VendorCompanyRasidEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final khalidRasidController = Provider.of<KhalidRasidController>(context);

    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'receipts'),
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
                    lblText: const LocaleText('yen_price'),
                    controller: khalidRasidController.yenPriceController,
                    // customValidator: customFormValidator,
                    customValidator: (value) =>
                        customValidatorCheckNumberOnly(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('exchange_rate'),
                    controller: khalidRasidController.exchangeRateController,
                    // customValidator: customFormValidator,
                    customValidator: (value) =>
                        customValidatorCheckNumberOnly(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('dollar_price'),
                    controller: khalidRasidController.dollarPriceController,
                    // customValidator: customFormValidator,
                    customValidator: (value) =>
                        customValidatorCheckNumberOnly(value, currentLocale),
                  ),
                  DatePicker(
                    controller: khalidRasidController.dateController,
                  ),
                  GestureDetector(
                    child: CustomTextFieldWithController(
                      customValidator: (value) =>
                          customValidator(value, currentLocale),
                      isDisabled: true,
                      controller:
                          khalidRasidController.selectedVendorCompanyName,
                      lblText: const LocaleText('vendor_companies'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const ForexBottomSheet(
                            screenName: ScreenTypeConstants.khalidRasidScreen,
                          );
                        },
                      );
                    },
                    child: CustomTextFieldWithController(
                      customValidator: (value) =>
                          customValidator(value, currentLocale),
                      isDisabled: true,
                      controller:
                          khalidRasidController.selectedForexNameController,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('forex'),
                    ),
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('photo'),
                    controller: khalidRasidController.bankPhotoController,
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
                        khalidRasidController
                            .editKhalidRasid(widget.khalidRasidId);
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
