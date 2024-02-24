// Import necessary dependencies and files
import 'package:fabricproject/controller/draw_controller.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

// Define a StatefulWidget for DrawListScreen
class DrawListScreen extends StatefulWidget {
  final int vendorCompanyId;
  final String vendorCompanyName;

  // Constructor for DrawListScreen
  const DrawListScreen({
    Key? key,
    required this.vendorCompanyId,
    required this.vendorCompanyName,
  }) : super(key: key);

  @override
  State<DrawListScreen> createState() => _DrawListScreenState();
}

// Define the state for _DrawListScreenState
class _DrawListScreenState extends State<DrawListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Consumer to listen to changes in DrawController
        Consumer<DrawController>(
          builder: (context, drawController, child) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomTextFieldWithController(
                // IconButton to navigate to DrawCreateScreen
                iconBtn: IconButton(
                  icon: const Icon(
                    Icons.add_box,
                    color: Pallete.blueColor,
                  ),
                  onPressed: () {
                    drawController.navigateToDrawCreate();
                  },
                ),
                lblText: const LocaleText('search'),
                // Search functionality
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
                    // CircleAvatar with draw photo
                    lead: CircleAvatar(
                      backgroundColor: Pallete.blueColor,
                      child: Text(
                        "${data.photo}",
                        style: const TextStyle(color: Pallete.whiteColor),
                      ),
                    ),
                    // Title and Subtitle of the ListTile
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
                                const LocaleText('dollar_price'),
                                Text(
                                  data.doller.toString(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const LocaleText('yen_price'),
                                Text(
                                  data.yen.toString(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const LocaleText('exchange'),
                                Text(
                                  data.exchangerate.toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    // PopupMenuButton for more options
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
                          ),
                        ),
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
                      // Handle item selection
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
    );
  }
}
