import 'package:fabricproject/controller/forex_controller.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class ForexListScreen extends StatefulWidget {
  const ForexListScreen({Key? key}) : super(key: key);

  @override
  State<ForexListScreen> createState() => _ForexListScreenState();
}

class _ForexListScreenState extends State<ForexListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'forex'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<ForexController>(
            builder: (context, forexController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                // Search textfield
                child: CustomTextFieldWithController(
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    //Passes search box text to the controller
                    forexController.searchForexMethod(value);
                  },
                  iconBtn: IconButton(
                    icon: const Icon(
                      size: 30,
                      Icons.add_box_rounded,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      // search Icon to create new item
                      forexController.navigateToForexCreate();
                    },
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<ForexController>(
              builder: (context, forexController, child) {
                //data list view
                return ListView.builder(
                  itemCount: forexController.searchForex?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // data vars takes data from controller
                    final reversedList =
                        forexController.searchForex!.reversed.toList();
                    final data = reversedList[index];
                    return ListTileWidget(
                      lead: CircleAvatar(
                        backgroundColor: Pallete.blueColor,
                        child: Text(
                          data.shopno.toString(),
                          style: const TextStyle(color: Pallete.whiteColor),
                        ),
                      ),
                      tileTitle: Row(
                        children: [
                          Text(
                            data.fullname.toString(),
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
                      // Pop Menu button for delete and update operations
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
                            // navigates to edit screen
                            forexController.navigateToForexEdit(
                                data, data.sarafiId!.toInt());
                          }
                          if (value == "delete") {
                            // passes the id to the controller to delete the item
                            forexController.deleteForex(data.sarafiId, index);
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
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Pallete.blueColor,
      //   onPressed: () {
      //     // navigate to create screen
      //     forexController.navigateToForexCreate();
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     color: Pallete.whiteColor,
      //   ),
      // ),
    );
  }
}
