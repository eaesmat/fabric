import 'package:fabricproject/api/customer_rasidat_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/customer_rasidat_model.dart';
import 'package:fabricproject/screens/customer_rasidat/customer_rasidat_create_screen.dart';
import 'package:fabricproject/screens/customer_rasidat/customer_rasidat_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class CustomerRasidatController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController byPersonController = TextEditingController();
  List<Data> allCustomerRasidat = [];
  List<Data> searchCustomerRasidat = [];
  String searchText = "";
  String amountTypeController = "دالر";

  // Cached data to avoid unnecessary API calls
  List<Data> cachedCustomerRasidat = [];

  CustomerRasidatController(this._helperServices);

  navigateToCustomerRasidatCreate(int customerId) {
    clearAllControllers();
    _helperServices.navigate(
      CustomerRasidatCreateScreen(
        customerId: customerId,
      ),
    );
  }

  navigateToCustomerRasidatEdit(Data data) {
    clearAllControllers();
    if (data.afghani != 0) {
      amountTypeController = 'افغانی';
      amountController.text = data.afghani.toString();
    } else {
      amountTypeController = 'دالر';
      amountController.text = data.dollor.toString();
    }
    descriptionController.text = data.description ?? '';
    byPersonController.text = data.person ?? '';
    _helperServices.navigate(
      CustomerRasidatEditScreen(
        customerId: data.customerId!,
        rasidId: data.rasidId!.toInt(),
        amountType: amountTypeController.toString(),
      ),
    );
  }

  Future<void> geAllCustomerRasidat(int customerId) async {
    _helperServices.showLoader();
    try {
      final response = await CustomerRasidatApiServiceProvider()
          .getCustomerRasidat('getCustomerRasid?customer_id=$customerId');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allCustomerRasidat = r;
          searchCustomerRasidat = List.from(allCustomerRasidat);
          cachedCustomerRasidat =
              List.from(allCustomerRasidat); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> createCustomerRasidat(int customerId) async {
    _helperServices.showLoader();
    try {
      final response =
          await CustomerRasidatApiServiceProvider().createCustomerRasidat(
        'addCustomerPageRasid',
        {
          "type": amountTypeController,
          "amount": amountController.text,
          "person": byPersonController.text,
          "description": descriptionController.text,
          "customer_id": customerId,
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
            geAllCustomerRasidat(customerId);
            _helperServices.showMessage(
              const LocaleText('added'),
              Colors.green,
              const Icon(
                Icons.check,
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

  Future<void> editCustomerRasidat(int customerId, rasidId) async {
    _helperServices.showLoader();

    try {
      final response =
          await CustomerRasidatApiServiceProvider().editCustomerRasidat(
        'updateCustomerPageRasid?customerpayment_id=$rasidId',
        {
          "type": amountTypeController,
          "amount": amountController.text,
          "person": byPersonController.text,
          "description": descriptionController.text,
          "customer_id": customerId,
        },
      );
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          _helperServices.goBack();
          geAllCustomerRasidat(customerId);
          _helperServices.showMessage(
            const LocaleText('updated'),
            Colors.green,
            const Icon(
              Icons.edit_note_outlined,
              color: Pallete.whiteColor,
            ),
          );
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> deleteCustomerRasidat(int customerRaidatId) async {
    _helperServices.showLoader();
    try {
      final response = await CustomerRasidatApiServiceProvider()
          .deleteCustomerRasidat(
              'destroyCustomerPageRasid?customerpayment_id=$customerRaidatId');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          _helperServices.goBack();
          if (r == 200) {
            deleteItemLocally(customerRaidatId);
            _helperServices.showMessage(
              const LocaleText('deleted'),
              Colors.red,
              const Icon(
                Icons.close,
                color: Pallete.whiteColor,
              ),
            );
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

  void deleteItemLocally(int id) {
    allCustomerRasidat.removeWhere((element) => element.rasidId == id);
    cachedCustomerRasidat.removeWhere((element) => element.rasidId == id);
    searchCustomerRasidat.removeWhere((element) => element.rasidId == id);
    notifyListeners();
  }

  void searchCustomerRasidatMethod(String text) {
    searchText = text;
    updateCustomerRasidatData();
  }

  void updateCustomerRasidatData() {
    searchCustomerRasidat.clear();
    if (searchText.isEmpty) {
      searchCustomerRasidat.addAll(cachedCustomerRasidat);
    } else {
      searchCustomerRasidat.addAll(
        cachedCustomerRasidat
            .where(
              (element) =>
                  (element.date
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.description
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.dollor
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.afghani
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.person
                          ?.toLowerCase()
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
    updateCustomerRasidatData();
  }

  void clearAllControllers() {
    amountTypeController = "";
    descriptionController.clear();
    amountController.clear();
    byPersonController.clear();
  }
}
