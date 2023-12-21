import 'package:fabricproject/api/customer_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/customer_model.dart';
import 'package:fabricproject/screens/customer/customer_create_screen.dart';
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
  // TextEditingController userController = TextEditingController();
  List<Data>? allCustomers = [];
  List<Data>? searchCustomers = [];
  String searchText = "";

  CustomerController(this._helperServices) {
    getAllCustomers();
  }
  navigateToCustomerCreate() {
    _helperServices.navigate(const CustomerCreateScreen());
  }

  navigateToCustomerEdit(Data data, int id) {
    firstNameController.text = data.firstname.toString();
    lastNameController.text = data.lastname.toString();
    photoController.text = data.photo.toString();
    addressController.text = data.address.toString();
    _helperServices.navigate(CustomerEditScreen(
      customerData: data,
      customerId: id,
    ));
  }

  getAllCustomers() async {
    _helperServices.showLoader();
    final response =
        await CustomerApiServiceProvider().getCustomer('getCustomer');
    response.fold(
        (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
        (r) {
      allCustomers = r;
      _helperServices.goBack();
      updateCustomersData();
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
        "user_id": 1
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
              firstNameController.clear(),
              lastNameController.clear(),
              photoController.clear(),
              addressController.clear(),
            });
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
        "user_id": 1
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
        firstNameController.clear(),
        lastNameController.clear(),
        photoController.clear(),
        addressController.clear(),
      },
    );
  }

  deleteCustomer(id, index) async {
    _helperServices.showLoader();
    var response = await CustomerApiServiceProvider()
        .deleteCustomer('delete-customer?customer_id=$id');
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
            searchCustomers!.removeAt(index),
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

  searchCustomer(String name) {
    searchText = name;
    updateCustomersData();
  }

  updateCustomersData() {
    searchCustomers?.clear();
    if (searchText.isEmpty) {
      searchCustomers?.addAll(allCustomers!);
    } else {
      searchCustomers?.addAll(
        allCustomers!
            .where((element) =>
                element.firstname!.toLowerCase().contains(searchText) ||
                element.lastname!.toLowerCase().contains(searchText) ||
                element.address!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }
}
