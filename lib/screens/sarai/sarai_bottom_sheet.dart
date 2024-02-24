import 'package:fabricproject/controller/sarai_controller.dart';
import 'package:fabricproject/controller/transport_deal_controller.dart';
import 'package:fabricproject/controller/ttranser_bundles_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class SaraiButtonSheet extends StatefulWidget {
  const SaraiButtonSheet({super.key});

  @override
  State<SaraiButtonSheet> createState() => _SaraiButtonSheetState();
}

class _SaraiButtonSheetState extends State<SaraiButtonSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<SaraiController>(context, listen: false).resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    // controller provider
    SaraiController saraiController = Provider.of<SaraiController>(context);
    // fabric purchase controller to pass the selected id to the fabric purchase controller
    final transportDealController =
        Provider.of<TransportDealController>(context);
    final transferBundlesController =
        Provider.of<TransferBundlesController>(context);

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
                // search text filed
                child: CustomTextFieldWithController(
                  // create button in the search text filed
                  iconBtn: IconButton(
                    icon: const Icon(
                      size: 30,
                      Icons.add_box_rounded,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      // to create new
                      saraiController.navigateToSaraiCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    // searches item
                    saraiController.searchSarisMethod(value);
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: saraiController.searchSarais?.length ?? 0,
                itemBuilder: (context, index) {
                  // data gets data from controller
                  final reversedList =
                      saraiController.searchSarais!.reversed.toList();
                  final data = reversedList[index];
                  return ListTileWidget(
                    onTap: () {
                      // pass id
                      transportDealController.selectedSaraiIdController.text =
                          data.saraiId!.toString();
                      transportDealController.selectedSaraiNameController.text =
                          data.name!.toString();

                      transferBundlesController.selectedSaraiToIdController
                          .text = data.saraiId.toString();
                      transferBundlesController.selectedSaraiToNameController
                          .text = data.name.toString();

                      Navigator.pop(context);
                    },
                    tileTitle: Row(
                      children: [
                        Text(
                          "${data.name}  [ ${data.type} ]",
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
                          saraiController.navigateToSaraiEdit(
                              data, data.saraiId!.toInt());
                        }
                        if (value == "delete") {
                          saraiController.deleteSarai(data.saraiId, index);
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
