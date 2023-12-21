import 'package:fabricproject/controller/draw_controller.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class DrawListScreen extends StatefulWidget {
  final int vendorCompanyId;
  final String vendorCompanyName;
  const DrawListScreen(
      {Key? key,
      required this.vendorCompanyId,
      required this.vendorCompanyName})
      : super(key: key);

  @override
  State<DrawListScreen> createState() => _DrawListScreenState();
}

class _DrawListScreenState extends State<DrawListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<DrawController>(
          builder: (context, drawController, child) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomTextFieldWithController(
                iconBtn: IconButton(
                    icon: const Icon(
                      Icons.add_box,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      drawController.navigateToDrawCreate();
                    }),
                lblText: const LocaleText('search'),
                onChanged: (value) {
                  drawController.searchDrawsMethod(value);
                },
              ),
            );
          },
        ),
        Expanded(
          child: Consumer<DrawController>(
            builder: (context, drawController, child) {
              return ListView.builder(
                itemCount: drawController.searchDraws?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = drawController.searchDraws![index];
                  return ListTileWidget(
                    lead: CircleAvatar(
                      backgroundColor: Pallete.blueColor,
                      child: Text(
                        data.photo!.toUpperCase(),
                        style: const TextStyle(color: Pallete.whiteColor),
                      ),
                    ),
                    tileTitle: Row(
                      children: [
                        Text(
                          "${data.sarafi!.fullname}",
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
                            Row(
                              children: [
                                LocaleText('yen_price'),
                                Text(
                                  data.yen.toString(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                LocaleText('exchnage'),
                                Text(
                                  data.exchangerate.toString(),
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
                          drawController.navigateToDrawEdit(
                              data, data.drawId!.toInt());
                        }
                        if (value == "delete") {
                          drawController.deleteDraw(data.drawId, index);
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
