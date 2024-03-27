import 'package:fabricproject/controller/customer_rasidat_controller.dart';
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

class CustomerRasidatListScreen extends StatefulWidget {
  final int customerId;
  const CustomerRasidatListScreen({
    Key? key,
    required this.customerId,
  }) : super(key: key);

  @override
  State<CustomerRasidatListScreen> createState() =>
      _CustomerRasidatListScreenState();
}

class _CustomerRasidatListScreenState extends State<CustomerRasidatListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<CustomerRasidatController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<CustomerRasidatController>(context, listen: false)
            .geAllCustomerRasidat(widget.customerId);
      },
      child: Column(
        children: [
          Consumer<CustomerRasidatController>(
            builder: (context, customerRasidatController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
                  iconBtn: IconButton(
                    icon: const Icon(
                      Icons.add_box,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      customerRasidatController
                          .navigateToCustomerRasidatCreate(widget.customerId);
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    customerRasidatController
                        .searchCustomerRasidatMethod(value);
                  },
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<CustomerRasidatController>(
              builder: (context, customerRasidatController, child) {
                final searchData = customerRasidatController
                    .searchCustomerRasidat.reversed
                    .toList();
                if (searchData.isEmpty) {
                  return const NoDataFoundWidget();
                } else {
                  return ListView.builder(
                    itemCount: searchData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final data = searchData[index];

                      return ListTileWidget(
                        // Tile Title
                        tileTitle: Column(
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(data.person?.toString() ?? ''),
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
                                    Text(data.date?.toString() ?? ''),
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
                            Row(
                              children: [
                                Text(data.description?.toString() ?? ''),
                              ],
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
                              customerRasidatController
                                  .navigateToCustomerRasidatEdit(
                                data,
                              );
                            }
                            if (value == "delete") {
                              customerRasidatController.deleteCustomerRasidat(
                                data.rasidId!,
                              );
                            }
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
