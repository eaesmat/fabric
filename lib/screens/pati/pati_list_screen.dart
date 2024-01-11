import 'package:fabricproject/controller/fabric_design_color_controller.dart';
import 'package:fabricproject/controller/pati_controller.dart';
import 'package:fabricproject/controller/pati_design_color_controller.dart';
import 'package:fabricproject/screens/pati_design_color/pati_design_color_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class PatiListScreen extends StatefulWidget {
  final int fabricDesignBundleId;
  final String? fabricDesignName;
  final int fabricDesignId;
  const PatiListScreen(
      {Key? key,
      required this.fabricDesignBundleId,
      this.fabricDesignName,
      required this.fabricDesignId})
      : super(key: key);

  @override
  State<PatiListScreen> createState() => _PatiListScreenState();
}

class _PatiListScreenState extends State<PatiListScreen> {
  @override
  Widget build(BuildContext context) {
    final patiDesignColorController =
        Provider.of<PatiDesignColorController>(context);
    final fabricDesignColorController =
        Provider.of<FabricDesignColorController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'pati'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // search part
          Consumer<PatiController>(
            builder: (context, patiController, child) {
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
                    onPressed: () async {
                      // search Icon to create a new item
                      // patiController.navigateToPatiCreate();
                      await patiController.createPatiName();
                      int patiId = patiController.lastPatiId!.toInt();

                      print('the pati id'); // ... other code ...
                      print(patiController.lastPatiId); // ... other code ...

                      final searchColors =
                          fabricDesignColorController.searchFabricDesignColors;
                      if (searchColors != null &&
                          patiController.isCreated == true) {
                        print('Length: ${searchColors.length}');
                        for (var color in searchColors) {
                          print('Color Name: ${color.colorname}');

                          patiDesignColorController
                              .fabricDesignColorIdController
                              .text = color.fabricdesigncolorId.toString();

                          patiDesignColorController.warController.text = '0';

                          patiDesignColorController.patiIdController.text =
                              patiId.toString();

                          patiDesignColorController.designBundleIdController
                              .text = widget.fabricDesignBundleId.toString();

                          await patiDesignColorController
                              .createPatiDesignColor();
                        }
                      } else {
                        print('SearchFabricDesignColors is null');
                      }
                      await patiController
                              .getAllPati(widget.fabricDesignBundleId);
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // passes search text to the controller
                    patiController.searchPatiMethod(value);
                  },
                ),
              );
            },
          ),
          // data list view
          Expanded(
            child: Consumer<PatiController>(
              builder: (context, patiController, child) {
                return ListView.builder(
                  itemCount: patiController.searchPati?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // data holds result of controller
                    final reversedList =
                        patiController.searchPati!.reversed.toList();
                    final data = reversedList[index];
                    return ListTileWidget(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return PatiDesignColorListScreen(
                              patiId: data.patiId,
                              patiName: data.patiname,
                              patiToop: data.toop.toString(),
                            );
                            // pass the fabric Id to the fabric design controller
                          },
                        );
                        patiDesignColorController
                            .navigateToPatiDesignListScreen(
                          data.patiId!.toInt(),
                          data.patiname.toString(),
                        );
                      },

                      // circular avatar
                      // lead: CircleAvatar(
                      //   backgroundColor: Pallete.blueColor,
                      //   child: Text(
                      //     data.marka!.toUpperCase(),
                      //     style: const TextStyle(color: Pallete.whiteColor),
                      //   ),
                      // ),
                      // Tile Title
                      tileTitle: Text(
                        data.patiname.toString(),
                      ),
                      // subtitle
                      tileSubTitle: Row(
                        children: [
                          Text(
                            data.toop.toString(),
                          ),
                          const Spacer(),
                          Text(
                            widget.fabricDesignName.toString(),
                          ),
                          const Spacer(),
                          Text(
                            widget.fabricDesignId.toString(),
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
                        ],
                        onSelected: (String value) {
                          if (value == "delete") {
                            patiController.deletePati(data.patiId, index);
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
