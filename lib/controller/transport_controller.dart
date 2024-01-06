import 'package:fabricproject/api/transport_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/transport_model.dart';
import 'package:fabricproject/screens/transport/transport_create_screen.dart';
import 'package:fabricproject/screens/transport/transport_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class TransportController extends ChangeNotifier {
  // helper class instance
  final HelperServices _helperServices;
  // TextEditing Controller to send and receive data from ui
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController desorptionController = TextEditingController();
  // lists to hold data comes from api

  List<Data>? allTransports = [];
  List<Data>? searchTransports = [];
  // this will hold search text field text
  String searchText = "";

  TransportController(this._helperServices) {
    // Gets data at first visit to the ui
    getAllTransports();
  }
  navigateToTransportCreate() {
    clearAllControllers();
    // navigate comes to from helper class works as router
    // navigate to the the create page
    _helperServices.navigate(const TransportCreateScreen());
  }

  navigateToTransportEdit(Data data, int id) {
    clearAllControllers();
    // passed all the data to the edit screen
    nameController.text = data.name.toString();
    phoneController.text = data.phone.toString();
    desorptionController.text = data.description.toString();
    _helperServices.navigate(
      TransportEditScreen(transportData: data, transportId: id),
    );
  }
// gets all the data

  getAllTransports() async {
    _helperServices.showLoader();
    final response =
        await TransportApiServiceProvider().getTransport('getTransport');
    // endpoint passed to the api class

    response.fold(
        (l) => {
              // l returns failure with status code to the ui

              _helperServices.goBack(),
              _helperServices.showErrorMessage(l),
            }, (r) {
      // r holds data comes from api with success

      allTransports = r;
      _helperServices.goBack();
      updateTransportsData();
    });
  }

  createTransport() async {
    _helperServices.showLoader();

    var response = await TransportApiServiceProvider().createTransport(
      'add-transport',
      {
        "transport_id": 0,
        "name": nameController.text,
        "phone": phoneController.text,
        "description": desorptionController.text,
      },
    );
    response.fold(
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) => {
        getAllTransports(),
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

  editTransport(int id) async {
    _helperServices.showLoader();

    var response = await TransportApiServiceProvider().editTransport(
      'update-transport?transport_id=$id',
      {
        "transport_id": id,
        "name": nameController.text,
        "phone": phoneController.text,
        "description": desorptionController.text,
      },
    );
    response.fold(
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) => {
        getAllTransports(),
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
        allTransports!.indexWhere((element) => element.transportId == id);
    if (index != -1) {
      allTransports!.removeAt(index);

      final searchIndex =
          searchTransports!.indexWhere((element) => element.transportId == id);
      if (searchIndex != -1) {
        searchTransports!.removeAt(searchIndex);
      }

      notifyListeners();
    }
  }

  deleteTransport(id, index) async {
    _helperServices.showLoader();
    var response = await TransportApiServiceProvider()
        .deleteTransport('delete-transport?transport_id=$id');
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

  searchTransportsMethod(String name) {
    searchText = name;
    updateTransportsData();
  }
// updates data ui according entered search text

  updateTransportsData() {
    searchTransports?.clear();
    if (searchText.isEmpty) {
      searchTransports?.addAll(allTransports!);
    } else {
      searchTransports?.addAll(
        // search filter is applied on these columns

        allTransports!
            .where((element) =>
                element.name!.toLowerCase().contains(searchText) ||
                element.phone!.toLowerCase().contains(searchText) ||
                element.description!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    searchText = '';
    updateTransportsData();
  }

  void clearAllControllers() {
    nameController.clear();
    phoneController.clear();
    desorptionController.clear();
  }
}
