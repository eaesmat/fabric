import 'package:fabricproject/controller/colors_controller.dart';
import 'package:fabricproject/controller/fabric_purchase_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/screens/all_fabric_purchase/all_fabric_purchase_company_bottom_sheet.dart';
import 'package:fabricproject/screens/all_fabric_purchase/all_fabric_purchase_fabric_bottom_sheet.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/date_picker.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:fabricproject/widgets/meter_convertor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class ColorCreateScreen extends StatefulWidget {
  const ColorCreateScreen({super.key});

  @override
  State<ColorCreateScreen> createState() =>
      _ColorCreateScreenState();
}

class _ColorCreateScreenState
    extends State<ColorCreateScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // controller provider
    final colorsController =
        Provider.of<ColorsController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'new_purchase'),
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
                    lblText: const LocaleText('color_name'),
                    controller: colorsController.colorNameController,
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('description'),
                    controller: colorsController.descriptionController,
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
                      // Check if the selected company is not empty
                      if (formKey.currentState!.validate()) {
                        colorsController.createColor();
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
