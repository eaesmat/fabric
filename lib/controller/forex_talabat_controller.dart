import 'package:fabricproject/api/forex_calculation_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/forex_calculation_model.dart';
import 'package:flutter/material.dart';

class ForexCalculationController extends ChangeNotifier {
  final HelperServices _helperServices;

  List<Data> allForexCalculation = [];
  List<Data> searchForexCalculation = [];
  String searchText = "";

  // Cached data to avoid unnecessary API calls
  List<Data> cachedForexCalculation = [];

  ForexCalculationController(this._helperServices) {
    getAllForexCalculation();
  }

  Future<void> getAllForexCalculation() async {
    _helperServices.showLoader();
    try {
      final response = await ForexCalculationApiServiceProvider()
          .getCalculation('sarafi-list');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allForexCalculation = r;
          searchForexCalculation = List.from(allForexCalculation);
          cachedForexCalculation =
              List.from(allForexCalculation); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void searchForexCalculationMethod(String text) {
    searchText = text;
    updateForexCalculationData();
  }

  void updateForexCalculationData() {
    searchForexCalculation.clear();
    if (searchText.isEmpty) {
      searchForexCalculation.addAll(cachedForexCalculation);
    } else {
      searchForexCalculation.addAll(
        cachedForexCalculation
            .where(
              (element) =>
                  (element.sarafiName
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.balance
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
    updateForexCalculationData();
  }
}
