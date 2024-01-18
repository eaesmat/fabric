import 'package:fabricproject/api/customer_deals_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/customer_deals_model.dart';
import 'package:fabricproject/screens/customer/customer_details_screen.dart';
import 'package:flutter/material.dart';

class CustomerDealsController extends ChangeNotifier {
  final HelperServices _helperServices;

  int? customerId;
  List<GetCustomerTransaction>? allCustomersDeals = [];
  List<GetCustomerTransaction>? searchCustomersDeals = [];
  String searchText = "";

  CustomerDealsController(
    this._helperServices,
  ) {
    getAllCustomerDeals(customerId);
  }

  navigateToCustomerDealDetailsScreen(String customerName, int id) async {
    customerId = id;

    _helperServices.navigate(
      CustomerDetailsScreen(
        customerId: id,
        customerName: customerName,
      ),
    );

    await getAllCustomerDeals(
        customerId); // Wait for getAllFabricPurchases to complete
  }

  getAllCustomerDeals(int? customerId) async {
    _helperServices.showLoader();
    final response = await CustomerDealsApiServiceProvider()
        .getCustomerDeals('getCustomerTransaction?customer_id=$customerId');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) {
        allCustomersDeals = r.getCustomerTransaction;
        searchCustomersDeals?.clear();
        searchCustomersDeals?.addAll(allCustomersDeals!);

        _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  searchCustomerDealMethod(String name) {
    searchText = name;
    updateCustomerDealData();
  }

  updateCustomerDealData() {
    searchCustomersDeals?.clear();

    if (searchText.isEmpty) {
      searchCustomersDeals?.addAll(allCustomersDeals!);
    } else {
      searchCustomersDeals?.addAll(
        allCustomersDeals!
            .where((element) =>
                element.row!.toString().toLowerCase().contains(searchText) ||
                element.row!.doller.toString().toLowerCase().contains(searchText) ||
                element.row!.afghani.toString().toLowerCase().contains(searchText) ||
                element.row!.begaknumber.toString().toLowerCase().contains(searchText) ||
                element.row!.date!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    searchText = '';
    updateCustomerDealData();
  }
}
