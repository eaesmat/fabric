import 'package:fabricproject/api/sarai_fabric_bundle_select.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/sarai_fabric_bundle_select_model.dart';
import 'package:flutter/material.dart';

class SaraiFabricBundleSelectController extends ChangeNotifier {
  // helper class instance
  final HelperServices _helperServices;
  // TextEditing Controller to send and receive data from ui
  TextEditingController fabricPurchaseCodeController = TextEditingController();
  TextEditingController bundleController = TextEditingController();

  // lists to hold data comes from api
  List<Data>? allSaraiFabricBundleSelects = [];
  List<Data>? searchSaraiFabricBundleSelects = [];
  List<Data>? selectedItems = [];

  // this will hold search text field text
  String searchText = "";
  SaraiFabricBundleSelectController(this._helperServices) {
    // Gets data at first visit to the ui
  }

    void addItemToSelected(Data item) {
    selectedItems ??= [];
    selectedItems!.add(item);
    notifyListeners();
  }

  // Method to remove an item from selectedItems
  void removeItemFromSelected(Data item) {
    selectedItems?.remove(item);
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }

// gets all the data
  getSaraiFabricBundleSelect(int fabricPurchaseId, saraiId) async {
    _helperServices.showLoader();
    // endpoint passed to the api class
    final response = await SaraiFabricBundleSelectApiServiceProvider()
        .getSaraiFabricBundleSelect(
            'getFabricBundlesToSelect?fabricpurchase_id=$fabricPurchaseId&sarai_id=$saraiId');
    response.fold(
        (l) => {
// l returns failure with status code to the ui
              _helperServices.goBack(),
              _helperServices.showErrorMessage(l),
            }, (r) {
// r holds data comes from api with success
      allSaraiFabricBundleSelects = r;
     
      // goBack pops the current stack
      _helperServices.goBack();
      searchSaraiFabricBundleSelects?.clear();
      searchSaraiFabricBundleSelects?.addAll(allSaraiFabricBundleSelects!);
      // this methods assign the recent data to the search List
      // updateForexData();
      notifyListeners();
    });
  }

  searchSaraiFabricBundleSelectMethod(String name) {
    searchText = name;
    updateSaraiFabricBundleSelectData();
  }

// updates data ui according entered search text
  updateSaraiFabricBundleSelectData() {
    searchSaraiFabricBundleSelects?.clear();
    if (searchText.isEmpty) {
      searchSaraiFabricBundleSelects?.addAll(allSaraiFabricBundleSelects!);
    } else {
      searchSaraiFabricBundleSelects?.addAll(
        allSaraiFabricBundleSelects!
            .where((element) =>
                // search filter is applied on these columns
                element.name.toString().toLowerCase().contains(searchText) ||
                element.bundleName
                    .toString()
                    .toLowerCase()
                    .contains(searchText) ||
                element.war.toString().toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    selectedItems?.clear();
    notifyListeners();
  }
}
