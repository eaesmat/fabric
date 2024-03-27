import 'package:fabricproject/api/vendorcompany_calculation_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/vendorcompany_calculation_model.dart';
import 'package:flutter/material.dart';

class VendorCompanyCalculationController extends ChangeNotifier {
  final HelperServices _helperServices;

  List<Data> allVendorCalculation = [];
  List<Data> searchVendorCalculation = [];
  String searchText = "";

  // Cached data to avoid unnecessary API calls
  List<Data> cachedForexCalculation = [];

  VendorCompanyCalculationController(this._helperServices) {
    getAllVendorCalculation();
  }

  Future<void> getAllVendorCalculation() async {
    _helperServices.showLoader();
    try {
      final response = await VendorCompanyCalculationApiServiceProvider()
          .getVendorCompanyBalance('vendorCompanyList');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allVendorCalculation = r;
          searchVendorCalculation = List.from(allVendorCalculation);
          cachedForexCalculation =
              List.from(allVendorCalculation); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void searchVendorCalculationMethod(String text) {
    searchText = text;
    updateVendorCalculationData();
  }

  void updateVendorCalculationData() {
    searchVendorCalculation.clear();
    if (searchText.isEmpty) {
      searchVendorCalculation.addAll(cachedForexCalculation);
    } else {
      searchVendorCalculation.addAll(
        cachedForexCalculation
            .where(
              (element) =>
                  (element.vendorcompanyName
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.balanceDoller
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.balanceYen
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
    updateVendorCalculationData();
  }
}
