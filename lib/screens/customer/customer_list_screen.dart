import 'package:fabricproject/controller/customer_deals_controller.dart';
import 'package:fabricproject/controller/customer_rasidat_controller.dart';
import 'package:fabricproject/controller/customer_sales_controller.dart';
import 'package:fabricproject/screens/customer/customer_details_bottom_sheet.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/controller/customer_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({Key? key}) : super(key: key);

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<CustomerController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    final customerDealsController =
        Provider.of<CustomerDealsController>(context);
    final customerSalesController =
        Provider.of<CustomerSalesController>(context);
    final customerRasidatController =
        Provider.of<CustomerRasidatController>(context);

    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<CustomerController>(context, listen: false)
            .getAllCustomers();
      },
      child: Column(
        children: [
          // search widget
          Consumer<CustomerController>(
            builder: (context, customerController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
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
                  // search text field
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // pass the text data to search method
                    customerController.searchCustomer(value);
                  },
                ),
              );
            },
          ),
          // data list view
          Expanded(
            child: Consumer<CustomerController>(
              builder: (context, customerController, child) {
                final reversedList =
                    customerController.searchCustomers.reversed.toList();
                if (reversedList.isEmpty) {
                  return const NoDataFoundWidget();
                }
                return ListView.builder(
                  itemCount: reversedList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
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
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return CustomerDetailsBottomSheet(
                              data: data,
                              customerName: data.firstname.toString(),
                            );
                          },
                        );
                      },
                      lead: CircleAvatar(
                        backgroundColor: Pallete.blueColor,
                        child: Text(
                          data.photo!.toUpperCase(),
                          style: const TextStyle(
                            color: Pallete.whiteColor,
                          ),
                        ),
                      ),
                      tileTitle: Row(
                        children: [
                          Text("${data.firstname} ${data.lastname}"),
                          const Spacer(),
                          Text(data.phone.toString()),
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
                            customerController.navigateToCustomerEdit(
                                data, data.customerId!.toInt());
                          }
                          if (value == "delete") {
                            customerController.deleteCustomer(
                              data.customerId!,
                            );
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
