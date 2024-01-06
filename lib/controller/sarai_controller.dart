import 'package:fabricproject/api/sarai_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/sarai_model.dart';
import 'package:fabricproject/screens/sarai/sarai_edit_screen.dart';
import 'package:fabricproject/screens/sarai/sarai_create_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class SaraiController extends ChangeNotifier {
  // helper class instance
  // controllers to provide data to the ui and get from
  final HelperServices _helperServices;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  // to store  api call response data
  List<Data>? allSarais = [];
  List<Data>? searchSarais = [];
  // holds text when user search
  String searchText = "";

  SaraiController(this._helperServices) {
    //  get all the data at first visit
    getAllSarais();
  }

  navigateToSaraiCreate() {
    // clear form data
    clearAllControllers();
    // navigates from helper class used to navigate to screen
    _helperServices.navigate(const SaraiCreateScreen());
  }

// gets this data from the list screen
  navigateToSaraiEdit(Data data, int id) {
    // clear form data
    clearAllControllers();

    // pass all the data to the edit screen
    nameController.text = data.name.toString();
    descriptionController.text = data.description.toString();
    phoneController.text = data.phone.toString();
    locationController.text = data.location.toString();
    _helperServices.navigate(
      SaraiEditScreen(
        saraiData: data,
        saraiId: id,
      ),
    );
  }

  getAllSarais() async {
    _helperServices.showLoader();
    // endpoint passed to the api class
    final response = await SaraiApiServiceProvider().getSarai('getSarai');
    response.fold(
      (l) => {
        // l returns failure with status code to the ui
        // goBack pops the current stack

        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) {
        // r holds data comes from api with success

        allSarais = r;
        _helperServices.goBack();
        searchSarais?.clear();
        searchSarais?.addAll(allSarais!);
        // this methods assign the recent data to the search List
        notifyListeners();
      },
    );
  }

  createSarai() async {
    _helperServices.showLoader();

    var response = await SaraiApiServiceProvider().createSarai(
      'add-sarai',
      {
        "sarai_id": 0,
        "name": nameController.text,
        "description": descriptionController.text,
        "phone": phoneController.text,
        "location": locationController.text,
      },
    );
    response.fold(
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) => {
        getAllSarais(),
        _helperServices.goBack(),
        _helperServices.showMessage(
          const LocaleText('added'),
          Colors.green,
          const Icon(
            Icons.check,
            color: Pallete.whiteColor,
          ),
        ),
        clearAllControllers
      },
    );
  }

  editSarai(int id) async {
    _helperServices.showLoader();
    var response = await SaraiApiServiceProvider().editSarai(
      'update-sarai?sarai_id=$id',
      {
        "sarai_id": id,
        "name": nameController.text,
        "description": descriptionController.text,
        "phone": phoneController.text,
        "location": locationController.text,
      },
    );
    response.fold(
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) => {
        getAllSarais(),
        _helperServices.goBack(),
        _helperServices.showMessage(
          const LocaleText('updated'),
          Colors.green,
          const Icon(
            Icons.edit_note_outlined,
            color: Pallete.whiteColor,
          ),
        ),
      },
    );
    clearAllControllers();
  }

// This method removes  or delete the item without reloading server
  void deleteItemLocally(int id) {
    final index = allSarais!.indexWhere((element) => element.saraiId == id);
    if (index != -1) {
      allSarais!.removeAt(index);

      final searchIndex =
          searchSarais!.indexWhere((element) => element.saraiId == id);
      if (searchIndex != -1) {
        searchSarais!.removeAt(searchIndex);
      }

      notifyListeners();
    }
  }

  deleteSarai(id, index) async {
    _helperServices.showLoader();
    var response = await SaraiApiServiceProvider()
        .deleteSarai('delete-sarai?sarai_id=$id');
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

  searchSarisMethod(String name) {
    searchText = name;
    updateSaraisData();
  }

// updates data ui according entered search text
  updateSaraisData() {
    searchSarais?.clear();
    if (searchText.isEmpty) {
      searchSarais?.addAll(allSarais!);
    } else {
      searchSarais?.addAll(
        allSarais!
            .where(
              (element) =>
                  // search filter is applied on these columns

                  element.name!.toLowerCase().contains(searchText) ||
                  element.description!.toLowerCase().contains(searchText) ||
                  element.phone!.toLowerCase().contains(searchText) ||
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
    updateSaraisData();
  }

  void clearAllControllers() {
    nameController.clear();
    descriptionController.clear();
    phoneController.clear();
    locationController.clear();
  }
}
