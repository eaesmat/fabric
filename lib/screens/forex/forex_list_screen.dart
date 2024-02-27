import 'package:fabricproject/controller/forex_controller.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<ForexController>(context, listen: false).resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText('forex'),
        centerTitle: true,
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          // Implement your refresh logic here
          await Provider.of<ForexController>(context, listen: false)
              .getAllForex();
        },
        child: Column(
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
                  final searchForex =
                      forexController.searchForex ?? []; //data list view
                  if (searchForex.isNotEmpty) {
                    return ListView.builder(
                      itemCount: forexController.searchForex.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        // data vars takes data from controller
                        final data = forexController.searchForex[index];
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
                            padding: EdgeInsets.zero,
                            itemBuilder: (context) => <PopupMenuEntry<String>>[
                              const PopupMenuItem(
                                value: "delete",
                                child: ListTile(
                                  leading: Icon(Icons.delete),
                                  title: LocaleText('delete'),
                                ),
                              ),
                              const PopupMenuItem(
                                value: "edit",
                                child: ListTile(
                                  leading: Icon(Icons.edit),
                                  title: LocaleText('update'),
                                ),
                              ),
                            ],
                            onSelected: (String value) {
                              if (value == "edit") {
                                // navigates to edit screen
                                forexController.navigateToForexEdit(
                                    data, data.sarafiId!);
                              }
                              if (value == "delete") {
                                // passes the id to the controller to delete the item
                                forexController.deleteForex(
                                    data.sarafiId!, index);
                              }
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    // If no data, display the "noData.png" image
                    return Center(
                      child: Image.asset(
                        'assets/images/noData.png',
                        width: 800, // Set the width as needed
                        height: 500, // Set the height as needed
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
