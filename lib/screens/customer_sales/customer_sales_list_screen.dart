import 'package:fabricproject/controller/customer_sales_controller.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CustomerSalesListScreen extends StatefulWidget {
  final int customerId;
  const CustomerSalesListScreen({
    Key? key,
    required this.customerId,
  }) : super(key: key);

  @override
  State<CustomerSalesListScreen> createState() =>
      _CustomerSalesListScreenState();
}

class _CustomerSalesListScreenState extends State<CustomerSalesListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<CustomerSalesController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<CustomerSalesController>(context, listen: false)
            .getAllCustomerSales(widget.customerId);
      },
      child: Column(
        children: [
          // search part
          Consumer<CustomerSalesController>(
            builder: (context, customerSalesController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
                  iconBtn: IconButton(
                    icon: const Icon(
                      Icons.add_box_rounded,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      // search Icon to create new item
                      // companyController.navigateToCompanyCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // passes search text to the controller
                    customerSalesController.searchCustomerSalesMethod(value);
                  },
                ),
              );
            },
          ),
          // data list view
          Expanded(
            child: Consumer<CustomerSalesController>(
              builder: (context, customerSalesController, child) {
                if (customerSalesController.searchCustomersSales.isEmpty) {
                  return const NoDataFoundWidget();
                }
                return ListView.builder(
                  itemCount:
                      customerSalesController.searchCustomersSales.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // data holds result of controller
                    final data =
                        customerSalesController.searchCustomersSales[index];
                    return ListTileWidget(
                      // circular avatar

                      // Tile Title
                      tileTitle: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.confirmation_num_rounded,
                                    color: Pallete.blueColor,
                                    size: 17,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                        data.begakNumber?.toString() ?? '0'),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 3,
                                    ),
                                    child: Text(
                                      "${data.dollor ?? ''}  ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: (data.dollor ?? 0) < 0
                                            ? Pallete.redColor
                                            : null,
                                      ),
                                    ),
                                  ),
                                  Flag.fromCode(FlagsCode.US,
                                      height: 15, width: 15),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      // subtitle
                      tileSubTitle: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  const LocaleText('war'),
                                  Text(
                                    " ${data.war ?? '0'}",
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                      "${data.afghani ?? ''}  ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: (data.afghani ?? 0) < 0
                                            ? Pallete.redColor
                                            : null,
                                      ),
                                    ),
                                  ),
                                  Flag.fromCode(FlagsCode.AF,
                                      height: 15, width: 15),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.date_range,
                                      color: Pallete.blueColor,
                                      size: 17,
                                    ),
                                    const SizedBox(
                                      width: 1,
                                    ),
                                    Text(data.date?.toString() ?? ''),
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // trailing hold delete and update buttons
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
