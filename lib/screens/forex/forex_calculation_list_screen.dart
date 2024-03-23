import 'package:fabricproject/controller/forex_calculation_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class ForexCalculationListScreen extends StatefulWidget {
  const ForexCalculationListScreen({Key? key}) : super(key: key);

  @override
  State<ForexCalculationListScreen> createState() =>
      _ForexCalculationListScreenState();
}

class _ForexCalculationListScreenState
    extends State<ForexCalculationListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<ForexCalculationController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<ForexCalculationController>(context, listen: false)
            .getAllForexCalculation();
      },
      child: Column(
        children: [
          Consumer<ForexCalculationController>(
            builder: (context, forexCalculationController, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                // Search textfield
                child: CustomTextFieldWithController(
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    //Passes search box text to the controller
                    forexCalculationController
                        .searchForexCalculationMethod(value);
                  },
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<ForexCalculationController>(
              builder: (context, forexCalculationController, child) {
                final searchForex = forexCalculationController
                    .searchForexCalculation; //data list view
                if (searchForex.isNotEmpty) {
                  return ListView.builder(
                    itemCount: forexCalculationController
                        .searchForexCalculation.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // data vars takes data from controller
                      final data = forexCalculationController
                          .searchForexCalculation[index];
                      return ListTileWidget(
                       
                        tileTitle: Row(
                          children: [
                            Text(
                              data.sarafiName.toString(),
                            ),
                            const Spacer(),
                            Text(
                              "\$ ${data.balance}",
                              style: TextStyle(
                                color: data.balance! < 0
                                    ? Pallete.redColor
                                    : Colors.black,
                              ),
                            ),
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
