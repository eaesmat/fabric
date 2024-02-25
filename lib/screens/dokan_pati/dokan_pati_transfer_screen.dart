import 'package:fabricproject/controller/dokan_pati_select_controller.dart';
import 'package:fabricproject/controller/sarai_fabric_bundle_select_controller.dart';
import 'package:fabricproject/controller/sarai_marka_controller.dart';
import 'package:fabricproject/controller/ttranser_bundles_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/screens/dokan_pati/dokan_fabric_purchase_bottom_sheet.dart';
import 'package:fabricproject/screens/dokan_pati/dokan_pati_select_bottom_sheet.dart';
import 'package:fabricproject/screens/sarai/sarai_bottom_sheet.dart';
import 'package:fabricproject/screens/sarai_item_list/sarai_marka_bottom_sheet.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/selected_bundles_card_wdiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class DokanPatiTransferScreen extends StatefulWidget {
  final int saraiId;
  const DokanPatiTransferScreen({super.key, required this.saraiId});

  @override
  State<DokanPatiTransferScreen> createState() =>
      _DokanPatiTransferScreenState();
}

class _DokanPatiTransferScreenState extends State<DokanPatiTransferScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  @override
  Widget build(BuildContext context) {
    // controller provider instance
    final saraiMarkaController = Provider.of<SaraiMarkaController>(context);
    final dokanPatiSelectController =
        Provider.of<DokanPatiSelectController>(context);
    final transferBundlesController =
        Provider.of<TransferBundlesController>(context);
    final saraiFabricBundleSelectController =
        Provider.of<SaraiFabricBundleSelectController>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    transferBundlesController.saraiIdController.text =
        widget.saraiId.toString();

    Locale currentLocale = Localizations.localeOf(context);

    return Dialog.fullscreen(
      backgroundColor: Pallete.whiteColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFieldWithController(
                  lblText: const LocaleText('carrier'),
                  controller:
                      transferBundlesController.transporterNameController,
                  // comes from helper validates the field
                ),
                GestureDetector(
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
                    controller:
                        transferBundlesController.selectedSaraiToNameController,
                    iconBtn: const Icon(
                      size: 30,
                      Icons.add_box_rounded,
                      color: Pallete.blueColor,
                    ),
                    lblText: const LocaleText('Sarai'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    saraiMarkaController.getSaraiMarka(widget.saraiId);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return SaraiMarkaBottomSheet(
                          saraiId: widget.saraiId,
                        );
                      },
                    );
                  },
                  child: CustomTextFieldWithController(
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                    isDisabled: true,
                    controller:
                        transferBundlesController.selectedMarkaNameController,
                    iconBtn: const Icon(
                      size: 30,
                      Icons.add_box_rounded,
                      color: Pallete.blueColor,
                    ),
                    lblText: const LocaleText('marka'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return DokanFabricPurchaseBottomSheet(
                          saraiId: widget.saraiId,
                        );
                      },
                    );
                  },
                  child: CustomTextFieldWithController(
                    customValidator: (value) =>
                        customValidator(value, currentLocale),
                    isDisabled: true,
                    controller:
                        transferBundlesController.selectedFabricCodeController,
                    iconBtn: const Icon(
                      size: 30,
                      Icons.add_box_rounded,
                      color: Pallete.blueColor,
                    ),
                    lblText: const LocaleText('fabric_code'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomDropDownButton(
                      btnWidth: 0.1,
                      btnIcon: const Icon(
                        Icons.add,
                        color: Pallete.whiteColor,
                      ),
                      bgColor: Pallete.blueColor,
                      onTap: () {
                        // validates the form to create the new item
                        // if (formKey.currentState!.validate()) {
                        // companyController.createCompany();
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return const DokanPatiSelectBottomSheet();
                          },
                        );
                        // Navigator.pop(context);
                        // }
                      },
                    ),
                    CustomDropDownButton(
                      btnWidth: 0.1,
                      btnIcon: const Icon(
                        Icons.all_out_outlined,
                        color: Pallete.whiteColor,
                      ),
                      bgColor: Pallete.blueColor,
                      onTap: () {
                        // validates the form to create the new item
                        if (formKey.currentState!.validate()) {
                          // companyController.createCompany();
                          Navigator.pop(context);
                        }
                      },
                    ),
                    CustomDropDownButton(
                      btnWidth: 0.1,
                      btnIcon: const Icon(
                        Icons.compress_sharp,
                        color: Pallete.whiteColor,
                      ),
                      bgColor: Pallete.blueColor,
                      onTap: () {
                        // validates the form to create the new item
                        if (formKey.currentState!.validate()) {
                          transferBundlesController.addAllItemsToData();
                          transferBundlesController.transferBundles();
                          // transferBundlesController.clearAllControllers();
                        }
                      },
                    ),
                    CustomDropDownButton(
                      btnWidth: 0.1,
                      btnIcon: const Icon(
                        Icons.remove,
                        color: Pallete.whiteColor,
                      ),
                      bgColor: Pallete.blueColor,
                      onTap: () {
                        saraiFabricBundleSelectController.resetSearchFilter();
                        transferBundlesController.selectedBundles.clear();
                        transferBundlesController.transferFormData.clear();

                        // validates the form to create the new item
                        // if (formKey.currentState!.validate()) {
                        //   // companyController.createCompany();
                        //   Navigator.pop(context);
                        // }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                const LocaleText('selected_bundles'),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Consumer<DokanPatiSelectController>(
                  builder: (context, dokanPatiSelectController, child) {
                    return SizedBox(
                      height: screenHeight * 0.2,
                      child: dokanPatiSelectController
                                  .selectedItems?.isNotEmpty ==
                              true
                          ? ListView.builder(
                              itemCount: dokanPatiSelectController
                                  .selectedItems!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                // Ensure that the index is within the bounds of the list
                                if (index >= 0 &&
                                    index <
                                        dokanPatiSelectController
                                            .selectedItems!.length) {
                                  final reversedList = dokanPatiSelectController
                                      .selectedItems!.reversed
                                      .toList();
                                  final data = reversedList[index];
                                  return SelectedBundleCardWidget(
                                    name: data.patiname.toString(),
                                    bundleName: data.war.toString(),
                                    war: data.bundlename.toString(),
                                  );
                                } else {
                                  // Handle the case where the index is out of bounds
                                  return Container();
                                }
                              },
                            )
                          : Center(
                              child: Image.asset(
                                'assets/images/noData.png',
                                width: screenWidth * 0.4,
                                height: screenWidth * 0.4,
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
