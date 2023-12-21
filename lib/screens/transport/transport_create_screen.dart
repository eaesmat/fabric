import 'package:fabricproject/controller/transport_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class TransportCreateScreen extends StatefulWidget {
  const TransportCreateScreen({super.key});

  @override
  State<TransportCreateScreen> createState() => _TransportCreateScreenState();
}

class _TransportCreateScreenState extends State<TransportCreateScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final transportController = Provider.of<TransportController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'create_transport'),
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
                    lblText: const LocaleText('name'),
                    controller: transportController.nameController,
                    // customValidator: customFormValidator,
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    controller: transportController.phoneController,
                    lblText: const LocaleText('phone'),
                    //  customValidator: customFormValidator
                  ),
                  CustomTextFieldWithController(
                    controller: transportController.desorptionController,
                    lblText: const LocaleText('description'),
                    // customValidator: customFormValidator,
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
                        transportController.createTransport();
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
