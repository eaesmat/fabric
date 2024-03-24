import 'package:fabricproject/controller/vendorcompany_calculation_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class VendorCalculationListScreen extends StatefulWidget {
  const VendorCalculationListScreen({Key? key}) : super(key: key);

  @override
  State<VendorCalculationListScreen> createState() =>
      _VendorCalculationListScreenState();
}

class _VendorCalculationListScreenState
    extends State<VendorCalculationListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<VendorCompanyCalculationController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<VendorCompanyCalculationController>(context,
                listen: false)
            .getAllVendorCalculation();
      },
      child: Column(
        children: [
          Consumer<VendorCompanyCalculationController>(
            builder: (context, vendorCompanyCalculationController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                // Search textfield
                child: CustomTextFieldWithController(
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    //Passes search box text to the controller
                    vendorCompanyCalculationController
                        .searchVendorCalculationMethod(value);
                  },
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<VendorCompanyCalculationController>(
              builder: (context, vendorCompanyCalculationController, child) {
                final searchForex = vendorCompanyCalculationController
                    .searchVendorCalculation; //data list view
                if (searchForex.isNotEmpty) {
                  return ListView.builder(
                    itemCount: vendorCompanyCalculationController
                        .searchVendorCalculation.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // data vars takes data from controller
                      final data = vendorCompanyCalculationController
                          .searchVendorCalculation[index];
                      return ListTileWidget(
                        tileTitle: Text(
                          data.vendorcompanyName?.toString() ?? '',
                        ),
                        tileSubTitle: Row(
                          children: [
                            Text(
                              "Yen ${data.balanceYen}",
                              style: TextStyle(
                                color: data.balanceDoller! < 0
                                    ? Pallete.redColor
                                    : Colors.black,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "\$ ${data.balanceDoller}",
                              style: TextStyle(
                                color: data.balanceDoller! < 0
                                    ? Pallete.redColor
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  // If no data, display the "noData.png" image
                  return const NoDataFoundWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
