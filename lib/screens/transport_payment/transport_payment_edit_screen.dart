import 'package:fabricproject/controller/transport_payment_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/transport_payment._model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/date_picker.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class TransportPaymentEditScreen extends StatefulWidget {
  // gets this data from controller
  final Data transportPaymentData;
  final int transportPaymentId;

  const TransportPaymentEditScreen({
    super.key,
    required this.transportPaymentData,
    required this.transportPaymentId,
  });

  @override
  State<TransportPaymentEditScreen> createState() =>
      _TransportPaymentEditScreenState();
}

class _TransportPaymentEditScreenState
    extends State<TransportPaymentEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // gets and sends data to the controller using
    final transportPaymentController =
        Provider.of<TransportPaymentController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'update_transport_payment'),
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
                    lblText: const LocaleText('amount'),
                    controller: transportPaymentController.amountController,
                    // comes from helper validates the field
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('person'),
                    controller: transportPaymentController.personController,
                    // comes from helper validates the field
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                  ),
                  DatePicker(
                    controller: transportPaymentController.dateOneController,
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
                      // if form is validate will be edited
                      if (formKey.currentState!.validate()) {
                        // passes the id to the controller to all edit method
                        transportPaymentController
                            .editTransportPayment(widget.transportPaymentId);
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
