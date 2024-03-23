import 'package:fabricproject/api/vendor_company_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/vendor_company_model.dart';
import 'package:fabricproject/screens/vendor_company/vendor_company_create_screen.dart';
import 'package:fabricproject/screens/vendor_company/vendor_company_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class VendorCompanyController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<Data> allVendorCompanies = [];
  List<Data> searchVendorCompanies = [];
  String searchText = "";

  // Cached data to avoid unnecessary API calls
  List<Data> cachedVendorCompanies = [];

  VendorCompanyController(this._helperServices) {
    getAllVendorCompanies();
  }

  navigateToVendorCompanyCreate() {
    clearAllControllers();
    _helperServices.navigate(const VendorCompanyCreateScreen());
  }

  navigateToVendorCompanyEdit(Data data, int id) {
    clearAllControllers();
    nameController.text = data.name ?? '';
    phoneController.text = data.phone ?? '';
    descriptionController.text = data.description ?? '';
    _helperServices.navigate(
      VendorCompanyEditScreen(
        vendorCompanyData: data,
        vendorCompanyId: id,
      ),
    );
  }

  Future<void> getAllVendorCompanies() async {
    _helperServices.showLoader();
    try {
      final response = await VendorCompanyApiServiceProvider()
          .getVendorCompany('getVendorCompany');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allVendorCompanies = r;
          searchVendorCompanies = List.from(allVendorCompanies);
          cachedVendorCompanies =
              List.from(allVendorCompanies); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> createVendorCompany() async {
    _helperServices.showLoader();
    try {
      final response =
          await VendorCompanyApiServiceProvider().createVendorCompany(
        'add-vendor-company',
        {
          "vendor_name": nameController.text,
          "phone": phoneController.text,
          "description": descriptionController.text,
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
            getAllVendorCompanies();
          }
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> editVendorCompany(int id) async {
    _helperServices.showLoader();
    try {
      final response =
          await VendorCompanyApiServiceProvider().editVendorCompany(
        'update-vendor-company?vendorcompany_id=$id',
        {
          "vendorcompany_id": id,
          "name": nameController.text,
          "phone": phoneController.text,
          "description": descriptionController.text,
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
              Icons.edit_note_outlined,
              color: Pallete.whiteColor,
            ),
          );
          updateVendorCompanyLocally(
            id,
            Data(
              vendorcompanyId: id,
              name: nameController.text,
              phone: phoneController.text,
              description: descriptionController.text,
            ),
          );
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void updateVendorCompanyLocally(int id, Data updatedData) {
    int index = allVendorCompanies
        .indexWhere((element) => element.vendorcompanyId == id);
    if (index != -1) {
      allVendorCompanies[index] = updatedData;
      int cacheIndex = cachedVendorCompanies
          .indexWhere((element) => element.vendorcompanyId == id);
      if (cacheIndex != -1) {
        cachedVendorCompanies[cacheIndex] = updatedData; // Update cache
      }
      int searchIndex = searchVendorCompanies
          .indexWhere((element) => element.vendorcompanyId == id);
      if (searchIndex != -1) {
        searchVendorCompanies[searchIndex] = updatedData; // Update search list
      }
      notifyListeners();
    }
  }

  Future<void> deleteVendorCompany(int id) async {
    _helperServices.showLoader();
    try {
      final response = await VendorCompanyApiServiceProvider()
          .deleteVendorCompany('delete-vendor-company?vendorcompany_id=$id');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          _helperServices.goBack();
          if (r == 200) {
            deleteItemLocally(id);
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
    allVendorCompanies.removeWhere((element) => element.vendorcompanyId == id);
    cachedVendorCompanies
        .removeWhere((element) => element.vendorcompanyId == id);
    searchVendorCompanies
        .removeWhere((element) => element.vendorcompanyId == id);
    notifyListeners();
  }

  void searchVendorCompaniesMethod(String text) {
    searchText = text;
    updateVendorCompaniesData();
  }

  void updateVendorCompaniesData() {
    searchVendorCompanies.clear();
    if (searchText.isEmpty) {
      searchVendorCompanies.addAll(cachedVendorCompanies);
    } else {
      searchVendorCompanies.addAll(
        cachedVendorCompanies
            .where(
              (element) =>
                  (element.name
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.phone
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.description
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false),
            )
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    searchText = '';
    updateVendorCompaniesData();
  }

  void clearAllControllers() {
    nameController.clear();
    phoneController.clear();
    descriptionController.clear();
  }
}
