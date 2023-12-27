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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<SaraiController>(context, listen: false).resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'sarai'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // search text field area
          Consumer<SaraiController>(
            builder: (context, saraiController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                // search textfield
                child: CustomTextFieldWithController(
                  iconBtn: IconButton(
                    icon: const Icon(
                      size: 30,
                      Icons.add_box_rounded,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      // search Icon to create new item
                      saraiController.navigateToSaraiCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    //  pass the search textfield text to search
                    saraiController.searchSarisMethod(value);
                  },
                ),
              );
            },
          ),
          //  data items list view
          Expanded(
            child: Consumer<SaraiController>(
              builder: (context, saraiController, child) {
                return ListView.builder(
                  itemCount: saraiController.searchSarais?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // reverse the data items
                    final reversedList =
                        saraiController.searchSarais!.reversed.toList();
                    final data = reversedList[index];
                    return ListTileWidget(
                      // list tile title
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
                      // tile subtitle
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
                      // tile title trailing
                      // holds delete and update buttons
                      trail: PopupMenuButton(
                        color: Pallete.whiteColor,
                        child: const Icon(Icons.more_vert_sharp),
                        itemBuilder: (context) => <PopupMenuEntry<String>>[
                          // delete button
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
                              // update button
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
                            // edit and pass data and id to the controller
                            saraiController.navigateToSaraiEdit(
                                data, data.saraiId!.toInt());
                          }
                          if (value == "delete") {
                            // edit
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
    );
  }
}
