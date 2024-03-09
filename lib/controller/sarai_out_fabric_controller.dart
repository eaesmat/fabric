import 'package:fabricproject/api/sarai_out_fabric_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/sarai_out_fabric_model.dart';
import 'package:fabricproject/screens/sarai_item_list/all_sarai_out_fabrics.dart';
import 'package:flutter/material.dart';

class SaraiOutFabricController extends ChangeNotifier {
  // helper class instance
  final HelperServices _helperServices;
  // lists to hold data comes from api
  List<Data> allSaraiOutFabric = [];
  List<Data> searchSaraiOutFabrics = [];
  List<Data> cachedForex = [];
  // this will hold search text field text
  String searchText = "";

  SaraiOutFabricController(this._helperServices) {
    // Gets data at first visit to the ui
  }

  navigateToAllSaraiOutFabric() {
    _helperServices.navigate(
      const AllSaraiOutFabric(),
    );

    // await getAllSaraiOutFabrics(
    //     fabricId, saraiId); // Wait for getAllFabricPurchases to complete
  }

// gets all the data

  Future<void> getAllSaraiOutFabrics(int fabricId, saraiId) async {
    _helperServices.showLoader();
    try {
      final response = await SaraiOutFabricApiServiceProvider().getSaraiOutFabric(
          'showInOutFabric?fabric_id=$fabricId&sarai_id=$saraiId&action=outFabric');
      response.fold(
        (l) => {
// l returns failure with status code to the ui
          _helperServices.goBack(),
          _helperServices.showErrorMessage(l),
        },
        (r) {
          allSaraiOutFabric = r;
          searchSaraiOutFabrics = List.from(allSaraiOutFabric);
          cachedForex = List.from(allSaraiOutFabric); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  searchSaraiFabricsMethod(String name) {
    searchText = name;
    updateSaraiFabricsData();
  }

// updates data ui according entered search text
  updateSaraiFabricsData() {
    searchSaraiOutFabrics.clear();
    if (searchText.isEmpty) {
      searchSaraiOutFabrics.addAll(allSaraiOutFabric);
    } else {
      searchSaraiOutFabrics.addAll(
        allSaraiOutFabric
            .where((element) =>
                // search filter is applied on these columns
                (element.fabricpurchasecode
                        ?.toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.bundlename
                        ?.toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.status
                        ?.toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.outdate
                        ?.toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.customername
                        ?.toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.branchname
                        ?.toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.saraitoname
                        ?.toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.indate
                        ?.toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    allSaraiOutFabric.clear();
    searchSaraiOutFabrics.clear();
    notifyListeners();
  }
}
