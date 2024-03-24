import 'package:fabricproject/controller/khalid_rasid_controller.dart';
import 'package:fabricproject/screens/khalid_rasid/khalid_rasid_item_details.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class VendorCompanyRasidListScreen extends StatefulWidget {
  final String vendorCompanyName;
  final int vendorCompanyId;
  const VendorCompanyRasidListScreen({
    Key? key,
    required this.vendorCompanyId,
    required this.vendorCompanyName,
  }) : super(key: key);

  @override
  State<VendorCompanyRasidListScreen> createState() =>
      _VendorCompanyRasidListScreenState();
}

class _VendorCompanyRasidListScreenState
    extends State<VendorCompanyRasidListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<KhalidRasidController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<KhalidRasidController>(context, listen: false)
            .getAllKhalidRasids();
      },
      child: Column(
        children: [
          Consumer<KhalidRasidController>(
            builder: (context, khalidRasidController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
                  iconBtn: IconButton(
                      icon: const Icon(
                        Icons.add_box,
                        color: Pallete.blueColor,
                      ),
                      onPressed: () {
                        khalidRasidController.navigateToKhalidRasidCreate('vendorcompany');
                        khalidRasidController.selectedVendorCompanyId.text =
                            widget.vendorCompanyId.toString();
                        khalidRasidController.selectedVendorCompanyName.text =
                            widget.vendorCompanyName;
                      }),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    khalidRasidController.searchKhalidRasidsMethod(value);
                  },
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<KhalidRasidController>(
              builder: (context, khalidRasidController, child) {
                final reversedList =
                    khalidRasidController.searchKhalidRasids.reversed.toList();

                // Filtered list to hold only matched items
                final matchedItems = reversedList
                    .where((data) =>
                        data.vendorcompanyId == widget.vendorCompanyId)
                    .toList();

                if (matchedItems.isEmpty) {
                  // If no matched items, display the "NoDataFoundWidget"
                  return const NoDataFoundWidget();
                }

                return ListView.builder(
                  itemCount: matchedItems.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = matchedItems[index];
                    return ListTileWidget(
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return KhalidRasidItemDetailsBottomSheet(
                              data: data,
                              vendorCompanyName:
                                  data.vendorcompanyName.toString(),
                            );
                          },
                        );
                      },
                      lead: CircleAvatar(
                        backgroundColor: Pallete.blueColor,
                        child: Text(
                          "${data.photo}",
                          style: const TextStyle(color: Pallete.whiteColor),
                        ),
                      ),
                      tileTitle: Row(
                        children: [
                          Text(
                            data.sarafiName.toString(),
                          ),
                          const Spacer(),
                          Text(
                            "${data.drawDate}",
                          ),
                        ],
                      ),
                      tileSubTitle: Row(
                        children: [
                          Text(
                            data.vendorcompanyName.toString(),
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '\$ ${data.doller.toString()}',
                                  ),
                                ],
                              ),
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
                                LocaleText('update'),
                              ],
                            ),
                          ),
                        ],
                        onSelected: (String value) {
                          if (value == "edit") {
                            khalidRasidController.navigateToKhalidRasidEdit(
                                data, data.drawId!.toInt(), 'vendorcompany');
                          }
                          if (value == "delete") {
                            khalidRasidController.deleteKhalidRasid(
                              data.drawId!.toInt(),
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