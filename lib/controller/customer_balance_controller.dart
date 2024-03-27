import 'package:fabricproject/api/customer_balance_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/customer_balance_model.dart';
import 'package:flutter/material.dart';

class CustomerBalanceController extends ChangeNotifier {
  final HelperServices _helperServices;

  List<Data> allCustomerBalance = [];
  List<Data> searchCustomerBalance = [];
  String searchText = "";

  // Cached data to avoid unnecessary API calls
  List<Data> cachedCustomerBalance = [];

  CustomerBalanceController(this._helperServices) {
    getAllCustomerBalance();
  }

  Future<void> getAllCustomerBalance() async {
    _helperServices.showLoader();
    try {
      final response = await CustomerBalanceApiServiceProvider()
          .getCustomerBalance('loadCustomerList');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allCustomerBalance = r;
          searchCustomerBalance = List.from(allCustomerBalance);
          cachedCustomerBalance =
              List.from(allCustomerBalance); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void searchCustomerBalanceMethod(String text) {
    searchText = text;
    updateForexCalculationData();
  }

  void updateForexCalculationData() {
    searchCustomerBalance.clear();
    if (searchText.isEmpty) {
      searchCustomerBalance.addAll(cachedCustomerBalance);
    } else {
      searchCustomerBalance.addAll(
        cachedCustomerBalance
            .where(
              (element) =>
                  (element.firstname
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.lastname
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.dueAfghani
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.dueDoller
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
