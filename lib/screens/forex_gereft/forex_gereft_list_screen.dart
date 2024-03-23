import 'package:fabricproject/controller/forex_gereft_controller.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class ForexGereftListScreen extends StatefulWidget {
  final String forexName;
  final int forexId;
  const ForexGereftListScreen({
    Key? key,
    required this.forexName,
    required this.forexId,
  }) : super(key: key);

  @override
  State<ForexGereftListScreen> createState() => _ForexGereftListScreenState();
}

class _ForexGereftListScreenState extends State<ForexGereftListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<ForexGereftController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<ForexGereftController>(context, listen: false)
            .getAllForexGerefts(widget.forexId);
      },
      child: Column(
        children: [
          Consumer<ForexGereftController>(
            builder: (context, forexGereftController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
                  iconBtn: IconButton(
                      icon: const Icon(
                        Icons.add_box,
                        color: Pallete.blueColor,
                      ),
                      onPressed: () {
                        forexGereftController.navigateToForexGereftCreate();
                      }),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    forexGereftController.searchForexGereftsMethod(value);
                  },
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<ForexGereftController>(
              builder: (context, forexGereftController, child) {
                final reversedList =
                    forexGereftController.searchForexGerefts.reversed.toList();

                if (reversedList.isEmpty) {
                  // If no data, display the "noData.png" image
                  return const NoDataFoundWidget();
                }

                return ListView.builder(
                  itemCount: reversedList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = reversedList[index];
                    return ListTileWidget(
                      tileTitle: Row(
                        children: [
                          Text(
                            data.byPerson?.toString() ?? '',
                          ),
                          const Spacer(),
                          Text(
                            '\$ ${data.doller.toString()}',
                          ),
                        ],
                      ),
                      tileSubTitle: Row(
                        children: [
                          Text(
                            data.description?.toString() ?? '',
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    data.date.toString(),
                                  ),
                                ],
                              ),
                            ],
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
                            ),
                          ),
                        ],
                        onSelected: (String value) {
                          if (value == "edit") {
                            forexGereftController.navigateToForexGereftEdit(
                              data,
                              data.depositId!.toInt(),
                            );
                          }
                          if (value == "delete") {
                            forexGereftController.deleteForexGereft(
                              data.depositId!.toInt(),
                            );
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
