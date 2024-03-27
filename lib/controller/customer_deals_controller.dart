import 'package:fabricproject/api/customer_calculation_api.dart';
import 'package:fabricproject/api/customer_deals_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/customer_deals_model.dart';
import 'package:fabricproject/screens/customer/customer_details_screen.dart';
import 'package:flutter/material.dart';

class CustomerDealsController extends ChangeNotifier {
  final HelperServices _helperServices;

  List<Data> allCustomersDeals = [];
  List<Data> searchCustomersDeals = [];
  List<Data> cachedCustomerDeals = [];
  double? afghaniDeal = 0;
  double? afghaniPayment = 0;
  double? afghaniDue = 0;
  double? dollorDue = 0;
  double? dollorDeal = 0;
  double? dollorPayment = 0;

  String searchText = "";

  CustomerDealsController(
    this._helperServices,
  );

  navigateToCustomerDealDetailsScreen(
      String customerName, int customerId) async {
    _helperServices.navigate(
      CustomerDetailsScreen(
        customerId: customerId,
        customerName: customerName,
      ),
    );

    await getAllCustomerDeals(customerId);
  }

// Function to fetch all customer deals from the API
  Future<void> getAllCustomerDeals(int customerId) async {
    _helperServices.showLoader();
    try {
      final response = await CustomerDealsApiServiceProvider()
          .getCustomerDeals('getCustomerDeals?customer_id=$customerId');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allCustomersDeals = r;
          searchCustomersDeals = List.from(allCustomersDeals);
          cachedCustomerDeals = List.from(allCustomersDeals);
          _helperServices.goBack();
          notifyListeners();
          getAllCustomerBalance(customerId);
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> getAllCustomerBalance(int customerId) async {
    try {
      final response = await CustomerCalculationApiServiceProvider()
          .getAllCustomerBalanceCalculation(
              'getDollorAfghaniCustomer?customer_id=$customerId');
      response.fold(
        (l) {
          _helperServices.showErrorMessage(l);
        },
        (r) {
          // Check if the data already exists in the list, if not, add it

         afghaniDeal = r.afghaniDeal;
         afghaniDue = r.afghaniDue;
         afghaniPayment = r.afghaniPayment;
         dollorDeal = r.dollorDeal;
         dollorDue = r.dollorDue;
         dollorPayment = r.dollorPayment;
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  searchCustomerDealMethod(String name) {
    searchText = name;
    updateCustomerDealData();
  }

  void updateCustomerDealData() {
    searchCustomersDeals.clear();

    if (searchText.isEmpty) {
      searchCustomersDeals.addAll(cachedCustomerDeals);
    } else {
      searchCustomersDeals.addAll(
        cachedCustomerDeals
            .where((element) =>
                (element.type?.toString().toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
                (element.date
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
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
                (element.doller
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.balanceAfghani
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.balanceAfghani
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.afghani
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.doller?.toString().toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
                (element.date?.toString().toLowerCase().contains(searchText.toLowerCase()) ?? false))
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
