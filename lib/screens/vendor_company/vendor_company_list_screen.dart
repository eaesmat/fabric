import 'package:fabricproject/controller/draw_controller.dart';
import 'package:fabricproject/controller/fabric_purchase_controller.dart';
import 'package:fabricproject/controller/vendor_company_controller.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
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
  Widget build(BuildContext context) {
    final vendorCompanyController =
        Provider.of<VendorCompanyController>(context);
    final fabricPurchaseController =
        Provider.of<FabricPurchaseController>(context);
    final drawController =
        Provider.of<DrawController>(context);

    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'vendor_companies'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<VendorCompanyController>(
            builder: (context, vendorCompanyController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    vendorCompanyController.searchVendorCompaniesMethod(value);
                  },
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<VendorCompanyController>(
              builder: (context, vendorCompanyController, child) {
                return ListView.builder(
                  itemCount:
                      vendorCompanyController.searchVendorCompanies?.length ??
                          0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data =
                        vendorCompanyController.searchVendorCompanies![index];
                    return ListTileWidget(
                      tileTitle: Text(
                        data.name.toString(),
                      ),
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
                            vendorCompanyController.navigateToVendorCompanyEdit(
                                data, data.vendorcompanyId!.toInt());
                          }
                          if (value == "delete") {
                            vendorCompanyController.deleteVendorCompany(
                                data.vendorcompanyId, index);
                          }
                        },
                      ),
                      onTap: () {
                        fabricPurchaseController.navigateToVendorCompanyDetails(
                          data.name.toString(), data.vendorcompanyId!
                        );
                        fabricPurchaseController.vendorCompanyId =
                            data.vendorcompanyId!.toInt();
                            
                        drawController.navigateToVendorCompanyDetails(
                          data.name.toString(), data.vendorcompanyId!
                        );
                        drawController.vendorCompanyId =
                            data.vendorcompanyId!.toInt();
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.blueColor,
        onPressed: () {
          vendorCompanyController.navigateToVendorCompanyCreate();
        },
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
        ),
      ),
    );
  }
}