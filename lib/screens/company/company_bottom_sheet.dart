import 'package:fabricproject/controller/company_controller.dart';
import 'package:fabricproject/controller/fabric_purchase_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CompanyBottomSheet extends StatelessWidget {
  const CompanyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // controller provider
    CompanyController companyController =
        Provider.of<CompanyController>(context);
    // fabric purchase controller to pass the selected id to the fabric purchase controller
    final fabricPurchaseController =
        Provider.of<FabricPurchaseController>(context);

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
                      companyController.navigateToCompanyCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // searches item
                    companyController.searchCompaniesMethod(value);
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: companyController.searchCompanies?.length ?? 0,
                itemBuilder: (context, index) {
                  // data gets data from controller 
                  final reversedList =
                      companyController.searchCompanies!.reversed.toList();
                  final data = reversedList[index];
                  return ListTileWidget(
                    onTap: () {
                    
                          fabricPurchaseController.companyController
                          .text = data.companyId!.toString();
                      fabricPurchaseController.selectedCompany.text =
                          '${data.name},  ${data.description} (${data.marka} )';
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
                          companyController.navigateToCompanyEdit(
                              data, data.companyId!.toInt());
                        }
                        if (value == "delete") {
                          companyController.deleteCompany(
                              data.companyId, index);
                        }
                      },
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
