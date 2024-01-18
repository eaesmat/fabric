import 'package:fabricproject/controller/customer_deal_controller.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CustomerDealListScreen extends StatefulWidget {
  final int customerId;
  final String customerName;
  const CustomerDealListScreen({
    Key? key,
    required this.customerId,
    required this.customerName,
  }) : super(key: key);

  @override
  State<CustomerDealListScreen> createState() => _CustomerDealListScreenState();
}

class _CustomerDealListScreenState extends State<CustomerDealListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<CustomerDealController>(
          builder: (context, customerDealController, child) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomTextFieldWithController(
                iconBtn: IconButton(
                  icon: const Icon(
                    Icons.add_box,
                    color: Pallete.blueColor,
                  ),
                  onPressed: () {
                    // customerDealController.navigateToCustomerDealCreate();
                  },
                ),
                lblText: const LocaleText('search'),
                onChanged: (value) {
                  customerDealController.searchCustomerDealMethod(value);
                },
              ),
            );
          },
        ),
        Expanded(
          child: Consumer<CustomerDealController>(
            builder: (context, customerDealController, child) {
              return ListView.builder(
                itemCount:
                    customerDealController.searchCustomersDeals?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data =
                      customerDealController.searchCustomersDeals![index];

                  return ListTileWidget(
                    // onLongPress: () {
                    //   showModalBottomSheet(
                    //     context: context,
                    //     isScrollControlled: true,
                    //     builder: (BuildContext context) {
                    //       List<ContainerModel> containers =
                    //           (data.container ?? []).cast<ContainerModel>();

                    //       return TransportItemDetailsBottomSheet(
                    //         data: data,
                    //         transportName: data.transport!.name.toString(),
                    //         containerList: containers,
                    //       );
                    //     },
                    //   );
                    // },
                    // lead: CircleAvatar(
                    //   backgroundColor: Pallete.blueColor,
                    //   child: Text(
                    //     data.duration.toString(),
                    //     style: const TextStyle(color: Pallete.whiteColor),
                    //   ),
                    // ),
                    tileTitle: Row(
                      children: [
                        Text(
                          "${data.customerId}",
                        ),
                        const Spacer(),
                        Text(data.bundlecount.toString()),
                      ],
                    ),
                    tileSubTitle: Row(
                      children: [
                        Text(
                          data.begaknumber.toString(),
                        ),
                        const Spacer(),
                        Text(
                          data.date.toString(),
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
                              LocaleText('update')
                            ],
                          ),
                        ),
                      ],
                      onSelected: (String value) {
                        if (value == "edit") {
                          // fabricDesignController.navigateToFabricDesignEdit(
                          //     data, data.fabricdesignId!.toInt());
                        }
                        if (value == "delete") {
                          // fabricDesignController.deleteFabricDesign(
                          //     data.fabricdesignId, index);
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
    );
  }
}
