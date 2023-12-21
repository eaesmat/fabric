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
  TextEditingController desorptionController = TextEditingController();
  // TextEditingController userController = TextEditingController();
  List<Data>? allVendorCompanies = [];
  List<Data>? searchVendorCompanies = [];
  String searchText = "";

  VendorCompanyController(this._helperServices) {
    getAllVendorCompanies();
  }
  navigateToVendorCompanyCreate() {
    _helperServices.navigate(const VendorCompanyCreateScreen());
  }

  navigateToVendorCompanyEdit(Data data, int id) {
    nameController.text = data.name.toString();
    phoneController.text = data.phone.toString();
    desorptionController.text = data.description.toString();
    _helperServices.navigate(
      VendorCompanyEditScreen(vendorCompanyData: data, vendorCompanyId: id),
    );
  }

  

  getAllVendorCompanies() async {
    _helperServices.showLoader();
    final response = await VendorCompanyApiServiceProvider()
        .getVendorCompany('getVendorCompany');
    response.fold(
        (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
        (r) {
      allVendorCompanies = r;
      _helperServices.goBack();
      updateVendorCompaniesData();
    });
  }

  createVendorCompany() async {
    _helperServices.showLoader();

    var response = await VendorCompanyApiServiceProvider().createVendorCompany(
      'add-vendor-company',
      {
        "vendorcompany_id": 0,
        "name": nameController.text,
        "phone": phoneController.text,
        "description": desorptionController.text,
      },
    );
    response.fold(
        (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
        (r) => {
              getAllVendorCompanies(),
              _helperServices.goBack(),
              _helperServices.showMessage(
                const LocaleText('added'),
                Colors.green,
                const Icon(
                  Icons.check,
                  color: Pallete.whiteColor,
                ),
              ),
              nameController.clear(),
              phoneController.clear(),
              desorptionController.clear(),
            });
  }

  editVendorCompany(int id) async {
    _helperServices.showLoader();

    var response = await VendorCompanyApiServiceProvider().editVendorCompany(
      'update-vendor-company?vendorcompany_id=$id',
      {
        "vendorcompany_id": id,
        "name": nameController.text,
        "phone": phoneController.text,
        "description": desorptionController.text,
      },
    );
    response.fold(
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) => {
        getAllVendorCompanies(),
        _helperServices.goBack(),
        _helperServices.showMessage(
          const LocaleText('updated'),
          Colors.green,
          const Icon(
            Icons.edit_note_outlined,
            color: Pallete.whiteColor,
          ),
        ),
        nameController.clear(),
        phoneController.clear(),
        desorptionController.clear(),
      },
    );
  }

  deleteVendorCompany(id, index) async {
    _helperServices.showLoader();
    var response = await VendorCompanyApiServiceProvider()
        .deleteVendorCompany('delete-vendor-company?vendorcompany_id=$id');
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
            searchVendorCompanies!.removeAt(index),
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

  searchVendorCompaniesMethod(String name) {
    searchText = name;
    updateVendorCompaniesData();
  }

  updateVendorCompaniesData() {
    searchVendorCompanies?.clear();
    if (searchText.isEmpty) {
      searchVendorCompanies?.addAll(allVendorCompanies!);
    } else {
      searchVendorCompanies?.addAll(
        allVendorCompanies!
            .where((element) =>
                element.name!.toLowerCase().contains(searchText) ||
                element.phone!.toLowerCase().contains(searchText) ||
                element.description!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }
}
