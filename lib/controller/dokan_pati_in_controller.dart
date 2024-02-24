import 'package:fabricproject/api/dokan_in_pati_api.dart';
import 'package:fabricproject/api/sarai_in_fabric_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/screens/dokan_pati/all_dokan_pati_in.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/model/dokan_pati_in_model.dart';

class DokanInPatiController extends ChangeNotifier {
  // helper class instance
  final HelperServices _helperServices;
  // lists to hold data comes from api
  List<Data>? allDokanPati = [];
  List<Data>? searchDokanInPati = [];
  // this will hold search text field text
  String searchText = "";

  DokanInPatiController(this._helperServices) {
    // Gets data at first visit to the ui
  }

  navigateToAllDokanPatiIn() async {
    _helperServices.navigate(
      // this is the screen to show all the dokan pati ins
      const AllDokanPatiIn(),
    );

    // await getAllSaraiOutFabrics(
    //     fabricId, saraiId); // Wait for getAllFabricPurchases to complete
  }

  navigateToDokanInPatiDetails(Data data) async {
    // _helperServices.navigate(
    //   // SaraiFabricInDetailsBottomSheet(data: data),
    // );

    // await getAllSaraiOutFabrics(
    //     fabricId, saraiId); // Wait for getAllFabricPurchases to complete
  }

// gets all the data
// as dokan is type of sarai I used dokan instead but this is sarai id with type dokan
  getAllDokanPatiIn(int fabricId, dokanId) async {
    _helperServices.showLoader();
    // endpoint passed to the api class
    final response = await DokanInPatiApiServiceProvider().getDokanInPati(
        'getDokanPatiInOut?sarai_id=$dokanId&fabric_id=$fabricId&actionPati=saraiPageLoadInPati');
    response.fold(
        (l) => {
// l returns failure with status code to the ui
              _helperServices.goBack(),
              _helperServices.showErrorMessage(l),
            }, (r) {
// r holds data comes from api with success
      allDokanPati = r;
      // goBack pops the current stack
      _helperServices.goBack();
      searchDokanInPati?.clear();
      searchDokanInPati?.addAll(allDokanPati!);
      // this methods assign the recent data to the search List
      // updateForexData();
      notifyListeners();
    });
  }

  searchDokanInPatiMethod(String name) {
    searchText = name;
    updateDokanPatiInData();
  }

// updates data ui according entered search text
  updateDokanPatiInData() {
    searchDokanInPati?.clear();
    if (searchText.isEmpty) {
      searchDokanInPati?.addAll(allDokanPati!);
    } else {
      searchDokanInPati?.addAll(
        allDokanPati!
            .where((element) =>
                // search filter is applied on these columns
                element.inDate!
                    .toLowerCase()
                    .contains(searchText) ||
                element.fabricPurchaseCode!.toLowerCase().contains(searchText) ||
                element.patiName!.toLowerCase().contains(searchText) ||
                element.patiWar!.toString().toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    allDokanPati?.clear();
    searchDokanInPati?.clear();
    notifyListeners();
  }
}
