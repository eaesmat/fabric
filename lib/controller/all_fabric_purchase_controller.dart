import 'package:fabricproject/api/fabric_purchase_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/fabric_purchase_model.dart';
import 'package:flutter/material.dart';

class AllFabricPurchaseController extends ChangeNotifier {
  final HelperServices _helperServices;

  List<Data>? allFabricPurchases = [];
  List<Data>? searchFabricPurchases = [];
  String searchText = "";

  AllFabricPurchaseController(
    this._helperServices,
  ) {
    getAllFabricPurchases();
  }

  getAllFabricPurchases() async {
    _helperServices.showLoader();
    // endpoint passed to the api class
    final response = await FabricPurchaseApiServiceProvider()
        .getFabricPurchase('getFabricPurchase');
    response.fold(
        (l) => {
// l returns failure with status code to the ui
              _helperServices.goBack(),
              _helperServices.showErrorMessage(l),
            }, (r) {
// r holds data comes from api with success
      allFabricPurchases = r;
      print(r);
      // goBack pops the current stack
      _helperServices.goBack();
      searchFabricPurchases?.clear();
      searchFabricPurchases?.addAll(allFabricPurchases!);
      // this methods assign the recent data to the search List
      // updateForexData();
      notifyListeners();
    });
  }

  searchFabricPurchasesMethod(String name) {
    searchText = name;
    updateFabricPurchasesData();
  }

  updateFabricPurchasesData() {
    searchFabricPurchases?.clear();
    if (searchText.isEmpty) {
      searchFabricPurchases?.addAll(allFabricPurchases!);
    } else {
      searchFabricPurchases?.addAll(
        allFabricPurchases!
            .where((element) =>
                element.fabricpurchasecode!
                    .toLowerCase()
                    .contains(searchText) ||
                element.date!.toLowerCase().contains(searchText))
            // element.!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }
}
