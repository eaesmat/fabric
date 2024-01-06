import 'package:fabricproject/controller/transport_deal_controller.dart';
import 'package:fabricproject/model/transport_deal_model.dart';
import 'package:fabricproject/screens/transport_deal/transport_deal_item_details.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class TransportDealListScreen extends StatefulWidget {
  final int transportId;
  final String transportName;
  const TransportDealListScreen({
    Key? key,
    required this.transportId,
    required this.transportName,
  }) : super(key: key);

  @override
  State<TransportDealListScreen> createState() =>
      _TransportDealListScreenState();
}

class _TransportDealListScreenState extends State<TransportDealListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<TransportDealController>(
          builder: (context, transportDealController, child) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomTextFieldWithController(
                iconBtn: IconButton(
                  icon: const Icon(
                    Icons.add_box,
                    color: Pallete.blueColor,
                  ),
                  onPressed: () {
                    transportDealController.navigateToTransportDealCreate();
                  },
                ),
                lblText: const LocaleText('search'),
                onChanged: (value) {
                  transportDealController.searchTransportDealMethod(value);
                },
              ),
            );
          },
        ),
        Expanded(
          child: Consumer<TransportDealController>(
            builder: (context, transportDealController, child) {
              return ListView.builder(
                itemCount:
                    transportDealController.searchTransportDeals?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data =
                      transportDealController.searchTransportDeals![index];

                  return ListTileWidget(
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          List<ContainerModel> containers =
                              (data.container ?? []).cast<ContainerModel>();

                          return TransportItemDetailsBottomSheet(
                            data: data,
                            transportName: data.transport!.name.toString(),
                            containerList: containers,
                          );
                        },
                      );
                    },
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
                          "${data.fabricpurchase!.fabricpurchasecode}",
                        ),
                        const Spacer(),
                        Text(
                          data.container != null && data.container!.isNotEmpty
                              ? data.container![0].name ?? 'No Container'
                              : 'No Container',
                        ),
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
                            )),
                      ],
                      onSelected: (String value) {
                        if (value == "edit") {
                          final containerId = data.container != null &&
                                  data.container!.isNotEmpty
                              ? data.container![0].containerId!.toInt()
                              : null;

                          final saraiId = data.saraiindeal != null &&
                                  data.saraiindeal!.isNotEmpty
                              ? data.saraiindeal![0].saraiId
                              : null;

                          final saraiInDealId = data.saraiindeal != null &&
                                  data.saraiindeal!.isNotEmpty
                              ? data.saraiindeal![0].saraiindealId
                              : null;

                          final saraiInDate = data.saraiindeal != null &&
                                  data.saraiindeal!.isNotEmpty
                              ? data.saraiindeal![0].indate.toString()
                              : '';

                          transportDealController.navigateToTransportDealEdit(
                            data,
                            data.transportdealId!.toInt(),
                            containerId,
                            saraiId,
                            saraiInDealId,
                            saraiInDate,
                          );
                        }

                        if (value == "delete") {
                          transportDealController.deleteTransportDeal(
                              data.transportdealId, index);
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
