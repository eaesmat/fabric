import 'package:fabricproject/api/sarai_in_fabric_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/sarai_in_fabric_model.dart';
import 'package:fabricproject/screens/sarai_item_list/all_sarai_in_fabric.dart';
import 'package:fabricproject/screens/sarai_item_list/sarai_fabric_in_details_screen.dart';
import 'package:flutter/material.dart';

class SaraiInFabricController extends ChangeNotifier {
  // helper class instance
  final HelperServices _helperServices;
  // TextEditing Controller to send and receive data from ui
  TextEditingController fabricPurchaseController = TextEditingController();
  TextEditingController bundleNameController = TextEditingController();
  TextEditingController bundleToopController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController indateController = TextEditingController();
  // lists to hold data comes from api
  List<Data>? allSaraiInFabric = [];
  List<Data>? searchSaraiInFabrics = [];
  // this will hold search text field text
  String searchText = "";

  SaraiInFabricController(this._helperServices) {
    // Gets data at first visit to the ui
  }

    navigateToAllSaraiInFabric() async {
    _helperServices.navigate(
      AllSaraiInFabric(),
    );

    // await getAllSaraiOutFabrics(
    //     fabricId, saraiId); // Wait for getAllFabricPurchases to complete
  }
    navigateToSaraiInFabricDetails(Data data) async {
    _helperServices.navigate(
      SaraiFabricInDetailsBottomSheet(data: data),
    );

    // await getAllSaraiOutFabrics(
    //     fabricId, saraiId); // Wait for getAllFabricPurchases to complete
  }

// gets all the data
  getAllSaraiFabrics(int fabricId, saraiId) async {
    _helperServices.showLoader();
    // endpoint passed to the api class
    final response = await SaraiInFabricApiServiceProvider().getSaraiInFabric(
        'getSaraiInFabric?fabric_id=$fabricId&sarai_id=$saraiId');
    response.fold(
        (l) => {
// l returns failure with status code to the ui
              _helperServices.goBack(),
              _helperServices.showErrorMessage(l),
            }, (r) {
// r holds data comes from api with success
      allSaraiInFabric = r;
      // goBack pops the current stack
      _helperServices.goBack();
      searchSaraiInFabrics?.clear();
      searchSaraiInFabrics?.addAll(allSaraiInFabric!);
      // this methods assign the recent data to the search List
      // updateForexData();
      notifyListeners();
    });
  }

  searchSaraiFabricsMethod(String name) {
    searchText = name;
    updateSaraiFabricsData();
  }

// updates data ui according entered search text
  updateSaraiFabricsData() {
    searchSaraiInFabrics?.clear();
    if (searchText.isEmpty) {
      searchSaraiInFabrics?.addAll(allSaraiInFabric!);
    } else {
      searchSaraiInFabrics?.addAll(
        allSaraiInFabric!
            .where((element) =>
                // search filter is applied on these columns
                element.fabricpurchasecode!
                    .toLowerCase()
                    .contains(searchText) ||
                element.bundlename!.toLowerCase().contains(searchText) ||
                element.status!.toLowerCase().contains(searchText) ||
                element.indate!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
     allSaraiInFabric?.clear();
    searchSaraiInFabrics?.clear();
    notifyListeners();
  }
}
