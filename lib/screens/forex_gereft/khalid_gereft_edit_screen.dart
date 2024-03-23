import 'package:fabricproject/controller/forex_gereft_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/forex_gereft_model.dart';
import 'package:fabricproject/screens/forex_gereft/user_button_sheet.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/date_picker.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class ForexGereftEditScreen extends StatefulWidget {
  final Data data;
  final int gereftId;
  const ForexGereftEditScreen(
      {super.key, required this.data, required this.gereftId});

  @override
  State<ForexGereftEditScreen> createState() => _ForexGereftEditScreenState();
}

class _ForexGereftEditScreenState extends State<ForexGereftEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final forexGereftController = Provider.of<ForexGereftController>(context);

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
                    controller: forexGereftController.dollarPriceController,
                    // customValidator: customFormValidator,
                    customValidator: (value) =>
                        customValidatorCheckNumberOnly(value, currentLocale),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const UserListBottomSheet();
                        },
                      );
                    },
                    child: CustomTextFieldWithController(
                      customValidator: (value) =>
                          customValidator(value, currentLocale),
                      isDisabled: true,
                      controller:
                          forexGereftController.selectedUserNameController,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('by_person'),
                    ),
                  ),
                  DatePicker(
                    controller: forexGereftController.dateController,
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('description'),
                    controller: forexGereftController.descriptionController,
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
                        forexGereftController.editForexGereft(
                          widget.gereftId,
                        );
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
