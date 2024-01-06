import 'package:fabricproject/api/company_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/company_model.dart';
import 'package:fabricproject/screens/company/company_create_screen.dart';
import 'package:fabricproject/screens/company/company_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class CompanyController extends ChangeNotifier {
  // helper class instance
  final HelperServices _helperServices;
  // TextEditing Controller to send and receive data from ui
  TextEditingController nameController = TextEditingController();
  TextEditingController markaController = TextEditingController();
  TextEditingController desorptionController = TextEditingController();
  // lists to hold data comes from api
  List<Data>? allCompanies = [];
  List<Data>? searchCompanies = [];
  // this will hold search text field text
  String searchText = "";

  CompanyController(this._helperServices) {
    // Gets data at first visit to the ui
    getAllCompanies();
  }
  // navigate comes to from helper class works as router
  // navigate to the the create page
  navigateToCompanyCreate() {
    clearAllController();
    _helperServices.navigate(const CompanyCreateScreen());
  }

//Pass data and id to the edit screen
  navigateToCompanyEdit(Data data, int id) {
    clearAllController();
    // passed all the data to the edit screen
    nameController.text = data.name.toString();
    markaController.text = data.marka.toString();
    desorptionController.text = data.description.toString();
    _helperServices.navigate(CompanyEditScreen(
      companyData: data,
      companyId: id,
    ));
  }

// gets all the data
  getAllCompanies() async {
    _helperServices.showLoader();
    // endpoint passed to the api class
    final response = await CompanyApiServiceProvider().getCompany('getCompany');
    response.fold(
        (l) => {
// l returns failure with status code to the ui
              _helperServices.goBack(),
              _helperServices.showErrorMessage(l),
            }, (r) {
// r holds data comes from api with success
      allCompanies = r;
      // goBack pops the current stack
      _helperServices.goBack();
      searchCompanies?.clear();
      searchCompanies?.addAll(allCompanies!);
      // this methods assign the recent data to the search List
      // updateForexData();
      notifyListeners();
    });
  }

  createCompany() async {
    _helperServices.showLoader();

    var response = await CompanyApiServiceProvider().createCompany(
      'add-company',
      {
        "company_id": 0,
        "name": nameController.text,
        "marka": markaController.text,
        "description": desorptionController.text,
      },
    );
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) => {
        getAllCompanies(),
        _helperServices.goBack(),
        _helperServices.showMessage(
          const LocaleText('added'),
          Colors.green,
          const Icon(
            Icons.check,
            color: Pallete.whiteColor,
          ),
        ),
        clearAllController(),
      },
    );
  }

  editCompany(int id) async {
    _helperServices.showLoader();

    var response = await CompanyApiServiceProvider().editCompany(
      'update-company?company_id=$id',
      {
        "company_id": id,
        "name": nameController.text,
        "marka": markaController.text,
        "description": desorptionController.text,
      },
    );
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) => {
        getAllCompanies(),
        _helperServices.goBack(),
        _helperServices.showMessage(
          const LocaleText('updated'),
          Colors.green,
          const Icon(
            Icons.edit_note_outlined,
            color: Pallete.whiteColor,
          ),
        ),
        clearAllController(),
      },
    );
  }

// This method removes  or delete the item without reloading server
  void deleteItemLocally(int id) {
    final index =
        allCompanies!.indexWhere((element) => element.companyId == id);
    if (index != -1) {
      allCompanies!.removeAt(index);

      final searchIndex =
          searchCompanies!.indexWhere((element) => element.companyId == id);
      if (searchIndex != -1) {
        searchCompanies!.removeAt(searchIndex);
      }

      notifyListeners();
    }
  }

  deleteCompany(id, index) async {
    _helperServices.showLoader();
    var response = await CompanyApiServiceProvider()
        .deleteCompany('delete-company?company_id=$id');
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
            deleteItemLocally(id),
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

  searchCompaniesMethod(String name) {
    searchText = name;
    updateCompaniesData();
  }

// updates data ui according entered search text
  updateCompaniesData() {
    searchCompanies?.clear();
    if (searchText.isEmpty) {
      searchCompanies?.addAll(allCompanies!);
    } else {
      searchCompanies?.addAll(
        allCompanies!
            .where((element) =>
                // search filter is applied on these columns
                element.name!.toLowerCase().contains(searchText) ||
                element.marka!.toLowerCase().contains(searchText) ||
                element.description!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    searchText = '';
    updateCompaniesData();
  }

  void clearAllController() {
    nameController.clear();
    markaController.clear();
    desorptionController.clear();
  }
}
