import 'package:fabricproject/controller/fabric_controller.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<FabricController>(context, listen: false).resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'fabrics'),
        centerTitle: true,
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          // Implement your refresh logic here
          await Provider.of<FabricController>(context, listen: false)
              .getAllFabrics();
        },
        child: Column(
          children: [
            Consumer<FabricController>(
              builder: (context, fabricController, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomTextFieldWithController(
                    iconBtn: IconButton(
                      icon: const Icon(
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      onPressed: () {
                        fabricController.navigateToFabricCreate();
                      },
                    ),
                    lblText: const LocaleText('search'),
                    onChanged: (value) {
                      fabricController.searchFabricsMethod(value);
                    },
                  ),
                );
              },
            ),
            Expanded(
              child: Consumer<FabricController>(
                builder: (context, fabricController, child) {
                  return fabricController.searchFabrics.isEmpty
                      ? const  NoDataFoundWidget()
                      : ListView.builder(
                          itemCount: fabricController.searchFabrics.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final reversedList = fabricController
                                .searchFabrics.reversed
                                .toList();
                            final data = reversedList[index];
                            return ListTileWidget(
                              lead: CircleAvatar(
                                backgroundColor: Pallete.blueColor,
                                child: Text(
                                  data.abr?.toString() ?? ''.toUpperCase(),
                                  style: const TextStyle(
                                      color: Pallete.whiteColor),
                                ),
                              ),
                              tileTitle: Text(
                                data.name?.toString() ?? '',
                              ),
                              tileSubTitle: Text(
                                data.description?.toString() ?? '',
                              ),
                              trail: PopupMenuButton(
                                color: Pallete.whiteColor,
                                child: const Icon(Icons.more_vert_sharp),
                                itemBuilder: (context) =>
                                    <PopupMenuEntry<String>>[
                                  const PopupMenuItem(
                                    value: "delete",
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete),
                                        SizedBox(width: 10),
                                        LocaleText('delete'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: "edit",
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit),
                                        SizedBox(width: 10),
                                        LocaleText('update'),
                                      ],
                                    ),
                                  ),
                                ],
                                onSelected: (String value) {
                                  if (value == "edit") {
                                    fabricController.navigateToFabricEdit(
                                        data, data.fabricId!.toInt());
                                  }
                                  if (value == "delete") {
                                    fabricController
                                        .deleteFabric(data.fabricId!);
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
