import 'package:fabricproject/controller/customer_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CustomerPaymentListScreen extends StatefulWidget {
  final int customerId;
  final String customerName;
  const CustomerPaymentListScreen({
    Key? key,
    required this.customerId,
    required this.customerName,
  }) : super(key: key);

  @override
  State<CustomerPaymentListScreen> createState() =>
      _CustomerPaymentListScreenState();
}

class _CustomerPaymentListScreenState extends State<CustomerPaymentListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<CustomerPaymentController>(
          builder: (context, customerPaymentController, child) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomTextFieldWithController(
                iconBtn: IconButton(
                  icon: const Icon(
                    Icons.add_box,
                    color: Pallete.blueColor,
                  ),
                  onPressed: () {
                    customerPaymentController.navigateToCustomerPaymentCreate();
                  },
                ),
                lblText: const LocaleText('search'),
                onChanged: (value) {
                  customerPaymentController.searchCustomerPaymentMethod(value);
                },
              ),
            );
          },
        ),
        Expanded(
          child: Consumer<CustomerPaymentController>(
            builder: (context, customerPaymentController, child) {
              return ListView.builder(
                itemCount:
                    customerPaymentController.searchCustomersPayments?.length ??
                        0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data =
                      customerPaymentController.searchCustomersPayments![index];

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
                        Text(data.amountafghani.toString()),
                      ],
                    ),
                    tileSubTitle: Row(
                      children: [
                        Text(
                          data.amountdollar.toString(),
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
                          customerPaymentController
                              .navigateToCustomerPaymentEdit(
                                  data.customerpaymentId!.toInt(), data);
                        }
                        if (value == "delete") {
                          customerPaymentController.deleteCustomerDeal(
                              data.customerpaymentId, index);
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
