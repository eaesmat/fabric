import 'package:fabricproject/api/forex_talabat_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/forex_talabat_model.dart';
import 'package:flutter/material.dart';

class ForexTalabatController extends ChangeNotifier {
  final HelperServices _helperServices;

  List<Data> allForexTalabat = [];
  List<Data> searchForexTalabat = [];
  String searchText = "";

  // Cached data to avoid unnecessary API calls
  List<Data> cachedForexTalabat = [];

  ForexTalabatController(this._helperServices);

  Future<void> getAllForexTalabat(int forexId) async {
    _helperServices.showLoader();
    try {
      final response = await ForexTalabatApiServiceProvider()
          .getForexTalabat('load-talab-sarafi?sarafi_id=$forexId');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allForexTalabat = r;
          searchForexTalabat = List.from(allForexTalabat);
          cachedForexTalabat = List.from(allForexTalabat); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void searchForexTalabatMethod(String text) {
    searchText = text;
    updateForexTalabatData();
  }

  void updateForexTalabatData() {
    searchForexTalabat.clear();
    if (searchText.isEmpty) {
      searchForexTalabat.addAll(cachedForexTalabat);
    } else {
      searchForexTalabat.addAll(
        cachedForexTalabat
            .where(
              (element) =>
                  (element.drawDate
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.yen
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.exchangerate
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.doller
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.vendorcompanyName
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.name
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false),
            )
            .toList(),
      );
    }
    notifyListeners();
  }

  void resetSearchFilter() {
    searchText = '';
    updateForexTalabatData();
  }
}
