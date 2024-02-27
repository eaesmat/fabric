import 'package:fabricproject/controller/transport_controller.dart';
import 'package:fabricproject/controller/transport_deals_controller.dart';
import 'package:fabricproject/controller/transport_payment_controller.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class TransportListScreen extends StatefulWidget {
  const TransportListScreen({Key? key}) : super(key: key);

  @override
  State<TransportListScreen> createState() => _TransportListScreenState();
}

class _TransportListScreenState extends State<TransportListScreen> {
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
    // controller providers to send and get data from
    final transportDealsController =
        Provider.of<TransportDealsController>(context);
    // final transportPayment = Provider.of<TransportPaymentController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'transports'),
        centerTitle: true,
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          // Implement your refresh logic here
          await Provider.of<TransportController>(context, listen: false)
              .getAllTransports();
        },
        child: Column(
          children: [
            // search part

            Consumer<TransportController>(
              builder: (context, transportController, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomTextFieldWithController(
                    // create new item here
                    iconBtn: IconButton(
                      icon: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      onPressed: () {
                        // search Icon to create new item
                        transportController.navigateToTransportCreate();
                      },
                    ),
                    lblText: const LocaleText('search'),
                    onChanged: (value) {
                      // passes search text to the controller
                      transportController.searchTransportsMethod(value);
                    },
                  ),
                );
              },
            ),
            // data list view

            Expanded(
              child: Consumer<TransportController>(
                builder: (context, transportController, child) {
                  return ListView.builder(
                    itemCount: transportController.searchTransports.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // data holds result of controller

                      final reversedList = transportController
                          .searchTransports.reversed
                          .toList();
                      final data = reversedList[index];
                      return ListTileWidget(
                        onTap: () {
                          // pass the id and name to the transport deal controller
                          transportDealsController
                              .navigateToTransportDealDetailsScreen(
                            data.name.toString(),
                            data.transportId!,
                          );

// pass name and id to the transport payment controller
                          // transportPayment.navigateToTransportDealDetailsScreen(
                          //   data.name.toString(),
                          //   data.transportId!.toInt(),
                          // );

                          // transportPayment.transportId =
                          //     data.transportId!.toInt();
                        },
                        tileTitle: Text(
                          data.name.toString(),
                        ),
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
                        // delete and update operations happens here
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
                              transportController.navigateToTransportEdit(
                                  data, data.transportId!.toInt());
                            }
                            if (value == "delete") {
                              transportController
                                  .deleteTransport(data.transportId!.toInt());
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
      ),
    );
  }
}
