import 'package:fabricproject/controller/dokan_pati_select_controller.dart';
import 'package:fabricproject/controller/sarai_fabric_purchase_controller.dart';
import 'package:fabricproject/controller/tranfser_dokan_pati_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class DokanFabricPurchaseBottomSheet extends StatefulWidget {
  final int? saraiId;
  const DokanFabricPurchaseBottomSheet({super.key, required this.saraiId});

  @override
  State<DokanFabricPurchaseBottomSheet> createState() =>
      _DokanFabricPurchaseBottomSheetState();
}

class _DokanFabricPurchaseBottomSheetState
    extends State<DokanFabricPurchaseBottomSheet> {
  @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     // Reset search filter after the build cycle is complete
  //     Provider.of<SaraiFabricPurchaseController>(context, listen: false)
  //         .resetSearchFilter();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // controller provider
    final saraiFabricPurchaseController =
        Provider.of<SaraiFabricPurchaseController>(context);
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                // search text filed
                child: CustomTextFieldWithController(
                  // create button in the search text filed
                  iconBtn: IconButton(
                    icon: const Icon(
                      size: 30,
                      Icons.add_box_rounded,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      // to create new
                      // saraiMarkaController.navigateToCompanyCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // searches item
                    saraiFabricPurchaseController
                        .searchSaraiFabricPurchaseMethod(value);
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: saraiFabricPurchaseController
                        .searchSaraiFabricPurchase?.length ??
                    0,
                itemBuilder: (context, index) {
                  // data gets data from controller
                  final reversedList = saraiFabricPurchaseController
                      .searchSaraiFabricPurchase!.reversed
                      .toList();
                  final data = reversedList[index];
                  return ListTileWidget(
                    onTap: () {
                      dokanPatiSelectController.resetSearchFilter();

                      dokanPatiSelectController.getDokanPatiSelect(
                        data.fabricpurchaseId!.toInt(),
                        widget.saraiId,
                      );

                      transferDokanPatiController.selectedFabricCodeIdController
                          .text = data.fabricpurchaseId.toString();
                      transferDokanPatiController.selectedFabricCodeController
                          .text = data.fabricpurchasecode.toString();
                      Navigator.pop(context);
                    },
                    tileTitle: Text(
                      data.fabricpurchasecode.toString(),
                    ),
                    tileSubTitle: Text(data.bundle.toString()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
