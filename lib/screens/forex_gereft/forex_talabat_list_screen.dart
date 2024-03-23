import 'package:fabricproject/controller/forex_calculation_controller%20copy.dart';
import 'package:fabricproject/screens/forex_gereft/forex_talabat_item_details.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class ForexTalabatListScreen extends StatefulWidget {
  final int forexId;
  const ForexTalabatListScreen({
    Key? key,
    required this.forexId,
  }) : super(key: key);

  @override
  State<ForexTalabatListScreen> createState() => _ForexTalabatListScreenState();
}

class _ForexTalabatListScreenState extends State<ForexTalabatListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<ForexTalabatController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<ForexTalabatController>(context, listen: false)
            .getAllForexTalabat(widget.forexId);
      },
      child: Column(
        children: [
          Consumer<ForexTalabatController>(
            builder: (context, forexTalabatController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                // Search textfield
                child: CustomTextFieldWithController(
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    //Passes search box text to the controller
                    forexTalabatController.searchForexTalabatMethod(value);
                  },
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<ForexTalabatController>(
              builder: (context, forexTalabatController, child) {
                final searchForex =
                    forexTalabatController.searchForexTalabat; //data list view
                if (searchForex.isNotEmpty) {
                  return ListView.builder(
                    itemCount: forexTalabatController.searchForexTalabat.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // data vars takes data from controller
                      final data =
                          forexTalabatController.searchForexTalabat[index];
                      return ListTileWidget(
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return ForexTalabatDetailsBottomSheet(
                                data: data,
                              );
                            },
                          );
                        },
                        tileTitle: Row(
                          children: [
                            Text(
                              data.name?.toString() ?? '',
                            ),
                            const Spacer(),
                            Text(
                              "\$ ${data.doller ?? 0}",
                            ),
                          ],
                        ),
                        tileSubTitle: Row(
                          children: [
                            Text(
                              data.vendorcompanyName?.toString() ?? '',
                            ),
                            const Spacer(),
                            Text(
                                "Yen ${data.yen != null ? data.yen.toString() : "0"}"),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  // If no data, display the "noData.png" image
                  return const NoDataFoundWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
