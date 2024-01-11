import 'package:fabricproject/controller/transport_deal_controller.dart';
import 'package:fabricproject/model/transport_deal_model.dart';
import 'package:fabricproject/screens/transport_deal/transport_deal_item_details.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class GoodsOnTheWayListScreen extends StatelessWidget {
  const GoodsOnTheWayListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'goods_on_the_way'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Consumer<TransportDealController>(
              builder: (context, transportDealController, child) {
                return CustomTextFieldWithController(
                  iconBtn: IconButton(
                    icon: const Icon(
                      Icons.add_box,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      transportDealController.navigateToTransportDealCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    transportDealController
                        .searchTransportDealWithNoFilterMethod(value);
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Consumer<TransportDealController>(
              builder: (context, transportDealController, child) {
                return ListView.builder(
                  itemCount: transportDealController
                          .searchTransportDealsWithNoFilter?.length ??
                      0,
                  itemBuilder: (context, index) {
                    final data = transportDealController
                        .searchTransportDealsWithNoFilter![index];

                    return ListTileWidget(
                      trail: IconButton(
                        onPressed: () async{
                              print("fab id ");
                          print(data.fabricpurchaseId);
                         await transportDealController.editTransportDealStatusReceived(
                              data.transportdealId!.toInt(), data);
                      
                        },
                        icon: const Icon(Icons.check),
                      ),
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            List<ContainerModel> containers =
                                (data.container ?? []).cast<ContainerModel>();

                            return TransportItemDetailsBottomSheet(
                              data: data,
                              transportName: data.transport!.name.toString(),
                              containerList: containers,
                            );
                          },
                        );
                      },
                      tileTitle: Row(
                        children: [
                          Text(
                            "${data.fabricpurchase!.fabricpurchasecode}",
                          ),
                          const Spacer(),
                          Text(
                            data.container != null && data.container!.isNotEmpty
                                ? data.container![0].name ?? 'No Container'
                                : 'No Container',
                          ),
                        ],
                      ),
                      tileSubTitle: Row(
                        children: [
                          Text(
                            data.startdate.toString(),
                          ),
                          const Spacer(),
                          Text(
                            data.arrivaldate.toString(),
                          ),
                        ],
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
