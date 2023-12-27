import 'package:fabricproject/controller/transport_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class TransportPaymentListScreen extends StatefulWidget {
  const TransportPaymentListScreen({Key? key}) : super(key: key);

  @override
  State<TransportPaymentListScreen> createState() =>
      _TransportPaymentListScreenState();
}

class _TransportPaymentListScreenState
    extends State<TransportPaymentListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<TransportPaymentController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // search part
        Consumer<TransportPaymentController>(
          builder: (context, transportPaymentController, child) {
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
                    transportPaymentController
                        .navigateToTransportPaymentCreate();
                  },
                ),
                lblText: const LocaleText('search'),
                onChanged: (value) {
                  // passes search text to the controller
                  transportPaymentController
                      .searchTransportPaymentMethod(value);
                },
              ),
            );
          },
        ),
        // data list view
        Expanded(
          child: Consumer<TransportPaymentController>(
            builder: (context, transportPaymentController, child) {
              return ListView.builder(
                itemCount:
                    transportPaymentController.searchTransportPayment?.length ??
                        0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // data holds result of controller
                  final reversedList = transportPaymentController
                      .searchTransportPayment!.reversed
                      .toList();
                  final data = reversedList[index];
                  return ListTileWidget(
                    // Tile Title
                    tileTitle: Row(
                      children: [
                        Text(
                          data.person.toString(),
                        ),
                        const Spacer(),
                        Text(
                          data.amount.toString(),
                        ),
                      ],
                    ),
                    // subtitle
                    tileSubTitle: Row(
                      children: [
                        Text(
                          data.date1.toString(),
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
                              LocaleText('update')
                            ],
                          ),
                        ),
                      ],
                      onSelected: (String value) {
                        if (value == "edit") {
                          // navigates to the edit screen
                          transportPaymentController
                              .navigateToTransportPaymentEdit(
                                  data, data.transportpaymentId!.toInt());
                        }
                        if (value == "delete") {
                          transportPaymentController.deleteTransportPayment(
                              data.transportpaymentId, index);
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
