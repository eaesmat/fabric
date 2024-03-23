import 'package:fabricproject/constants/screen_type_constants.dart';
import 'package:fabricproject/controller/all_fabric_purchases_controller.dart';
import 'package:fabricproject/controller/khalid_rasid_controller.dart';
import 'package:fabricproject/controller/vendor_company_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class VendorCompanyBottomSheet extends StatefulWidget {
  final String screenType;
  const VendorCompanyBottomSheet({Key? key, required this.screenType})
      : super(key: key);

  @override
  State<VendorCompanyBottomSheet> createState() =>
      _VendorCompanyBottomSheetState();
}

class _VendorCompanyBottomSheetState extends State<VendorCompanyBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<VendorCompanyController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  void passDataToController(
      String screenType, vendorCompanyName, vendorCompanyId) {
    if (screenType == ScreenTypeConstants.allFabricPurchasesScreen) {
      final allFabricPurchasesController =
          Provider.of<AllFabricPurchasesController>(context, listen: false);

      allFabricPurchasesController.selectedVendorCompanyName.text =
          vendorCompanyName;
      allFabricPurchasesController.selectedVendorCompanyId.text =
          vendorCompanyId.toString();
    }
    if (screenType == ScreenTypeConstants.khalidRasidScreen) {
      final khalidRasidController =
          Provider.of<KhalidRasidController>(context, listen: false);

      khalidRasidController.selectedVendorCompanyName.text = vendorCompanyName;
      khalidRasidController.selectedVendorCompanyId.text =
          vendorCompanyId.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    // controller provider
    // fabric purchase controller to pass the selected id to the fabric purchase controller
    final vendorCompanyController =
        Provider.of<VendorCompanyController>(context);
    // final allDrawController = Provider.of<AllDrawController>(context);

    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<VendorCompanyController>(context, listen: false)
            .getAllVendorCompanies();
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          margin: EdgeInsets.zero,
          height: MediaQuery.of(context).size.height * 0.9,
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          color: Pallete.whiteColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
                  iconBtn: IconButton(
                    icon: const Icon(
                      Icons.add_box,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      // search Icon to create new item
                      vendorCompanyController.navigateToVendorCompanyCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // Passes search text to the controller
                    vendorCompanyController.searchVendorCompaniesMethod(value);
                  },
                ),
              ),
              Expanded(
                child: vendorCompanyController.searchVendorCompanies.isEmpty
                    ? const NoDataFoundWidget()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: vendorCompanyController
                            .searchVendorCompanies.length,
                        itemBuilder: (context, index) {
                          // data gets data from controller
                          final reversedList = vendorCompanyController
                              .searchVendorCompanies.reversed
                              .toList();
                          final data = reversedList[index];

                          return ListTileWidget(
                            onTap: () {
                              passDataToController(widget.screenType, data.name,
                                  data.vendorcompanyId);
                              Navigator.pop(context);
                            },
                            // Tile Title

                            tileTitle: Text(
                              data.name.toString(),
                            ),
                            // subtitle

                            tileSubTitle: Row(
                              children: [
                                Text(
                                  data.description.toString(),
                                ),
                                const Spacer(),
                                Text(
                                  data.phone.toString(),
                                ),
                              ],
                            ),
                            // trailing hold delete and update buttons

                            trail: PopupMenuButton(
                              color: Pallete.whiteColor,
                              child: const Icon(Icons.more_vert_sharp),
                              itemBuilder: (context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem(
                                    value: "delete",
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        LocaleText('delete'),
                                      ],
                                    )),
                                const PopupMenuItem(
                                    value: "edit",
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        LocaleText('update'),
                                      ],
                                    )),
                              ],
                              onSelected: (String value) {
                                if (value == "edit") {
                                  // navigates to the edit screen

                                  vendorCompanyController
                                      .navigateToVendorCompanyEdit(
                                          data, data.vendorcompanyId!.toInt());
                                }
                                if (value == "delete") {
                                  vendorCompanyController.deleteVendorCompany(
                                    data.vendorcompanyId!,
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
