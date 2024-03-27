import 'package:fabricproject/api/all_customer_balance_calculation_api.dart';
import 'package:fabricproject/api/customer_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/customer_model.dart';
import 'package:fabricproject/screens/customer/customer_create_screen.dart';
import 'package:fabricproject/screens/customer/customer_details_screen.dart';
import 'package:fabricproject/screens/customer/customer_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class CustomerController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController brunchController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  List<Data> allCustomers = [];
  List<Data> searchCustomers = [];
  double? allTotalCostAfghani = 0;
  double? allTotalCostDoller = 0;
  double? allPaymentAfghani = 0;
  double? allPaymentDoller = 0;
  double? allDueAfghani = 0;
  double? allDueDoller = 0;

  String searchText = "";

  // Cached data to avoid unnecessary API calls
  List<Data> cachedCustomers = [];

  CustomerController(this._helperServices) {
    getAllCustomers();
  }

  navigateToCustomerCreate() {
    clearAllControllers();
    _helperServices.navigate(const CustomerCreateScreen());
  }

  navigateToCustomerDetailsScreen(int customerId, String customerName) {
    _helperServices.navigate(CustomerDetailsScreen(
      customerId: customerId,
      customerName: customerName,
    ));
  }

  navigateToCustomerEdit(Data data, int id) {
    clearAllControllers();
    firstNameController.text = data.firstname ?? '';
    lastNameController.text = data.lastname ?? '';
    photoController.text = data.photo ?? '';
    addressController.text = data.address ?? '';
    brunchController.text = data.branch ?? '';
    provinceController.text = data.province ?? '';
    phoneController.text = data.phone ?? '';
    _helperServices.navigate(CustomerEditScreen(
      customerData: data,
      customerId: id,
    ));
  }

  Future<void> getAllCustomerBalance() async {
    try {
      final response = await AllCustomerBalanceCalculationApiServiceProvider()
          .getAllCustomerBalanceCalculation('totalDollorAfghani');
      response.fold(
        (l) {
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allTotalCostAfghani = r.allTotalCostAfghani;
          allTotalCostDoller = r.allTotalCostDoller;
          allPaymentAfghani = r.allPaymentAfghani;
          allPaymentDoller = r.allPaymentDoller;
          allDueAfghani = r.allDueAfghani;
          allDueDoller = r.allDueDoller;

          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> getAllCustomers() async {
    _helperServices.showLoader();
    try {
      final response =
          await CustomerApiServiceProvider().getCustomer('getCustomer');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allCustomers = r;
          searchCustomers = List.from(allCustomers);
          cachedCustomers = List.from(allCustomers); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
          getAllCustomerBalance();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> createCustomer() async {
    _helperServices.showLoader();
    try {
      final response = await CustomerApiServiceProvider().createCustomer(
        'add-customer',
        {
          "customer_id": 0,
          "firstname": firstNameController.text,
          "lastname": lastNameController.text,
          "photo": photoController.text,
          "address": addressController.text,
          "user_id": 1,
          "brunch": brunchController.text,
          "province": provinceController.text,
          "phone": phoneController.text,
        },
      );
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          _helperServices.goBack();
          if (r == 200) {
            _helperServices.showMessage(
              const LocaleText('added'),
              Colors.green,
              const Icon(
                Icons.check,
                color: Pallete.whiteColor,
              ),
            );
            getAllCustomers();
          }
          clearAllControllers();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> editCustomer(int id) async {
    _helperServices.showLoader();
    try {
      final response = await CustomerApiServiceProvider().editCustomer(
        'update-customer?customer_id=$id',
        {
          "customer_id": id,
          "firstname": firstNameController.text,
          "lastname": lastNameController.text,
          "photo": photoController.text,
          "address": addressController.text,
          "user_id": 1,
          "brunch": brunchController.text,
          "province": provinceController.text,
          "phone": phoneController.text,
        },
      );
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          _helperServices.goBack();
          if (r == 200) {
            _helperServices.showMessage(
              const LocaleText('updated'),
              Colors.green,
              const Icon(
                Icons.edit_note_outlined,
                color: Pallete.whiteColor,
              ),
            );
            updateCustomerLocally(
              id,
              Data(
                customerId: id,
                firstname: firstNameController.text,
                lastname: lastNameController.text,
                photo: photoController.text,
                address: addressController.text,
                branch: brunchController.text,
                province: provinceController.text,
                phone: phoneController.text,
              ),
            );
          }
          clearAllControllers();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void updateCustomerLocally(int id, Data updatedData) {
    int index =
        allCustomers.indexWhere((customer) => customer.customerId == id);
    if (index != -1) {
      allCustomers[index] = updatedData;
      int cacheIndex =
          cachedCustomers.indexWhere((customer) => customer.customerId == id);
      if (cacheIndex != -1) {
        cachedCustomers[cacheIndex] = updatedData; // Update cache
      }
      int searchIndex =
          searchCustomers.indexWhere((customer) => customer.customerId == id);
      if (searchIndex != -1) {
        searchCustomers[searchIndex] = updatedData; // Update search list
      }
      notifyListeners();
    }
  }

  Future<void> deleteCustomer(int id) async {
    _helperServices.showLoader();
    try {
      final response = await CustomerApiServiceProvider()
          .deleteCustomer('delete-customer?customer_id=$id');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          _helperServices.goBack();
          if (r == 200) {
            _helperServices.showMessage(
              const LocaleText('deleted'),
              Colors.red,
              const Icon(
                Icons.close,
                color: Pallete.whiteColor,
              ),
            );
            deleteCustomerLocally(id);
          } else if (r == 500) {
            _helperServices.showMessage(
              const LocaleText('parent'),
              Colors.deepOrange,
              const Icon(
                Icons.warning,
                color: Pallete.whiteColor,
              ),
            );
          }
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void deleteCustomerLocally(int id) {
    allCustomers.removeWhere((customer) => customer.customerId == id);
    cachedCustomers.removeWhere((customer) => customer.customerId == id);
    searchCustomers.removeWhere((customer) => customer.customerId == id);
    notifyListeners();
  }

  void searchCustomer(String name) {
    searchText = name;
    updateCustomersData();
  }

  void updateCustomersData() {
    searchCustomers.clear();
    if (searchText.isEmpty) {
      searchCustomers.addAll(cachedCustomers);
    } else {
      searchCustomers.addAll(
        cachedCustomers.where(
          (customer) =>
              (customer.firstname
                      ?.toLowerCase()
                      .contains(searchText.toLowerCase()) ??
                  false) ||
              (customer.lastname
                      ?.toLowerCase()
                      .contains(searchText.toLowerCase()) ??
                  false) ||
              (customer.branch
                      ?.toLowerCase()
                      .contains(searchText.toLowerCase()) ??
                  false) ||
              (customer.province
                      ?.toLowerCase()
                      .contains(searchText.toLowerCase()) ??
                  false) ||
              (customer.address
                      ?.toLowerCase()
                      .contains(searchText.toLowerCase()) ??
                  false),
        ),
      );
    }
    notifyListeners();
  }

  void resetSearchFilter() {
    searchText = '';
    updateCustomersData();
  }

  void clearAllControllers() {
    firstNameController.clear();
    lastNameController.clear();
    photoController.clear();
    addressController.clear();
    brunchController.clear();
    provinceController.clear();
  }
}
