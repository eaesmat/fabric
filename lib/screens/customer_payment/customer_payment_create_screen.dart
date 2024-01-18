import 'package:fabricproject/controller/customer_payment_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/date_picker.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CustomerPaymentCreateScreen extends StatefulWidget {
  const CustomerPaymentCreateScreen({super.key});

  @override
  State<CustomerPaymentCreateScreen> createState() =>
      _CustomerPaymentCreateScreenState();
}

class _CustomerPaymentCreateScreenState
    extends State<CustomerPaymentCreateScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // controller provider instance

    final customerPaymentController =
        Provider.of<CustomerPaymentController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'create_customer_payment'),
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
                    controller:
                        customerPaymentController.amountDollarController,
                    lblText: const LocaleText('dollar'),
                  ),
                  CustomTextFieldWithController(
                    controller:
                        customerPaymentController.amountAfghaniController,
                    lblText: const LocaleText('AFN'),
                  ),
                  CustomTextFieldWithController(
                    lblText: const LocaleText('person'),
                    controller: customerPaymentController.personController,
                  ),
                  CustomTextFieldWithController(
                    controller: customerPaymentController.descriptionController,
                    lblText: const LocaleText('description'),
                  ),
                  DatePicker(
                    controller: customerPaymentController.dateController,
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
                        customerPaymentController.createCustomerPayment();
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
