import 'package:fabricproject/api/sarai_marka_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/sarai_marka_model.dart';
import 'package:flutter/material.dart';

class SaraiMarkaController extends ChangeNotifier {
  // helper class instance
  final HelperServices _helperServices;
  // TextEditing Controller to send and receive data from ui
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyMarkaController = TextEditingController();
  TextEditingController companyDescriptionController = TextEditingController();

  // lists to hold data comes from api
  List<Data>? allSaraiMarka = [];
  List<Data>? searchSaraiMarka = [];
  // this will hold search text field text
  String searchText = "";

  SaraiMarkaController(this._helperServices) {
    // Gets data at first visit to the ui
  }

// gets all the data
  getSaraiMarka(int? saraiId) async {
    _helperServices.showLoader();
    // endpoint passed to the api class
    final response = await SaraiMarkaApiServiceProvider()
        .getSaraiMarka('getSaraiMarka?sarai_id=$saraiId');
    response.fold(
        (l) => {
// l returns failure with status code to the ui
              _helperServices.goBack(),
              _helperServices.showErrorMessage(l),
            }, (r) {
// r holds data comes from api with success
      allSaraiMarka = r;
      // goBack pops the current stack
      _helperServices.goBack();
      searchSaraiMarka?.clear();
      searchSaraiMarka?.addAll(allSaraiMarka!);
      // this methods assign the recent data to the search List
      // updateForexData();
      notifyListeners();
    });
  }

  searchSaraiMarkaMethod(String name) {
    searchText = name;
    updateSaraiMarkaData();
  }

// updates data ui according entered search text
  updateSaraiMarkaData() {
    searchSaraiMarka?.clear();
    if (searchText.isEmpty) {
      searchSaraiMarka?.addAll(allSaraiMarka!);
    } else {
      searchSaraiMarka?.addAll(
        allSaraiMarka!
            .where((element) =>
                // search filter is applied on these columns
                element.marka!.toLowerCase().contains(searchText) ||
                element.name!.toLowerCase().contains(searchText) ||
                element.description!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    allSaraiMarka?.clear();
    searchSaraiMarka?.clear();
    notifyListeners();
  }
}
