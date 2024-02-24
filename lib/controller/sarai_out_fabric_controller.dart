import 'package:fabricproject/api/sarai_out_fabric_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/sarai_out_fabric_model.dart';
import 'package:fabricproject/screens/sarai_item_list/all_sarai_out_fabrics.dart';
import 'package:flutter/material.dart';

class SaraiOutFabricController extends ChangeNotifier {
  // helper class instance
  final HelperServices _helperServices;
  // TextEditing Controller to send and receive data from ui
  TextEditingController fabricPurchaseController = TextEditingController();
  TextEditingController bundleNameController = TextEditingController();
  TextEditingController bundleToopController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController indateController = TextEditingController();
  TextEditingController outdateController = TextEditingController();
  TextEditingController saraiToNameController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  // lists to hold data comes from api
  List<Data>? allSaraiOutFabric = [];
  List<Data>? searchSaraiOutFabrics = [];
  // this will hold search text field text
  String searchText = "";

  SaraiOutFabricController(this._helperServices) {
    // Gets data at first visit to the ui
  }

  navigateToAllSaraiOutFabric() async {
    _helperServices.navigate(
      AllSaraiOutFabric(),
    );

    // await getAllSaraiOutFabrics(
    //     fabricId, saraiId); // Wait for getAllFabricPurchases to complete
  }

// gets all the data
  getAllSaraiOutFabrics(int fabricId, saraiId) async {
    _helperServices.showLoader();
    // endpoint passed to the api class
    final response = await SaraiOutFabricApiServiceProvider().getSaraiOutFabric(
        'getSaraiOutFabric?fabric_id=$fabricId&sarai_id=$saraiId');
    response.fold(
        (l) => {
// l returns failure with status code to the ui
              _helperServices.goBack(),
              _helperServices.showErrorMessage(l),
            }, (r) {
// r holds data comes from api with success
      allSaraiOutFabric = r;
      // goBack pops the current stack
      _helperServices.goBack();
      searchSaraiOutFabrics?.clear();
      searchSaraiOutFabrics?.addAll(allSaraiOutFabric!);
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
    searchSaraiOutFabrics?.clear();
    if (searchText.isEmpty) {
      searchSaraiOutFabrics?.addAll(allSaraiOutFabric!);
    } else {
      searchSaraiOutFabrics?.addAll(
        allSaraiOutFabric!
            .where((element) =>
                // search filter is applied on these columns
                element.fabricpurchasecode!
                    .toLowerCase()
                    .contains(searchText) ||
                element.bundlename!.toLowerCase().contains(searchText) ||
                element.status!.toLowerCase().contains(searchText) ||
                element.outdate!.contains(searchText) ||
                element.customername!.contains(searchText) ||
                element.branchname!.contains(searchText) ||
                element.saraitoname!.contains(searchText) ||
                element.indate!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    allSaraiOutFabric?.clear();
    searchSaraiOutFabrics?.clear();
    notifyListeners();
  }
}
