import 'package:fabricproject/controller/transport_deals_controller.dart';
import 'package:fabricproject/screens/customer_deal/transport_deal_item_details.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class TransportDealsListScreen extends StatefulWidget {
  final int transportId;
  final String transportName;
  const TransportDealsListScreen({
    Key? key,
    required this.transportId,
    required this.transportName,
  }) : super(key: key);

  @override
  State<TransportDealsListScreen> createState() =>
      _TransportDealsListScreenState();
}

class _TransportDealsListScreenState extends State<TransportDealsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<TransportDealsController>(
          builder: (context, transportDealsController, child) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomTextFieldWithController(
                iconBtn: IconButton(
                  icon: const Icon(
                    Icons.add_box,
                    color: Pallete.blueColor,
                  ),
                  onPressed: () {
                    transportDealsController
                        .navigateToTransportDealCreate(widget.transportId);
                  },
                ),
                lblText: const LocaleText('search'),
                onChanged: (value) {
                  transportDealsController.searchTransportDealsMethod(value);
                },
              ),
            );
          },
        ),
        Expanded(
          child: Consumer<TransportDealsController>(
            builder: (context, transportDealsController, child) {
              return ListView.builder(
                itemCount:
                    transportDealsController.searchTransportDeals?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data =
                      transportDealsController.searchTransportDeals![index];

                  return ListTileWidget(
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return TransportItemDetailsBottomSheet(
                            data: data,
                            transportName: widget.transportName,
                          );
                        },
                      );
                    },
                    tileTitle: Row(
                      children: [
                        Text(
                          "${data.fabricpurchasecode}",
                        ),
                        const Spacer(),
                        Text(data.containerName.toString()),
                      ],
                    ),
                    tileSubTitle: Row(
                      children: [
                        Text(
                          data.startdate.toString(),
                        ),
                        const Spacer(),
                        Text(
                          data.arrivaldate.toString(),
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
                          transportDealsController.navigateToTransportDealsEdit(
                            data,
                            data.transportdealId!.toInt(),
                            widget.transportId,
                          );
                        }
                        if (value == "delete") {
                          // transportController
                          //     .deleteTransport(data.transportId!.toInt());
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
