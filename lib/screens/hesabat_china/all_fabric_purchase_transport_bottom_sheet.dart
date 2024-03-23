import 'package:fabricproject/controller/all_fabric_purchases_controller.dart';
import 'package:fabricproject/controller/transport_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class TransportBottomSheet extends StatefulWidget {
  const TransportBottomSheet({super.key});

  @override
  State<TransportBottomSheet> createState() => _TransportBottomSheetState();
}

class _TransportBottomSheetState extends State<TransportBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<TransportController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    // controller provider
    // fabric purchase controller to pass the selected id to the fabric purchase controller
    final transportController = Provider.of<TransportController>(context);
    final allFabricPurchasesController =
        Provider.of<AllFabricPurchasesController>(context);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.all(16.0),
        color: Pallete.whiteColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                // search text filed
                child: CustomTextFieldWithController(
                  // create button in the search text filed
                  iconBtn: IconButton(
                    icon: const Icon(
                      size: 30,
                      Icons.add_box_rounded,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      // to create new
                      transportController.navigateToTransportCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // searches item
                    transportController.searchTransportsMethod(value);
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: transportController.searchTransports.length,
                itemBuilder: (context, index) {
                  // data gets data from controller
                  final reversedList =
                      transportController.searchTransports.reversed.toList();
                  final data = reversedList[index];
                  return ListTileWidget(
                    onTap: () {
                      // Pass item id when clicked
                      allFabricPurchasesController.selectedTransportId.text =
                          data.transportId!.toString();
                      // Pass name when clicked
                      allFabricPurchasesController.selectedTransportName.text =
                          '${data.name}';
                      Navigator.pop(context);
                    },
                    // Tile Title

                    tileTitle: Text(
                      data.name.toString(),
                    ),
                    // subtitle

                    tileSubTitle: Row(
                      children: [
                        Text(
                          data.description.toString(),
                        ),
                        const Spacer(),
                        Text(
                          data.phone.toString(),
                        ),
                      ],
                    ),
                    // trailing hold delete and update buttons

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
                          // navigates to the edit screen

                          transportController.navigateToTransportEdit(
                              data, data.transportId!.toInt());
                        }
                        if (value == "delete") {
                          transportController.deleteTransport(
                              data.transportId!.toInt());
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
