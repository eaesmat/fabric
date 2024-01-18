import 'package:fabricproject/api/customer_deal_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/customer_deal_model.dart';
import 'package:fabricproject/screens/customer/customer_details_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class CustomerDealController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController bundleCountController = TextEditingController();
  TextEditingController patiCountController = TextEditingController();
  TextEditingController totalWarController = TextEditingController();
  TextEditingController totalCostDollarController = TextEditingController();
  TextEditingController begakNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController totalCostAfghaniController = TextEditingController();

  int? customerId;
  List<Data>? allCustomersDeals = [];
  List<Data>? searchCustomersDeals = [];
  String searchText = "";

  CustomerDealController(
    this._helperServices,
  ) {
    getAllCustomerDeal(customerId);
  }

  navigateToCustomerDealCreate() {
    clearAllControllers();

    // _helperServices.navigate(const CustomerDealCreateScreen());
  }

  navigateToCustomerDealEdit(int customerDealId, Data dat) async {
    clearAllControllers();

    // _helperServices.navigate(
    //   TransportDealEditScreen(
    //       transportDealData: data, transportDealId: transportDealId ?? 0),
    // );
  }

  navigateToCustomerDealDetailsScreen(String customerName, int id) async {
    clearAllControllers();
    customerId = id;

    _helperServices.navigate(
      CustomerDetailsScreen(
        customerId: id,
        customerName: customerName,
      ),
    );

    await getAllCustomerDeal(
        customerId); // Wait for getAllFabricPurchases to complete
  }

  getAllCustomerDeal(int? customerId) async {
    _helperServices.showLoader();
    final response = await CustomerDealApiServiceProvider()
        .getCustomerDeal('getCustomerDeal');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) {
        allCustomersDeals = r
            .where((customerDeal) => customerDeal.customerId == customerId)
            .toList();
        searchCustomersDeals?.clear();
        searchCustomersDeals?.addAll(allCustomersDeals!);

        _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  createCustomerDeal() async {
    _helperServices.showLoader();

    var response = await CustomerDealApiServiceProvider().createCustomerDeal(
      'add-customer-deal',
      {
        "customerdeal_id": 0,
        "customer_id": customerId.toString(),
        "bundlecount": bundleCountController.text,
        "paticount": patiCountController.text,
        "totalwar": totalWarController.text,
        "totalcostdollar": totalCostDollarController.text,
        "begaknumber": begakNumberController.text,
        "date": dateController.text,
        "user_id": 1,
        "totalcostafghani": totalCostAfghaniController.text,
      },
    );
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        getAllCustomerDeal(customerId!);
        _helperServices.goBack();
        _helperServices.showMessage(
          const LocaleText('added'),
          Colors.green,
          const Icon(
            Icons.check,
            color: Pallete.whiteColor,
          ),
        );
        clearAllControllers();
      },
    );
  }

  editCustomerDeal(int customerDealId) async {
    _helperServices.showLoader();

    var response = await CustomerDealApiServiceProvider().editCustomerDeal(
      'update-customer-deal?$customerDealId',
      {
        "customerdeal_id": customerDealId,
        "customer_id": customerId.toString(),
        "bundlecount": bundleCountController.text,
        "paticount": patiCountController.text,
        "totalwar": totalWarController.text,
        "totalcostdollar": totalCostDollarController.text,
        "begaknumber": begakNumberController.text,
        "date": dateController.text,
        "user_id": 1,
        "totalcostafghani": totalCostAfghaniController.text,
      },
    );
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        _helperServices.goBack();
        _helperServices.showMessage(
          const LocaleText('updated'),
          Colors.green,
          const Icon(
            Icons.check,
            color: Pallete.whiteColor,
          ),
        );

        clearAllControllers();
      },
    );
  }

  deleteCustomerDeal(id, index) async {
    _helperServices.showLoader();
    var response = await CustomerDealApiServiceProvider()
        .deleteCustomerDeal('delete-customer-deal?customerdeal_id=$id');
    _helperServices.goBack();
    response.fold(
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) => {
        if (r == 200)
          {
            _helperServices.showMessage(
              const LocaleText('deleted'),
              Colors.red,
              const Icon(
                Icons.close,
                color: Pallete.whiteColor,
              ),
            ),
            searchCustomersDeals!.removeAt(index),
            notifyListeners(),
          }
        else if (r == 500)
          {
            _helperServices.showMessage(
              const LocaleText('parent'),
              Colors.deepOrange,
              const Icon(
                Icons.warning,
                color: Pallete.whiteColor,
              ),
            ),
          }
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
                element.bundlecount
                    .toString()
                    .toLowerCase()
                    .contains(searchText) ||
                element.paticount
                    .toString()
                    .toLowerCase()
                    .contains(searchText) ||
                element.totalcostdollar
                    .toString()
                    .toLowerCase()
                    .contains(searchText) ||
                element.begaknumber
                    .toString()
                    .toLowerCase()
                    .contains(searchText) ||
                element.totalcostafghani
                    .toString()
                    .toLowerCase()
                    .contains(searchText) ||
                element.totalwar
                    .toString()
                    .toLowerCase()
                    .contains(searchText) ||
                element.date!.toLowerCase().contains(searchText))
            // element.!.toLowerCase().contains(searchText))
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

  void clearAllControllers() {
    bundleCountController.clear();
    patiCountController.clear();
    totalWarController.clear();
    totalCostDollarController.clear();
    begakNumberController.clear();
    dateController.clear();
    totalCostAfghaniController.clear();
  }
}
