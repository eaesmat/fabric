import 'package:fabricproject/controller/sarai_controller.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class SaraiListScreen extends StatefulWidget {
  const SaraiListScreen({Key? key}) : super(key: key);

  @override
  State<SaraiListScreen> createState() => _SaraiListScreenState();
}

class _SaraiListScreenState extends State<SaraiListScreen> {
  @override
  Widget build(BuildContext context) {
    final saraiController =
        Provider.of<SaraiController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'sarai'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<SaraiController>(
            builder: (context, saraiController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    saraiController.searchSarisMethod(value);
                  },
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<SaraiController>(
              builder: (context, saraiController, child) {
                return ListView.builder(
                  itemCount: saraiController.searchSarais?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = saraiController.searchSarais![index];
                    return ListTileWidget(
                      tileTitle: Row(
                        children: [
                          Text(
                            data.name.toString(),
                          ),
                          const Spacer(),
                          Text(
                            data.phone.toString(),
                          ),
                        ],
                      ),
                      tileSubTitle: Row(
                        children: [
                          Text(
                            data.description.toString(),
                          ),
                          const Spacer(),
                          Text(
                            data.location.toString(),
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
                            saraiController.navigateToSaraiEdit(
                                data, data.saraiId!.toInt());
                          }
                          if (value == "delete") {
                            saraiController.deleteSarai(data.saraiId, index);
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
          saraiController.navigateToSaraiCreate();
        },
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
        ),
      ),
    );
  }
}
