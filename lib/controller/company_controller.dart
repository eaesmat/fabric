import 'package:fabricproject/api/company_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/company_model.dart';
import 'package:fabricproject/screens/company/company_create_screen.dart';
import 'package:fabricproject/screens/company/company_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class CompanyController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController nameController = TextEditingController();
  TextEditingController markaController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<Data> allCompanies = [];
  List<Data> searchCompanies = [];
  String searchText = "";

  // Cached data to avoid unnecessary API calls
  List<Data> cachedCompanies = [];

  CompanyController(this._helperServices) {
    getAllCompanies();
  }

  navigateToCompanyCreate() {
    clearAllControllers();
    _helperServices.navigate(const CompanyCreateScreen());
  }

  navigateToCompanyEdit(Data data, int id) {
    clearAllControllers();
    nameController.text = data.name ?? '';
    markaController.text = data.marka ?? '';
    descriptionController.text = data.description ?? '';
    _helperServices.navigate(
      CompanyEditScreen(
        companyData: data,
        companyId: id,
      ),
    );
  }

  Future<void> getAllCompanies() async {
    _helperServices.showLoader();
    try {
      final response =
          await CompanyApiServiceProvider().getCompany('getCompany');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allCompanies = r;
          searchCompanies = List.from(allCompanies);
          cachedCompanies = List.from(allCompanies); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> createCompany() async {
    _helperServices.showLoader();
    try {
      final response = await CompanyApiServiceProvider().createCompany(
        'add-company',
        {
          "company_id": 0,
          "name": nameController.text,
          "marka": markaController.text,
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
            getAllCompanies();
          }
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> editCompany(int id) async {
    _helperServices.showLoader();
    try {
      final response = await CompanyApiServiceProvider().editCompany(
        'update-company?company_id=$id',
        {
          "company_id": id,
          "name": nameController.text,
          "marka": markaController.text,
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
          updateCompanyLocally(
            id,
            Data(
              companyId: id,
              name: nameController.text,
              marka: markaController.text,
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

  void updateCompanyLocally(int id, Data updatedData) {
    int index = allCompanies.indexWhere((element) => element.companyId == id);
    if (index != -1) {
      allCompanies[index] = updatedData;
      int cacheIndex =
          cachedCompanies.indexWhere((element) => element.companyId == id);
      if (cacheIndex != -1) {
        cachedCompanies[cacheIndex] = updatedData; // Update cache
      }
      int searchIndex =
          searchCompanies.indexWhere((element) => element.companyId == id);
      if (searchIndex != -1) {
        searchCompanies[searchIndex] = updatedData; // Update search list
      }
      notifyListeners();
    }
  }

  Future<void> deleteCompany(int id) async {
    _helperServices.showLoader();
    try {
      final response = await CompanyApiServiceProvider()
          .deleteCompany('delete-company?company_id=$id');
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
    allCompanies.removeWhere((element) => element.companyId == id);
    cachedCompanies.removeWhere((element) => element.companyId == id);
    searchCompanies.removeWhere((element) => element.companyId == id);
    notifyListeners();
  }

  void searchCompaniesMethod(String text) {
    searchText = text;
    updateCompanyData();
  }

  void updateCompanyData() {
    searchCompanies.clear();
    if (searchText.isEmpty) {
      searchCompanies.addAll(cachedCompanies);
    } else {
      searchCompanies.addAll(
        cachedCompanies
            .where(
              (element) =>
                  (element.name
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.description
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.marka
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
    updateCompanyData();
  }

  void clearAllControllers() {
    nameController.clear();
    descriptionController.clear();
    markaController.clear();
  }
}
