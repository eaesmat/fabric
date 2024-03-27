import 'package:fabricproject/controller/customer_balance_controller.dart';
import 'package:fabricproject/controller/customer_controller.dart';
import 'package:fabricproject/controller/customer_deals_controller.dart';
import 'package:fabricproject/controller/customer_rasidat_controller.dart';
import 'package:fabricproject/controller/customer_sales_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CustomerBalanceListScreen extends StatefulWidget {
  const CustomerBalanceListScreen({Key? key}) : super(key: key);

  @override
  State<CustomerBalanceListScreen> createState() =>
      _CustomerBalanceListScreenState();
}

class _CustomerBalanceListScreenState extends State<CustomerBalanceListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<CustomerBalanceController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    final customerSalesController =
        Provider.of<CustomerSalesController>(context);
    final customerDealsController =
        Provider.of<CustomerDealsController>(context);
    final customerRasidatController =
        Provider.of<CustomerRasidatController>(context);
    final customerController =
        Provider.of<CustomerController>(context, listen: false);
    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<CustomerBalanceController>(context, listen: false)
            .getAllCustomerBalance();
      },
      child: Column(
        children: [
          Consumer<CustomerBalanceController>(
            builder: (context, customerBalanceController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                // Search textfield
                child: CustomTextFieldWithController(
                  iconBtn: IconButton(
                    icon: const Icon(
                      size: 30,
                      Icons.add_box_rounded,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      // search Icon to create new item
                      customerController.navigateToCustomerCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    //Passes search box text to the controller
                    customerBalanceController
                        .searchCustomerBalanceMethod(value);
                  },
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<CustomerBalanceController>(
              builder: (context, customerBalanceController, child) {
                final reversedList = customerBalanceController
                    .searchCustomerBalance.reversed
                    .toList();

                if (reversedList.isNotEmpty) {
                  return ListView.builder(
                    itemCount: reversedList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // data vars takes data from controller
                      final data = reversedList[index];
                      return ListTileWidget(
                        onTap: () {
                          customerDealsController
                              .navigateToCustomerDealDetailsScreen(
                            "${data.firstname}  ${data.lastname}",
                            data.customerId!,
                          );
                          customerSalesController
                              .getAllCustomerSales(data.customerId!);
                          customerRasidatController
                              .geAllCustomerRasidat(data.customerId!);
                        },
                        tileTitle: Text(
                          "${data.firstname} ${data.lastname}",
                        ),
                        tileSubTitle: Row(
                          children: [
                            Row(
                              children: [
                                Flag.fromCode(FlagsCode.US,
                                    height: 15, width: 15),
                                const SizedBox(
                                  width: 3,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    "${data.dueDoller}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: data.dueDoller! < 0
                                            ? Pallete.redColor
                                            : null),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    "${data.dueAfghani}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: data.dueAfghani! < 0
                                            ? Pallete.redColor
                                            : null),
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Flag.fromCode(FlagsCode.AF,
                                    height: 15, width: 15),
                              ],
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
