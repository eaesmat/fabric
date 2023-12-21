import 'package:fabricproject/controller/transport_controller.dart';
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
  State<TransportListScreen> createState() =>
      _TransportListScreenState();
}

class _TransportListScreenState extends State<TransportListScreen> {
  @override
  Widget build(BuildContext context) {
    final transportController =
        Provider.of<TransportController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'transports'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<TransportController>(
            builder: (context, transportController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    transportController.searchTransportsMethod(value);
                  },
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<TransportController>(
              builder: (context, transportController, child) {
                return ListView.builder(
                  itemCount:
                      transportController.searchTransports?.length ??
                          0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data =
                        transportController.searchTransports![index];
                    return ListTileWidget(
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
                            transportController.navigateToTransportEdit(
                                data, data.transportId!.toInt());
                          }
                          if (value == "delete") {
                            transportController.deleteTransport(
                                data.transportId, index);
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
          transportController.navigateToTransportCreate();
        },
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
        ),
      ),
    );
  }
}
