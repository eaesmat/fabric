import 'package:fabricproject/controller/all_draw_controller.dart';
import 'package:fabricproject/controller/draw_controller.dart';
import 'package:fabricproject/controller/khalid_draw_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/draw_model.dart';
import 'package:fabricproject/screens/forex/forex_bottom_sheet.dart';
import 'package:fabricproject/screens/vendor_company/vendor_company_bottom_sheet.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/date_picker.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class KhalidDrawEditScreen extends StatefulWidget {
  final Data drawData;
  final int drawId;
  const KhalidDrawEditScreen(
      {super.key, required this.drawData, required this.drawId});

  @override
  State<KhalidDrawEditScreen> createState() => _KhalidDrawEditScreenState();
}

class _KhalidDrawEditScreenState extends State<KhalidDrawEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final khalidDrawController = Provider.of<KhalidDrawController>(context);
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
                    controller: khalidDrawController.dollarPriceController,
                    // customValidator: customFormValidator,
                  ),
                  CustomTextFieldWithController(
                    controller: khalidDrawController.descriptionController,
                    lblText: const LocaleText('description'),
                    // customValidator: customFormValidator,
                  ),
                  DatePicker(
                    controller: khalidDrawController.dateController,
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
                     
                      isDisabled: true,
                      controller: khalidDrawController.selectedForexController,
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
                        khalidDrawController.editDraw(widget.drawId);
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
