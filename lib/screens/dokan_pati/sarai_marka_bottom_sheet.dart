import 'package:fabricproject/controller/sarai_fabric_purchase_controller.dart';
import 'package:fabricproject/controller/sarai_marka_controller.dart';
import 'package:fabricproject/controller/tranfser_dokan_pati_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class DokanMarkaBottomSheet extends StatefulWidget {
  final int? saraiId;
  const DokanMarkaBottomSheet({super.key, required this.saraiId});

  @override
  State<DokanMarkaBottomSheet> createState() => _DokanMarkaBottomSheetState();
}

class _DokanMarkaBottomSheetState extends State<DokanMarkaBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<SaraiMarkaController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    // controller provider
    final saraiMarkaController = Provider.of<SaraiMarkaController>(context);
    final transferDokanPatiController =
        Provider.of<TransferDokanPatiController>(context);

    final saraiFabricPurchaseController =
        Provider.of<SaraiFabricPurchaseController>(context);

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
                    saraiMarkaController.searchSaraiMarkaMethod(value);
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: saraiMarkaController.searchSaraiMarka?.length ?? 0,
                itemBuilder: (context, index) {
                  // data gets data from controller
                  final reversedList =
                      saraiMarkaController.searchSaraiMarka!.reversed.toList();
                  final data = reversedList[index];
                  return ListTileWidget(
                    onTap: () {
                      saraiFabricPurchaseController.getSaraiFabricPurchase(
                          data.companyId!.toInt(), widget.saraiId);

                      transferDokanPatiController.selectedMarkaIdController
                          .text = data.companyId.toString();

                      transferDokanPatiController.selectedMarkaNameController
                          .text = data.name.toString();

                      print("the marka and id");
                      print(transferDokanPatiController
                          .selectedMarkaIdController);
                      print(transferDokanPatiController
                          .selectedMarkaNameController);

                      Navigator.pop(context);
                    },
                    lead: CircleAvatar(
                      backgroundColor: Pallete.blueColor,
                      child: Text(
                        data.marka!.toUpperCase(),
                        style: const TextStyle(color: Pallete.whiteColor),
                      ),
                    ),
                    tileTitle: Text(
                      data.name.toString(),
                    ),
                    tileSubTitle: Text(data.description.toString()),
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
