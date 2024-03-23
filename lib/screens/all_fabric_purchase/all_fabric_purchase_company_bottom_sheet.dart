import 'package:fabricproject/controller/all_fabric_purchases_controller.dart';
import 'package:fabricproject/controller/colors_controller.dart';
import 'package:fabricproject/controller/company_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CompanyBottomSheet extends StatefulWidget {
  const CompanyBottomSheet({Key? key}) : super(key: key);

  @override
  State<CompanyBottomSheet> createState() => _CompanyBottomSheetState();
}

class _CompanyBottomSheetState extends State<CompanyBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        // Reset search filter after the build cycle is complete
        Provider.of<CompanyController>(context, listen: false)
            .resetSearchFilter();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final companyController = Provider.of<CompanyController>(context);
    // fabric purchase controller to pass the selected id to the fabric purchase controller

    final allFabricPurchasesController =
        Provider.of<AllFabricPurchasesController>(context);

    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<ColorsController>(context, listen: false)
            .getAllColors();
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
                      companyController.navigateToCompanyCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    companyController.searchCompaniesMethod(value);
                  },
                ),
              ),
              Expanded(
                child: companyController.searchCompanies.isEmpty
                    ? const NoDataFoundWidget()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: companyController.searchCompanies.length,
                        itemBuilder: (context, index) {
                          // data gets data from controller
                          final reversedList = companyController
                              .searchCompanies.reversed
                              .toList();
                          final data = reversedList[index];

                          return ListTileWidget(
                            onTap: () {
                              allFabricPurchasesController
                                  .selectedCompanyIdController
                                  .text = data.companyId!.toString();

                              allFabricPurchasesController
                                      .selectedCompanyNameController.text =
                                  '${data.name},  ${data.description} (${data.marka} )';
                              Navigator.pop(context);
                            },
                            lead: CircleAvatar(
                              backgroundColor: Pallete.blueColor,
                              child: Text(
                                data.marka?.toString() ?? ''.toUpperCase(),
                                style:
                                    const TextStyle(color: Pallete.whiteColor),
                              ),
                            ),
                            tileTitle: Text(
                              data.name?.toString() ?? '',
                            ),
                            tileSubTitle: Text(
                              data.description?.toString() ?? '',
                            ),
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
                                    data.companyId!,
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
