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
  Widget build(BuildContext context) {
    final customerController = Provider.of<CustomerController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'customers'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<CustomerController>(
            builder: (context, customerController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    customerController.searchCustomer(value);
                  },
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<CustomerController>(
              builder: (context, customerController, child) {
                return ListView.builder(
                  itemCount: customerController.searchCustomers?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = customerController.searchCustomers![index];
                    return ListTileWidget(
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
                      tileSubTitle: Text(data.address.toString()),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.blueColor,
        onPressed: () {
          customerController.navigateToCustomerCreate();
        },
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
        ),
      ),
    );
  }
}
