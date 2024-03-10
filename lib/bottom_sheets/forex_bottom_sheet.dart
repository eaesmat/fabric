import 'package:fabricproject/constants/screen_type_constants.dart';
import 'package:fabricproject/controller/forex_controller.dart';
import 'package:fabricproject/controller/khalid_gereft_controller.dart';
import 'package:fabricproject/controller/khalid_rasid_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class ForexBottomSheet extends StatefulWidget {
  final String screenName;
  const ForexBottomSheet({super.key, required this.screenName});

  @override
  State<ForexBottomSheet> createState() => _ForexBottomSheetState();
}

class _ForexBottomSheetState extends State<ForexBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<ForexController>(context, listen: false).resetSearchFilter();
    });
  }

  void passDataToController(String screenType, forexName, forexId) {
    if (screenType == ScreenTypeConstants.khalidRasidScreen) {
      final khalidRasidController =
          Provider.of<KhalidRasidController>(context, listen: false);

      khalidRasidController.selectedForexNameController.text = forexName;
      khalidRasidController.selectedForexIdController.text = forexId.toString();
    }
    if (screenType == ScreenTypeConstants.khalidGereftScreen) {
      final khalidGereftController =
          Provider.of<KhalidGereftController>(context, listen: false);

      khalidGereftController.selectedForexNameController.text = forexName;
      khalidGereftController.selectedForexIdController.text =
          forexId.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    // controllers
    final forexController = Provider.of<ForexController>(context);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.all(16.0),
        color: Pallete.whiteColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
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
                      forexController.navigateToForexCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // Passes search text to the controller
                    forexController.searchForexMethod(value);
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: forexController.searchForex.length,
                itemBuilder: (context, index) {
                  final reversedList =
                      forexController.searchForex.reversed.toList();
                  final data = reversedList[index];
                  return ListTileWidget(
                    onTap: () {
                      passDataToController(
                        widget.screenName,
                        data.fullname,
                        data.sarafiId,
                      );
                      Navigator.pop(context);
                    },
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
                    // menu button for delete and update actions
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
                          // navigates to edit screen with item id
                          forexController.navigateToForexEdit(
                              data, data.sarafiId!.toInt());
                        }
                        // delete the item
                        if (value == "delete") {
                          forexController.deleteForex(
                              data.sarafiId!.toInt(), index);
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
