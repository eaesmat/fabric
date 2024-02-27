import 'package:fabricproject/api/all_fabric_purchases_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/all_fabric_purchases_model.dart';
import 'package:flutter/material.dart';

class AllFabricPurchasesController extends ChangeNotifier {
  // helper class instance
  final HelperServices _helperServices;
  
  // lists to hold data comes from api
  List<Data>? allFabricPurchases = [];
  List<Data>? searchAllFabricPurchases = [];
  // this will hold search text field text
  String searchText = "";

  AllFabricPurchasesController(this._helperServices) {
    // Gets data at first visit to the ui
      getAllFabricPurchases();

  }

// gets all the data
  getAllFabricPurchases() async {
    _helperServices.showLoader();
    // endpoint passed to the api class
    final response = await AllFabricPurchasesApiServiceProvider()
        .getTransportDeals('getFabricPurchase');
    response.fold(
        (l) => {
// l returns failure with status code to the ui
              _helperServices.goBack(),
              _helperServices.showErrorMessage(l),
            }, (r) {
// r holds data comes from api with success
      allFabricPurchases = r;
      // goBack pops the current stack
      _helperServices.goBack();
      searchAllFabricPurchases?.clear();
      searchAllFabricPurchases?.addAll(allFabricPurchases!);
      // this methods assign the recent data to the search List
      // updateForexData();
      notifyListeners();
    });
  }

  searchAllFabricPurchasesMethod(String name) {
    searchText = name;
    updateAllFabricPurchasesMarkaData();
  }

  void updateAllFabricPurchasesMarkaData() {
    searchAllFabricPurchases?.clear();
    if (searchText.isEmpty) {
      searchAllFabricPurchases?.addAll(allFabricPurchases!);
    } else {
      searchAllFabricPurchases?.addAll(
        allFabricPurchases!
            .where((element) =>
                // Filter applied on these columns
                (element.bundle?.toString() ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                (element.meter?.toString() ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                (element.war?.toString() ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                (element.yenprice?.toString() ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                (element.yenexchange?.toString() ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                (element.ttcommission?.toString() ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                (element.packagephoto?.toLowerCase() ?? '')
                    .contains(searchText.toLowerCase()) ||
                (element.bankreceiptphoto?.toLowerCase() ?? '')
                    .contains(searchText.toLowerCase()) ||
                (element.date?.toLowerCase() ?? '')
                    .contains(searchText.toLowerCase()) ||
                (element.fabricpurchasecode?.toLowerCase() ?? '')
                    .contains(searchText.toLowerCase()) ||
                (element.dollerprice?.toString() ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                (element.totalyenprice?.toString() ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                (element.totaldollerprice?.toString() ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                (element.status?.toLowerCase() ?? '')
                    .contains(searchText.toLowerCase()) ||
                (element.vendorcompany?.toLowerCase() ?? '')
                    .contains(searchText.toLowerCase()) ||
                (element.marka?.toLowerCase() ?? '')
                    .contains(searchText.toLowerCase()) ||
                (element.fabricName?.toLowerCase() ?? '')
                    .contains(searchText.toLowerCase()))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  // void resetSearchFilter() {
  //   allSaraiMarka?.clear();
  //   searchSaraiMarka?.clear();
  //   notifyListeners();
  // }
}
