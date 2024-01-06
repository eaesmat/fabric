import 'package:fabricproject/controller/all_draw_controller.dart';
import 'package:fabricproject/controller/draw_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/draw_model.dart';
import 'package:fabricproject/screens/forex/forex_bottom_sheet.dart';
import 'package:fabricproject/screens/vendor_company/vendor_company_bottom_sheet.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_button.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/date_picker.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class AllDrawEditScreen extends StatefulWidget {
  final Data drawData;
  final int drawId;
  const AllDrawEditScreen(
      {super.key, required this.drawData, required this.drawId});

  @override
  State<AllDrawEditScreen> createState() => _AllDrawEditScreenState();
}

class _AllDrawEditScreenState extends State<AllDrawEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final allDrawController = Provider.of<AllDrawController>(context);
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
                    controller: allDrawController.dollarPriceController,
                    // customValidator: customFormValidator,
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    controller: allDrawController.yenPriceController,
                    lblText: const LocaleText('yen_price'),
                    //  customValidator: customFormValidator
                  ),
                  CustomTextFieldWithController(
                    controller: allDrawController.exchangeRateController,
                    lblText: const LocaleText('exchange_rate'),
                    // customValidator: customFormValidator,
                  ),
                  CustomTextFieldWithController(
                    controller: allDrawController.descriptionController,
                    lblText: const LocaleText('description'),
                    // customValidator: customFormValidator,
                  ),
                  CustomTextFieldWithController(
                    controller: allDrawController.bankPhotoController,
                    lblText: const LocaleText('photo'),
                    // customValidator: customFormValidator,
                  ),
                  DatePicker(
                    controller: allDrawController.dateController,
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
                      controller: allDrawController.selectedForexController,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('forex'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const VendorCompanyBottomSheet();
                        },
                      );
                    },
                    child: CustomTextFieldWithController(
                      customValidator: (value) =>
                          customValidator(value, currentLocale),
                      isDisabled: true,
                      controller:
                          allDrawController.selectedVendorCompanyNameController,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('vendor_companies'),
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
                        allDrawController.editDraw(widget.drawId);
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
