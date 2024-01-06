import 'package:fabricproject/api/forex_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/forex_model.dart';
import 'package:fabricproject/screens/forex/forex_create_screen.dart';
import 'package:fabricproject/screens/forex/forex_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class ForexController extends ChangeNotifier {
  // is the instance of helper class
  final HelperServices _helperServices;
  // The are used to get and send data to the ui
  TextEditingController fullNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController shopNoController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  //Get all the data from api calls
  List<Data>? allForex = [];
  // Used to filter data
  List<Data>? searchForex = [];
  // Used to get search text in the ui
  String searchText = "";

  ForexController(this._helperServices) {
    // Get all the data when  visits to the page
    getAllForex();
  }

  navigateToForexCreate() {
    // To clear textEditing controllers data
    clearAllControllers();
    // navigate is helper method from helper class to used to navigate pages
    _helperServices.navigate(const ForexCreateScreen());
  }

// this method is called in ui to get data and id in order to edit the item
  navigateToForexEdit(Data data, int id) {
    clearAllControllers();
    // Assigned all these columns to the edit screen using these controllers
    fullNameController.text = data.fullname.toString();
    descriptionController.text = data.description.toString();
    phoneController.text = data.phone.toString();
    shopNoController.text = data.shopno.toString();
    locationController.text = data.location.toString();
    // This is navigating to the edit screen
    _helperServices.navigate(
      ForexEditScreen(
        // These are the edit screen required vars called from its constructor
        forexData: data,
        forexId: id,
      ),
    );
  }

// Gets all the the data from api
  getAllForex() async {
    _helperServices.showLoader();
    // This is api calls provider class
    final response = await ForexApiServiceProvider().getForex('getSarafi');
    // fpDart package method used to handles error and success cases
    response.fold(
      // L fpDart means left or api call failed case
      (l) => {
        // goBack pops the current stack
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      // R fpDart means Right or api call success case will bring the data in it from api
      (r) {
        allForex = r;
        // goBack pops the current stack
        _helperServices.goBack();
        searchForex?.clear();
        searchForex?.addAll(allForex!);
        // this methods assign the recent data to the search List
        // updateForexData();
        notifyListeners();
      },
    );
  }

  createForex() async {
    _helperServices.showLoader();

    var response = await ForexApiServiceProvider().createForex(
      // endPoint passed to the api call class
      'add-sarafi',
      {
        "sarafi_id": 0,
        "fullname": fullNameController.text,
        "description": descriptionController.text,
        "phone": phoneController.text,
        "shopno": shopNoController.text,
        "location": locationController.text,
      },
    );
    response.fold(
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) => {
        getAllForex(),
        _helperServices.goBack(),
        _helperServices.showMessage(
          const LocaleText('added'),
          Colors.green,
          const Icon(
            Icons.check,
            color: Pallete.whiteColor,
          ),
        ),
      },
    );
  }

  editForex(int id) async {
    _helperServices.showLoader();
    var response = await ForexApiServiceProvider().editForex(
      'update-sarafi?sarafi_id=$id',
      {
        "sarafi_id": id,
        "fullname": fullNameController.text,
        "description": descriptionController.text,
        "phone": phoneController.text,
        "shopno": shopNoController.text,
        "location": locationController.text,
      },
    );
    response.fold(
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) => {
        getAllForex(),
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

// This method remove the or delete the item without reloading server
  void deleteItemLocally(int id) {
    final index = allForex!.indexWhere((element) => element.sarafiId == id);
    if (index != -1) {
      allForex!.removeAt(index);

      final searchIndex =
          searchForex!.indexWhere((element) => element.sarafiId == id);
      if (searchIndex != -1) {
        searchForex!.removeAt(searchIndex);
      }

      notifyListeners();
    }
  }

  deleteForex(id, index) async {
    _helperServices.showLoader();
    var response = await ForexApiServiceProvider()
        .deleteForex('delete-sarafi?sarafi_id=$id');
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
        // 500 comes if there is related data in other tables
        // We have to no delete
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

// gets value from search textField ForexController in ui
  searchForexMethod(String text) {
    searchText = text;
    updateForexData();
  }

// updates data into the ui according to the search text
  updateForexData() {
    searchForex?.clear();
    if (searchText.isEmpty) {
      searchForex?.addAll(allForex!);
    } else {
      searchForex?.addAll(
        allForex!
            .where(
              (element) =>
                  // All the columns search filter is applied on
                  element.fullname!.toLowerCase().contains(searchText) ||
                  element.description!.toLowerCase().contains(searchText) ||
                  element.phone!.toLowerCase().contains(searchText) ||
                  element.shopno!.toLowerCase().contains(searchText) ||
                  element.location!.toLowerCase().contains(searchText),
            )
            .toList(),
      );
    }
    notifyListeners();
  }
   // Reset the search text
  void resetSearchFilter() {
    searchText = '';
    updateForexData();
  }

  clearAllControllers() {
    fullNameController.clear();
    descriptionController.clear();
    phoneController.clear();
    shopNoController.clear();
    locationController.clear();
  }
}
