import 'package:fabricproject/controller/customer_deal_controller.dart';
import 'package:fabricproject/controller/customer_deals_controller.dart';
import 'package:fabricproject/controller/customer_payment_controller.dart';
import 'package:fabricproject/screens/customer/customer_details_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/controller/customer_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
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
    // controller class controller to get and send the data
    final customerDealController = Provider.of<CustomerDealController>(context);
    final customerDealsController =
        Provider.of<CustomerDealsController>(context);
    final customerPaymentController =
        Provider.of<CustomerPaymentController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'customers'),
        centerTitle: true,
      ),
      body: Column(
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
                return ListView.builder(
                  itemCount: customerController.searchCustomers?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final reversedList =
                        customerController.searchCustomers!.reversed.toList();
                    final data = reversedList[index];
                    // Initialize variables for both dollar and afghani
                    int totalCostSumDollar = 0;
                    int totalCostSumAfghani = 0;
                    int totalPaymentSumDollar = 0;
                    int totalPaymentSumAfghani = 0;

                    // Loop through customerdeal for both properties
                    if (data.customerdeal != null) {
                      for (var customerDeal in data.customerdeal!) {
                        if (customerDeal.currency == 'doller') {
                          totalCostSumDollar += customerDeal.totalcost ?? 0;
                        } else if (customerDeal.currency == "afghani") {
                          totalCostSumAfghani += customerDeal.totalcost ?? 0;
                        }
                      }
                    }

                    // Loop through customerpayment for both properties
                    if (data.customerpayment != null) {
                      for (var customerPayment in data.customerpayment!) {
                        totalPaymentSumDollar +=
                            customerPayment.amountdoller ?? 0;
                        totalPaymentSumAfghani +=
                            customerPayment.amountafghani ?? 0;
                      }
                    }

                    // Calculate the result for both properties
                    int resultDollar =
                        totalCostSumDollar - totalPaymentSumDollar;
                    int resultAfghani =
                        totalCostSumAfghani - totalPaymentSumAfghani;

                    return ListTileWidget(
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return CustomerDetailsBottomSheet(
                                // pass the these data to the widget
                                data: data,
                                customerName: data.firstname.toString());
                          },
                        );
                      },
                      onTap: () {
                        // pass the the id and data to the fabric purchase controller on click
                        customerDealController.navigateToCustomerDealDetailsScreen(
                            '${data.firstname?.toString() ?? ''} ${data.lastname?.toString() ?? ''}',
                            data.customerId!);
                        customerDealController.customerId =
                            data.customerId!.toInt();

                        customerPaymentController
                            .navigateToCustomerPaymentDetailsScreen(
                                '${data.firstname?.toString() ?? ''} ${data.lastname?.toString() ?? ''}',
                                data.customerId!);
                        customerPaymentController.customerId =
                            data.customerId!.toInt();

                        customerDealsController
                            .getAllCustomerDeals(data.customerId);
                      },
                      lead: CircleAvatar(
                        backgroundColor: Pallete.blueColor,
                        child: Text(
                          data.photo!.toUpperCase(),
                          style: const TextStyle(color: Pallete.whiteColor),
                        ),
                      ),
                      tileTitle: Text(
                        "${data.firstname} ${data.lastname}",
                      ),
                      // Display the result in the tileSubTitle for both dollar and afghani
                      tileSubTitle: Row(
                        children: [
                          Text(
                            '\$ $resultDollar',
                            style: TextStyle(
                              color:
                                  resultDollar < 0 ? Colors.red : Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '$resultAfghani AFG',
                            style: TextStyle(
                              color:
                                  resultAfghani < 0 ? Colors.red : Colors.black,
                            ),
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
                            customerController.navigateToCustomerEdit(
                                data, data.customerId!.toInt());
                          }
                          if (value == "delete") {
                            customerController.deleteCustomer(
                                data.customerId, index);
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
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Pallete.blueColor,
      //   onPressed: () {
      //     customerController.navigateToCustomerCreate();
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     color: Pallete.whiteColor,
      //   ),
      // ),
    );
  }
}
