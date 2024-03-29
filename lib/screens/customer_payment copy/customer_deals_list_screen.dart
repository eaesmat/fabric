import 'package:fabricproject/controller/customer_deals_controller.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CustomerDealsListScreen extends StatefulWidget {
  const CustomerDealsListScreen({Key? key}) : super(key: key);

  @override
  State<CustomerDealsListScreen> createState() =>
      _CustomerDealsListScreenState();
}

class _CustomerDealsListScreenState extends State<CustomerDealsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<CustomerDealsController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              return ListView.builder(
                itemCount:
                    customerDealsController.searchCustomersDeals?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // data holds result of controller
                  final data =
                      customerDealsController.searchCustomersDeals![index];
                  return ListTileWidget(
                    // circular avatar
                    lead: CircleAvatar(
                      backgroundColor: Pallete.blueColor,
                      child: data.type == "فروش"
                          ? const Icon(Icons.shopping_bag_rounded,
                              color: Pallete.whiteColor)
                          : const Icon(Icons.draw, color: Pallete.whiteColor),
                    ),

                    // Tile Title
                    tileTitle: Text(
                      data.begaknumber?.toString() ?? '',
                    ),

                    // subtitle
                    tileSubTitle: Row(
                      children: [
                        Text(
                          data.date.toString(),
                        ),
                        const Spacer(),
                        Text(
                          data.balanceDoller.toString(),
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
    );
  }
}
