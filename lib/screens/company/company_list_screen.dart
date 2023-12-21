import 'package:fabricproject/controller/company_controller.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({Key? key}) : super(key: key);

  @override
  State<CompanyListScreen> createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<CompanyController>(context, listen: false).resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'companies'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // search part
          Consumer<CompanyController>(
            builder: (context, companyController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
// create new item here
                  iconBtn: IconButton(
                    icon: const Icon(
                      size: 30,
                      Icons.add_box_rounded,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      // search Icon to create new item
                      companyController.navigateToCompanyCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // passes search text to the controller
                    companyController.searchCompaniesMethod(value);
                  },
                ),
              );
            },
          ),
          // data list view
          Expanded(
            child: Consumer<CompanyController>(
              builder: (context, companyController, child) {
                return ListView.builder(
                  itemCount: companyController.searchCompanies?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // data holds result of controller
                    final reversedList =
                        companyController.searchCompanies!.reversed.toList();
                    final data = reversedList[index];
                    return ListTileWidget(
                      // circular avatar
                      lead: CircleAvatar(
                        backgroundColor: Pallete.blueColor,
                        child: Text(
                          data.marka!.toUpperCase(),
                          style: const TextStyle(color: Pallete.whiteColor),
                        ),
                      ),
                      // Tile Title
                      tileTitle: Text(
                        data.name.toString(),
                      ),
                      // subtitle
                      tileSubTitle: Text(
                        data.description.toString(),
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
                              )),
                          const PopupMenuItem(
                            value: "edit",
                            child: Row(
                              children: [
                                Icon(Icons.edit),
                                SizedBox(
                                  width: 10,
                                ),
                                LocaleText('update')
                              ],
                            ),
                          ),
                        ],
                        onSelected: (String value) {
                          if (value == "edit") {
                            // navigates to the edit screen
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
