import 'package:fabricproject/api/dokan_pati_select_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/dokan_pati_select_model.dart';
import 'package:flutter/material.dart';

class DokanPatiSelectController extends ChangeNotifier {
  // helper class instance
  final HelperServices _helperServices;
  // TextEditing Controller to send and receive data from ui

  // lists to hold data comes from api
  List<Data>? allDokanPatiSelects = [];
  List<Data>? searchAllDokanPatiSelects = [];
  List<Data>? selectedItems = [];

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

  // this will hold search text field text
  String searchText = "";

  DokanPatiSelectController(this._helperServices) {
    // Gets data at first visit to the ui
  }

// gets all the data
  getDokanPatiSelect(int fabricPurchaseId, dokanId) async {
    print("Ids are for pati");
    print(fabricPurchaseId);
    print(dokanId);
    _helperServices.showLoader();
    // endpoint passed to the api class
    final response = await DokanPatiSelectApiServiceProvider().getDokanPatiSelect(
        'getPatiForSelection?sarai_id=$dokanId&fabricpurchase_id=$fabricPurchaseId');
    response.fold(
        (l) => {
// l returns failure with status code to the ui
              _helperServices.goBack(),
              _helperServices.showErrorMessage(l),
            }, (r) {
// r holds data comes from api with success
      allDokanPatiSelects = r;

      // goBack pops the current stack
      _helperServices.goBack();
      searchAllDokanPatiSelects?.clear();
      searchAllDokanPatiSelects?.addAll(allDokanPatiSelects!);
      // this methods assign the recent data to the search List
      // updateForexData();
      notifyListeners();
    });
  }

  searchDokanPatiMethod(String name) {
    searchText = name;
    updateDokanPatiSelectData();
  }

// updates data ui according entered search text
  updateDokanPatiSelectData() {
    searchAllDokanPatiSelects?.clear();
    if (searchText.isEmpty) {
      searchAllDokanPatiSelects?.addAll(allDokanPatiSelects!);
    } else {
      searchAllDokanPatiSelects?.addAll(
        allDokanPatiSelects!
            .where((element) =>
                // search filter is applied on these columns
                element.bundlename
                    .toString()
                    .toLowerCase()
                    .contains(searchText) ||
                element.patiname
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
