import 'package:fabricproject/controller/customer_deals_controller.dart';
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

class CustomerDealsListScreen extends StatefulWidget {
  final int customerId;
  const CustomerDealsListScreen({
    Key? key,
    required this.customerId,
  }) : super(key: key);

  @override
  State<CustomerDealsListScreen> createState() =>
      _CustomerDealsListScreenState();
}

class _CustomerDealsListScreenState extends State<CustomerDealsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<CustomerDealsController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<CustomerDealsController>(context, listen: false)
            .getAllCustomerDeals(widget.customerId);
      },
      child: Column(
        children: [
          // search part
          Consumer<CustomerDealsController>(
            builder: (context, customerDealsController, child) {
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
                    customerDealsController.searchCustomerDealMethod(value);
                  },
                ),
              );
            },
          ),
          // data list view
          Expanded(
            child: Consumer<CustomerDealsController>(
              builder: (context, customerDealsController, child) {
                if (customerDealsController.searchCustomersDeals.isEmpty) {
                  return const NoDataFoundWidget();
                }
                return ListView.builder(
                  itemCount:
                      customerDealsController.searchCustomersDeals.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // data holds result of controller
                    final data =
                        customerDealsController.searchCustomersDeals[index];
                    return ListTileWidget(
                      // circular avatar
                      lead: CircleAvatar(
                        backgroundColor:
                            data.type == 'فروش' ? Colors.green : Colors.red,
                        child: data.type == "فروش"
                            ? const Icon(Icons.shopping_bag_rounded,
                                color: Pallete.whiteColor)
                            : const Icon(Icons.draw, color: Pallete.whiteColor),
                      ),

                      // Tile Title
                      tileTitle: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Flag.fromCode(FlagsCode.US,
                                      height: 15, width: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 3,
                                    ),
                                    child: Text(
                                      " ${data.doller ?? ''}",
                                      style: TextStyle(
                                        color: (data.doller ?? 0) < 0
                                            ? Pallete.redColor
                                            : null,
                                      ),
                                    ),
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
                                      "${data.balanceDoller ?? ''}  ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: (data.balanceDoller ?? 0) < 0
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
                                  Flag.fromCode(FlagsCode.AF,
                                      height: 15, width: 15),
                                  Text(
                                    " ${data.afghani ?? ''}",
                                    style: TextStyle(
                                      color: (data.afghani ?? 0) < 0
                                          ? Pallete.redColor
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                      "${data.balanceAfghani ?? ''}  ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: (data.balanceAfghani ?? 0) < 0
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
                                Row(
                                  children: [
                                    Text(data.begakNumber?.toString() ?? '0'),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.confirmation_num_rounded,
                                      color: Pallete.blueColor,
                                      size: 15,
                                    ),
                                  ],
                                ),
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
