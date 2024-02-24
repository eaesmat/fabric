import 'package:fabricproject/api/dokan_out_pati_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/screens/dokan_pati/all_dokan_pati_out.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/model/dokan_pati_out_model.dart';

class DokanOutPatiController extends ChangeNotifier {
  // helper class instance
  final HelperServices _helperServices;
  // lists to hold data comes from api
  List<Data>? allDokanOutPati = [];
  List<Data>? searchDokanOutPati = [];
  // this will hold search text field text
  String searchText = "";

  DokanOutPatiController(this._helperServices) {
    // Gets data at first visit to the ui
  }

  navigateToAllDokanPatiOut() async {
    _helperServices.navigate(
        // this is the screen to show all the dokan pati ins
        const AllDokanPatiOut(),
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
  getAllDokanPatiOut(int fabricId, dokanId) async {
    _helperServices.showLoader();
    // endpoint passed to the api class
    final response = await DokanOutPatiApiServiceProvider().getDokanOutPati(
        'getDokanPatiInOut?sarai_id=$dokanId&fabric_id=$fabricId&actionPati=saraiPageLoadOutPati');
    response.fold(
        (l) => {
// l returns failure with status code to the ui
              _helperServices.goBack(),
              _helperServices.showErrorMessage(l),
            }, (r) {
// r holds data comes from api with success
      allDokanOutPati = r;
      // goBack pops the current stack
      _helperServices.goBack();
      searchDokanOutPati?.clear();
      searchDokanOutPati?.addAll(allDokanOutPati!);
      // this methods assign the recent data to the search List
      // updateForexData();
      notifyListeners();
    });
  }

  searchDokanOutPatiMethod(String name) {
    searchText = name;
    updateDokanPatiOutData();
  }

// updates data ui according entered search text
  updateDokanPatiOutData() {
    searchDokanOutPati?.clear();
    if (searchText.isEmpty) {
      searchDokanOutPati?.addAll(allDokanOutPati!);
    } else {
      searchDokanOutPati?.addAll(
        allDokanOutPati!
            .where((element) =>
                // search filter is applied on these columns
                element.outDate!.toLowerCase().contains(searchText) ||
                element.fabricPurchaseCode!
                    .toLowerCase()
                    .contains(searchText) ||
                element.patiName!.toLowerCase().contains(searchText) ||
                element.placeTo!.toLowerCase().contains(searchText) ||
                element.patiWar!.toString().toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    allDokanOutPati?.clear();
    searchDokanOutPati?.clear();
    notifyListeners();
  }
}
