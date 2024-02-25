import 'package:fabricproject/controller/transer_dokan_pati_controller.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/controller/dokan_pati_select_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class DokanPatiSelectBottomSheet extends StatefulWidget {
  const DokanPatiSelectBottomSheet({Key? key}) : super(key: key);

  @override
  State<DokanPatiSelectBottomSheet> createState() =>
      _DokanPatiSelectBottomSheetState();
}

class _DokanPatiSelectBottomSheetState
    extends State<DokanPatiSelectBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // controller provider
    final dokanPatiSelectController =
        Provider.of<DokanPatiSelectController>(context);
    final transferDokanPatiController =
        Provider.of<TransferDokanPatiController>(context);

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
                  dokanPatiSelectController
                      .searchDokanPatiMethod(value);
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: dokanPatiSelectController
                        .searchAllDokanPatiSelects?.length ??
                    0,
                itemBuilder: (context, index) {
                  // data gets data from controller
                  final reversedList = dokanPatiSelectController
                      .searchAllDokanPatiSelects!.reversed
                      .toList();
                  final data = reversedList[index];
                  final isSelected = dokanPatiSelectController
                      .selectedItems
                      ?.contains(data);

                  return ListTileWidget(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          dokanPatiSelectController
                              .removeItemFromSelected(data);
                          transferDokanPatiController.removeItemFromData(
                              'saraipati_id${data.saraipatiId}');
                        } else {
                          dokanPatiSelectController
                              .addItemToSelected(data);
                          transferDokanPatiController.addItemToData(
                              'saraipati_id${data.saraipatiId}',
                              "${data.saraipatiId}");
                        }
                      });
                    },
                    tileTitle: Row(
                      children: [
                        Text(data.patiname ?? ''),
                        const Spacer(),
                        Text(data.bundlename ?? ''),
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
                dokanPatiSelectController.notify();
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
                dokanPatiSelectController.selectedItems!.length
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
