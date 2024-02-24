import 'package:fabricproject/api/dokan_pati_api.dart';
import 'package:fabricproject/api/sarai_item_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:flutter/material.dart';

import '../model/dokan_pati_model.dart';

class DokanPatiController extends ChangeNotifier {
  final HelperServices _helperServices;
  List<Data>? allDokanPati = [];
  List<Data>? searchAllDokanPati = [];
  String searchText = "";

  DokanPatiController(this._helperServices);

  getDokanPati(int dokanId) async {
    _helperServices.showLoader();
    final response = await DokanPatiApiServiceProvider().getDokanPati(
        'getDokanPati?sarai_id=$dokanId'); // as dokan is type of sarai so used dokan id instead of sarai
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) {
        allDokanPati = r;
        _helperServices.goBack();
        searchAllDokanPati?.clear();
        searchAllDokanPati?.addAll(allDokanPati!);
        notifyListeners();
      },
    );
  }

  searchDokanPatiMethod(String name) {
    searchText = name;
    updateDokanPatiData();
  }

  updateDokanPatiData() {
    searchAllDokanPati?.clear();
    if (searchText.isEmpty) {
      searchAllDokanPati?.addAll(allDokanPati!);
    } else {
      searchAllDokanPati?.addAll(
        allDokanPati!
            .where((element) =>
                element.name!.toLowerCase().contains(searchText) ||
                element.indate!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  void resetSearchFilter() {
    searchText = '';
    updateDokanPatiData();
  }
}
