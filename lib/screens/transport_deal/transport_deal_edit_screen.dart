import 'package:fabricproject/controller/container_controller.dart';
import 'package:fabricproject/controller/sarai_in_deal_controller.dart';
import 'package:fabricproject/controller/transport_deal_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/transport_deal_model.dart';
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

class TransportDealEditScreen extends StatefulWidget {
  final Data transportDealData;
  final int transportDealId;
  const TransportDealEditScreen(
      {super.key,
      required this.transportDealData,
      required this.transportDealId});

  @override
  State<TransportDealEditScreen> createState() =>
      _TransportDealEditScreenState();
}

class _TransportDealEditScreenState extends State<TransportDealEditScreen> {
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
        title: const LocaleTexts(localeText: 'update_transport_deal'),
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
                      'update',
                      style: TextStyle(color: Pallete.whiteColor),
                    ),
                    bgColor: Pallete.blueColor,
                    // Other parts of your code...

                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        // Inside the method where the transport deal is created
                        // Inside the method where the transport deal is created

                        int saraiInDealId = int.parse(transportDealController
                            .saraiInDealIdController.text);

                        int containerId = int.parse(
                            transportDealController.containerIdController.text);
                        await transportDealController
                            .editTransportDeal(widget.transportDealId);
                        Navigator.pop(context);
                        await transportDealController.getAllTransportDeal(
                            transportDealController.transportId);

                        if (transportDealController.isUpdated) {
                          // container data

                          containerController.nameController.text =
                              transportDealController
                                  .containerNameController.text;
                          containerController.transportDealController.text =
                              widget.transportDealId.toString();
                          // sarai data

                          print("ids =");
                          print(containerId);
                          print(saraiInDealId);
                          saraiInDealController.saraiIdController.text =
                              transportDealController
                                  .selectedSaraiIdController.text;

                          saraiInDealController.inDateController.text =
                              transportDealController.saraiInDealDate.text;

                          saraiInDealController.transportDealIdController.text =
                              widget.transportDealId.toString();

                          

                          await containerController.editContainer(containerId);
                          await saraiInDealController
                              .editSaraiInDeal(saraiInDealId);
                          await transportDealController
                              .refreshTransportDealData();
                        }
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
