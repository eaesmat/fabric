import 'package:fabricproject/controller/all_fabric_purchase_controller.dart';
import 'package:fabricproject/controller/fabric_controller.dart';
import 'package:fabricproject/controller/transport_deal_controller.dart';
import 'package:fabricproject/screens/fabric_purchase/fabric_purchase_item_details.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class FabricPurchaseButtonSheet extends StatefulWidget {
  const FabricPurchaseButtonSheet({super.key});

  @override
  State<FabricPurchaseButtonSheet> createState() =>
      _FabricPurchaseButtonSheetState();
}

class _FabricPurchaseButtonSheetState extends State<FabricPurchaseButtonSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<FabricController>(context, listen: false).resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
// controller class providers

    final fabricPurchaseController =
        Provider.of<AllFabricPurchaseController>(context);
    final transportDealController =
        Provider.of<TransportDealController>(context);

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
                // search item widget
                child: CustomTextFieldWithController(
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // passes the search text to the controller
                    fabricPurchaseController.searchFabricPurchasesMethod(value);
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              // list data here
              ListView.builder(
                shrinkWrap: true,
                itemCount:
                    fabricPurchaseController.searchFabricPurchases?.length ?? 0,
                itemBuilder: (context, index) {
                  // data from controller
                  final reversedList = fabricPurchaseController
                      .searchFabricPurchases!.reversed
                      .toList();
                  final data = reversedList[index];
                  return ListTileWidget(
                    onTap: () {
                      // pass id
                      transportDealController.clearKhatCalculatedControllers();
                      transportDealController.selectedFabricPurchaseIdController
                          .text = data.fabricpurchaseId!.toString();
                      transportDealController.amountOfBundlesController.text =
                          data.bundle.toString();
                      transportDealController.warPriceFromUIController.text =
                          data.war.toString();
                      transportDealController
                          .selectedFabricPurchaseCodeController
                          .text = data.fabricpurchasecode!.toString();
                      transportDealController
                          .selectedFabricPurchaseNameController
                          .text = data.fabric!.name!.toString();
                      Navigator.pop(context);
                    },
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return FabricDetailsBottomSheet(
                              data: data,
                              fabricName: data.fabric!.name.toString());
                        },
                      );
                    },
                    tileTitle: Row(
                      children: [
                        Text(
                          data.fabric!.name.toString(),
                        ),
                        const Spacer(),
                        Text(
                          data.fabricpurchasecode!.toString(),
                        ),
                      ],
                    ),
                    tileSubTitle: Row(
                      children: [
                        Text(
                          data.company!.name.toString(),
                        ),
                        const Spacer(),
                        Text(
                          data.date.toString(),
                        ),
                      ],
                    ),
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
