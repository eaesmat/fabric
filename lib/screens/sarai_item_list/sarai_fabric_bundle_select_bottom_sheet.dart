import 'package:fabricproject/controller/ttranser_bundles_controller.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/controller/sarai_fabric_bundle_select_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import 'package:fabricproject/model/sarai_fabric_bundle_select_model.dart';

class SaraiFabricBundleSelectBottomSheet extends StatefulWidget {
  const SaraiFabricBundleSelectBottomSheet({Key? key}) : super(key: key);

  @override
  State<SaraiFabricBundleSelectBottomSheet> createState() =>
      _SaraiFabricBundleSelectBottomSheetState();
}

class _SaraiFabricBundleSelectBottomSheetState
    extends State<SaraiFabricBundleSelectBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // controller provider
    final saraiFabricBundleSelectController =
        Provider.of<SaraiFabricBundleSelectController>(context);
    final transferBundlesController =
        Provider.of<TransferBundlesController>(context);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.all(16.0),
        color: Pallete.whiteColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              // search text filed
              child: CustomTextFieldWithController(
                // create button in the search text filed

                lblText: const LocaleText('search'),
                onChanged: (value) {
                  // searches item
                  saraiFabricBundleSelectController
                      .searchSaraiFabricBundleSelectMethod(value);
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: saraiFabricBundleSelectController
                        .searchSaraiFabricBundleSelects?.length ??
                    0,
                itemBuilder: (context, index) {
                  // data gets data from controller
                  final reversedList = saraiFabricBundleSelectController
                      .searchSaraiFabricBundleSelects!.reversed
                      .toList();
                  final data = reversedList[index];
                  final isSelected = saraiFabricBundleSelectController
                      .selectedItems
                      ?.contains(data);

                  return ListTileWidget(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          saraiFabricBundleSelectController
                              .removeItemFromSelected(data);
                          transferBundlesController.removeItemFromData(
                              'saraidesignbundle_id${data.saraidesignbundleId}');
                        } else {
                          saraiFabricBundleSelectController
                              .addItemToSelected(data);
                          transferBundlesController.addItemToData(
                              'saraidesignbundle_id${data.saraidesignbundleId}',
                              "${data.saraidesignbundleId}");
                        }
                      });
                    },
                    tileTitle: Row(
                      children: [
                        Text(data.name ?? ''),
                        const Spacer(),
                        Text(data.bundleName ?? ''),
                      ],
                    ),
                    tileSubTitle: Text(data.war.toString()),
                    lead: isSelected!
                        ? const Icon(Icons.check_circle,
                            color: Pallete.blueColor)
                        : Icon(Icons.check_circle_outline,
                            color: Colors.grey.shade700),
                  );
                },
              ),
            ),
            CustomDropDownButton(
              bgColor: Pallete.blueColor,
              onTap: () {
                // Do something with the selected items
                // saraiFabricBundleSelectController.printSelectedItems();
                saraiFabricBundleSelectController.notify();
                Navigator.pop(context);
              },
              btnText: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: Pallete.whiteColor,
                  ),
                  LocaleText(
                    'select',
                    style: TextStyle(color: Pallete.whiteColor),
                  ),
                ],
              ),
              btnIcon: Text(
                saraiFabricBundleSelectController.selectedItems!.length
                    .toString(),
                style: const TextStyle(color: Pallete.whiteColor),
              ),
              btnWidth: 1,
            ),
          ],
        ),
      ),
    );
  }
}
