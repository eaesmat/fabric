import 'package:fabricproject/api/sarai_fabric_purchase_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/sarai_fabric_purchase.dart';
import 'package:flutter/material.dart';

class SaraiFabricPurchaseController extends ChangeNotifier {
  // helper class instance
  final HelperServices _helperServices;
  // TextEditing Controller to send and receive data from ui
  TextEditingController fabricPurchaseCodeController = TextEditingController();
  TextEditingController bundleController = TextEditingController();

  // lists to hold data comes from api
  List<Data>? allSaraiFabricPurchase = [];
  List<Data>? searchSaraiFabricPurchase = [];
  // this will hold search text field text
  String searchText = "";

  SaraiFabricPurchaseController(this._helperServices) {
    // Gets data at first visit to the ui
  }

// gets all the data
  getSaraiFabricPurchase(int companyId, saraiId) async {
    _helperServices.showLoader();
    // endpoint passed to the api class
    final response = await SaraiFabricPurchaseApiServiceProvider()
        .getSaraiFabricPurchase(
            'getSaraiFabricPurchase?company_id=$companyId&sarai_id=$saraiId');
    response.fold(
        (l) => {
// l returns failure with status code to the ui
              _helperServices.goBack(),
              _helperServices.showErrorMessage(l),
            }, (r) {
// r holds data comes from api with success
      allSaraiFabricPurchase = r;
      print("The data is");
      print(r.length);
      // goBack pops the current stack
      _helperServices.goBack();
      searchSaraiFabricPurchase?.clear();
      searchSaraiFabricPurchase?.addAll(allSaraiFabricPurchase!);
      // this methods assign the recent data to the search List
      // updateForexData();
      notifyListeners();
    });
  }

  searchSaraiFabricPurchaseMethod(String name) {
    searchText = name;
    updateSaraiFabricPurchaseData();
  }

// updates data ui according entered search text
  updateSaraiFabricPurchaseData() {
    searchSaraiFabricPurchase?.clear();
    if (searchText.isEmpty) {
      searchSaraiFabricPurchase?.addAll(allSaraiFabricPurchase!);
    } else {
      searchSaraiFabricPurchase?.addAll(
        allSaraiFabricPurchase!
            .where((element) =>
                // search filter is applied on these columns
                element.bundle.toString().toLowerCase().contains(searchText) ||
                element.fabricpurchasecode!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    allSaraiFabricPurchase?.clear();
    searchSaraiFabricPurchase?.clear();
    notifyListeners();
  }
}
