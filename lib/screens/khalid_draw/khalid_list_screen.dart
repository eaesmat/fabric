import 'package:fabricproject/controller/khalid_draw_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class KhalidDrawListScreen extends StatefulWidget {
  const KhalidDrawListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<KhalidDrawListScreen> createState() => _KhalidDrawListScreenState();
}

class _KhalidDrawListScreenState extends State<KhalidDrawListScreen> {
  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);

    return Column(
      children: [
        Consumer<KhalidDrawController>(
          builder: (context, khalidDrawController, child) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomTextFieldWithController(
                iconBtn: IconButton(
                    icon: const Icon(
                      Icons.add_box,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      khalidDrawController.navigateToDrawCreate();
                    }),
                lblText: const LocaleText('search'),
                onChanged: (value) {
                  khalidDrawController.searchDrawsMethod(value);
                },
              ),
            );
          },
        ),
        Expanded(
          child: Consumer<KhalidDrawController>(
            builder: (context, khalidDrawController, child) {
              return ListView.builder(
                itemCount: khalidDrawController.searchDraws?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = khalidDrawController.searchDraws![index];
                  return ListTileWidget(
                    lead: CircleAvatar(
                      backgroundColor: Pallete.blueColor,
                      child: Text(
                        "${data.photo}",
                        style: const TextStyle(color: Pallete.whiteColor),
                      ),
                    ),
                    tileTitle: Row(
                      children: [
                        Text(
                          data.sarafi?.fullname ??
                              showShopIfNoSarafi(
                                  data.sarafi?.fullname, currentLocale)!,
                        ),
                        const Spacer(),
                        Text(
                          "${data.drawDate}",
                        ),
                      ],
                    ),
                    tileSubTitle: Row(
                      children: [
                        Text(
                          data.description.toString(),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Row(
                              children: [
                                LocaleText('dollar_price'),
                                Text(
                                  data.doller.toString(),
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
                            )),
                      ],
                      onSelected: (String value) {
                        if (value == "edit") {
                          khalidDrawController.navigateToDrawEdit(
                              data, data.drawId!.toInt());
                        }
                        if (value == "delete") {
                          khalidDrawController.deleteDraw(data.drawId, index);
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
      // ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Pallete.blueColor,
      //   onPressed: () {
      //     drawController.navigateToDrawCreate();
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     color: Pallete.whiteColor,
      //   ),
      // ),
    );
  }
}
