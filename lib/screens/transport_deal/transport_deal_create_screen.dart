import 'package:fabricproject/controller/container_controller.dart';
import 'package:fabricproject/controller/sarai_in_deal_controller.dart';
import 'package:fabricproject/controller/transport_deal_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/screens/fabric_purchase/fabric_purchase_button_sheet.dart';
import 'package:fabricproject/screens/sarai/sarai_bottom_sheet.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/date_picker.dart';
import 'package:fabricproject/widgets/khat_converter.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class TransportDealCreateScreen extends StatefulWidget {
  const TransportDealCreateScreen({super.key});

  @override
  State<TransportDealCreateScreen> createState() =>
      _TransportDealCreateScreenState();
}

class _TransportDealCreateScreenState extends State<TransportDealCreateScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // controller provider instance
    final transportDealController =
        Provider.of<TransportDealController>(context);
    final containerController = Provider.of<ContainerController>(context);
    final saraiInDealController = Provider.of<SaraiInDealController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'create_transport_deal'),
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
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return const FabricPurchaseButtonSheet();
                              },
                            );
                          },
                          child: CustomTextFieldWithController(
                            customValidator: (value) =>
                                customValidator(value, currentLocale),
                            isDisabled: true,
                            controller: transportDealController
                                .selectedFabricPurchaseCodeController,
                            iconBtn: const Icon(
                              size: 30,
                              Icons.add_box_rounded,
                              color: Pallete.blueColor,
                            ),
                            lblText: const LocaleText('fabric'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomTextFieldWithController(
                          isDisabled: true,
                          controller: transportDealController
                              .selectedFabricPurchaseNameController,
                          lblText: const LocaleText('item_name'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFieldWithController(
                          controller:
                              transportDealController.amountOfBundlesController,
                          lblText: const LocaleText('bundle'),
                        ),
                      ),
                      Expanded(
                        child: CustomTextFieldWithController(
                          customValidator: (value) =>
                              customValidator(value, currentLocale),
                          controller:
                              transportDealController.containerNameController,
                          lblText: const LocaleText('container_name'),
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Expanded(child: KhatConverterDialog()),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return const SaraiButtonSheet();
                              },
                            );
                          },
                          child: CustomTextFieldWithController(
                            customValidator: (value) =>
                                customValidator(value, currentLocale),
                            isDisabled: true,
                            controller: transportDealController
                                .selectedSaraiNameController,
                            iconBtn: const Icon(
                              size: 30,
                              Icons.add_box_rounded,
                              color: Pallete.blueColor,
                            ),
                            lblText: const LocaleText('sarai'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: DatePicker(
                          controller:
                              transportDealController.startDateController,
                        ),
                      ),
                    ],
                  ),
                  CustomTextFieldWithController(
                    controller: transportDealController.durationController,
                    lblText: const LocaleText('duration'),
                  ),
                  CustomTextFieldWithController(
                    controller: transportDealController.photoController,
                    lblText: const LocaleText('photo'),
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
                    // Other parts of your code...

                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        // Inside the method where the transport deal is created
                        // Inside the method where the transport deal is created
                        await transportDealController.createTransportDeal();
                        Navigator.pop(context);
// Fetch updated transport deals immediately after creation
                        await transportDealController.getAllTransportDeal(
                            transportDealController.transportId);

// Retrieve the last ID from the updated list
                        if (transportDealController.isAdded) {
                          int? lastTransportDealId =
                              transportDealController.getLastTransportDealId();
                          print(lastTransportDealId);
                          if (lastTransportDealId != null) {
                            // assign container name to the container controller
                            containerController.nameController.text =
                                transportDealController
                                    .containerNameController.text;
                            // assign container transportDealId
                            containerController.transportDealController.text =
                                lastTransportDealId.toString();
                            // assign created transportDeal id to the sarai in deal

                            saraiInDealController.saraiIdController.text =
                                transportDealController
                                    .selectedSaraiIdController.text;
                            saraiInDealController
                                    .transportDealIdController.text =
                                lastTransportDealId
                                    .toString(); // Create a container and refresh the transport deals again
                            await containerController.createContainer();
                            await saraiInDealController.createSaraiInDeal();
                            await transportDealController
                                .refreshTransportDealData();
                          }
                        }

// Update other controllers or perform necessary actions

                        // Update other controllers or perform necessary actions
                      }
                    },

// Remaining parts of your code...
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
