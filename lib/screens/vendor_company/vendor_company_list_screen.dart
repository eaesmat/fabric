import 'package:fabricproject/controller/vendor_company_controller.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class VendorCompanyListScreen extends StatefulWidget {
  const VendorCompanyListScreen({Key? key}) : super(key: key);

  @override
  State<VendorCompanyListScreen> createState() =>
      _VendorCompanyListScreenState();
}

class _VendorCompanyListScreenState extends State<VendorCompanyListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<VendorCompanyController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final drawController = Provider.of<DrawController>(context);

    return CustomRefreshIndicator(
      onRefresh: () {
        return Provider.of<VendorCompanyController>(context, listen: false)
            .getAllVendorCompanies();
      },
      child: Column(
        children: [
          // search part

          Consumer<VendorCompanyController>(
            builder: (context, vendorCompanyController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
                  // search Icon to create new item

                  iconBtn: IconButton(
                    icon: const Icon(
                      Icons.add_box,
                      color: Pallete.blueColor,
                    ),
                    // create new item here

                    onPressed: () {
                      // passes search text to the controller

                      vendorCompanyController.navigateToVendorCompanyCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    vendorCompanyController.searchVendorCompaniesMethod(value);
                  },
                ),
              );
            },
          ),
          // data list view

          Expanded(
            child: Consumer<VendorCompanyController>(
              builder: (context, vendorCompanyController, child) {
                final searchVendorCompanies =
                    vendorCompanyController.searchVendorCompanies;

                if (searchVendorCompanies.isEmpty) {
                  return const NoDataFoundWidget();
                } else {
                  return ListView.builder(
                    itemCount: searchVendorCompanies.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final reversedList =
                          searchVendorCompanies.reversed.toList();
                      final data = reversedList[index];

                      return ListTileWidget(
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
                          itemBuilder: (context) => <PopupMenuEntry<String>>[
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
                              ),
                            ),
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
                              ),
                            ),
                          ],
                          onSelected: (String value) {
                            if (value == "edit") {
                              // navigates to the edit screen
                              vendorCompanyController
                                  .navigateToVendorCompanyEdit(
                                      data, data.vendorcompanyId!.toInt());
                            }
                            if (value == "delete") {
                              vendorCompanyController
                                  .deleteVendorCompany(data.vendorcompanyId!);
                            }
                          },
                        ),
                        onTap: () {
                          // pass the the id and data to the fabric purchase controller on click
                          vendorCompanyController
                              .navigateToVendorCompanyPurchaseListScreen(
                            data.name.toString(),
                            data.vendorcompanyId!,
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
