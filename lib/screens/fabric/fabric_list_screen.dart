import 'package:fabricproject/controller/fabric_controller.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class FabricListScreen extends StatefulWidget {
  const FabricListScreen({Key? key}) : super(key: key);

  @override
  State<FabricListScreen> createState() => _FabricListScreenState();
}

class _FabricListScreenState extends State<FabricListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'fabrics'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<FabricController>(
            builder: (context, fabricController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
// search textfield
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
                      fabricController.navigateToFabricCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
// Pass search text to the controller
                    fabricController.searchFabricsMethod(value);
                  },
                ),
              );
            },
          ),
// data list
          Expanded(
            child: Consumer<FabricController>(
              builder: (context, fabricController, child) {
                return ListView.builder(
                  itemCount: fabricController.searchFabrics?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
// data comes from controller class
                    final reversedList =
                        fabricController.searchFabrics!.reversed.toList();
                    final data = reversedList[index];
                    return ListTileWidget(
                      lead: CircleAvatar(
                        backgroundColor: Pallete.blueColor,
                        child: Text(
                          data.abr!.toUpperCase(),
                          style: const TextStyle(color: Pallete.whiteColor),
                        ),
                      ),
                      tileTitle: Text(
                        data.name.toString(),
                      ),
// delete and update operations happens here
                      tileSubTitle: Text(data.description.toString()),
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
// navigate to the edit screen passes data and id to the controller
                            fabricController.navigateToFabricEdit(
                                data, data.fabricId!.toInt());
                          }
// delete the item and passes the id and index to the controller
                          if (value == "delete") {
                            fabricController.deleteFabric(data.fabricId, index);
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
