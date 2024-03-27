import 'package:fabricproject/api/customer_sales_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/customer_sales.model.dart';
import 'package:flutter/material.dart';

class CustomerSalesController extends ChangeNotifier {
  final HelperServices _helperServices;

  List<Data> allCustomersSales = [];
  List<Data> searchCustomersSales = [];
  List<Data> cachedCustomerSales = [];

  String searchText = "";

  CustomerSalesController(
    this._helperServices,
  );

// Function to fetch all customer deals from the API
  Future<void> getAllCustomerSales(int customerId) async {
    _helperServices.showLoader();
    try {
      final response = await CustomerSalesApiServiceProvider()
          .getCustomerSales('getCustomerSales?customer_id=$customerId');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allCustomersSales = r;
          searchCustomersSales = List.from(allCustomersSales);
          cachedCustomerSales = List.from(allCustomersSales);
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  searchCustomerSalesMethod(String name) {
    searchText = name;
    updateCustomerSalesData();
  }

  void updateCustomerSalesData() {
    searchCustomersSales.clear();

    if (searchText.isEmpty) {
      searchCustomersSales.addAll(cachedCustomerSales);
    } else {
      searchCustomersSales.addAll(
        cachedCustomerSales
            .where((element) =>
                (element.begakNumber
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.afghani
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.dollor
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.date
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.date
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    searchText = '';
    updateCustomerSalesData();
  }
}
