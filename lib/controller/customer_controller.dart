import 'package:fabricproject/api/customer_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/customer_model.dart';
import 'package:fabricproject/screens/customer/customer_create_screen.dart';
import 'package:fabricproject/screens/customer/customer_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class CustomerController extends ChangeNotifier {
  // helper class instance

  final HelperServices _helperServices;
  // TextEditing Controller to send and receive data from ui

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController brunchController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  // lists to hold data comes from api
  List<Data>? allCustomers = [];
  List<Data>? searchCustomers = [];
  // this will hold search text field text

  String searchText = "";

  CustomerController(this._helperServices) {
    getAllCustomers();
  }
  // navigate comes to from helper class works as router
  // navigate to the the create page
  navigateToCustomerCreate() {
    clearAllControllers();

    _helperServices.navigate(const CustomerCreateScreen());
  }
//Pass data and id to the edit screen

  navigateToCustomerEdit(Data data, int id) {
    clearAllControllers();
    // passed all the data to the edit screen

    firstNameController.text = data.firstname.toString();
    lastNameController.text = data.lastname.toString();
    photoController.text = data.photo.toString();
    addressController.text = data.address.toString();
    brunchController.text = data.brunch.toString();
    provinceController.text = data.province.toString();
    phoneController.text = data.phone.toString();
    _helperServices.navigate(CustomerEditScreen(
      customerData: data,
      customerId: id,
    ));
  }
// gets all the data

  getAllCustomers() async {
    _helperServices.showLoader();
    final response =
        // endpoint passed to the api class

        await CustomerApiServiceProvider().getCustomer('getCustomer');
    response.fold(
        // l returns failure with status code to the ui

        (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
        (r) {
      // r holds data comes from api with success

      allCustomers = r;
      // goBack pops the current stack
      _helperServices.goBack();
      searchCustomers?.clear();
      searchCustomers?.addAll(allCustomers!);
      // this methods assign the recent data to the search List
      // updateForexData();
      notifyListeners();
    });
  }

  createCustomer() async {
    _helperServices.showLoader();

    var response = await CustomerApiServiceProvider().createCustomer(
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
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) => {
        getAllCustomers(),
        _helperServices.goBack(),
        _helperServices.showMessage(
          const LocaleText('added'),
          Colors.green,
          const Icon(
            Icons.check,
            color: Pallete.whiteColor,
          ),
        ),
        clearAllControllers(),
      },
    );
  }

  editCustomer(int id) async {
    _helperServices.showLoader();

    var response = await CustomerApiServiceProvider().editCustomer(
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
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) => {
        getAllCustomers(),
        _helperServices.goBack(),
        _helperServices.showMessage(
          const LocaleText('updated'),
          Colors.green,
          const Icon(
            Icons.edit_note_outlined,
            color: Pallete.whiteColor,
          ),
        ),
        clearAllControllers(),
      },
    );
  }

// This method removes  or delete the item without reloading server
  void deleteItemLocally(int id) {
    final index =
        allCustomers!.indexWhere((element) => element.customerId == id);
    if (index != -1) {
      allCustomers!.removeAt(index);

      final searchIndex =
          searchCustomers!.indexWhere((element) => element.customerId == id);
      if (searchIndex != -1) {
        searchCustomers!.removeAt(searchIndex);
      }

      notifyListeners();
    }
  }

  deleteCustomer(id, index) async {
    _helperServices.showLoader();
    var response = await CustomerApiServiceProvider()
        .deleteCustomer('delete-customer?customer_id=$id');
    response.fold(
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) => {
        if (r == 200)
          {
            _helperServices.goBack(),
            _helperServices.showMessage(
              const LocaleText('deleted'),
              Colors.red,
              const Icon(
                Icons.close,
                color: Pallete.whiteColor,
              ),
            ),
            deleteItemLocally(id),
          }
        else if (r == 500)
          {
            _helperServices.goBack(),
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

  searchCustomer(String name) {
    searchText = name;
    updateCustomersData();
  }
// updates data ui according entered search text

  updateCustomersData() {
    searchCustomers?.clear();
    if (searchText.isEmpty) {
      searchCustomers?.addAll(allCustomers!);
    } else {
      searchCustomers?.addAll(
        allCustomers!
            .where((element) =>
                // search filter is applied on these columns

                element.firstname!.toLowerCase().contains(searchText) ||
                element.lastname!.toLowerCase().contains(searchText) ||
                element.brunch!.toLowerCase().contains(searchText) ||
                element.province!.toLowerCase().contains(searchText) ||
                element.address!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
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
    phoneController.clear();
  }
}
