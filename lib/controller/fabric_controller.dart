import 'package:fabricproject/api/fabric_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/fabric_model.dart';
import 'package:fabricproject/screens/fabric/fabric_create_screen.dart';
import 'package:fabricproject/screens/fabric/fabric_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class FabricController extends ChangeNotifier {
// helper class instance
  final HelperServices _helperServices;
  // provides and gets data from and to the ui
  TextEditingController nameController = TextEditingController();
  TextEditingController desorptionController = TextEditingController();
  TextEditingController abrController = TextEditingController();
// will hold api calls data
  List<Data>? allFabrics = [];
  List<Data>? searchFabrics = [];
// holds search textfield text from ui
  String searchText = "";

  FabricController(this._helperServices) {
// get all the data at first visit
    getAllFabrics();
  }
// used as router to navigate to the create screen
  navigateToFabricCreate() {
    clearAllControllers();
// navigate comes from helper class
    _helperServices.navigate(const FabricCreateScreen());
  }

  navigateToFabricEdit(Data data, int id) {
    clearAllControllers();
// passed the data to the edit screen textfield
    nameController.text = data.name.toString();
    abrController.text = data.abr.toString();
    desorptionController.text = data.description.toString();
    _helperServices.navigate(FabricEditScreen(
// passes data from constructor
      fabricData: data,
      fabricId: id,
    ));
  }

  getAllFabrics() async {
    _helperServices.showLoader();
// passes the endPont to the api calls class
    final response = await FabricApiServiceProvider().getFabric('getFabric');
    response.fold(
// left return failure message or status code
        (l) => {
              _helperServices.goBack(),
              _helperServices.showErrorMessage(l),
            }, (r) {
// r return data or status code
      allFabrics = r;
      _helperServices.goBack();
      updateFabricsData();
    });
  }

  createFabric() async {
    _helperServices.showLoader();

    var response = await FabricApiServiceProvider().createFabric(
      'add-fabric',
      {
        "fabric_id": 0,
        "name": nameController.text,
        "description": desorptionController.text,
        "abr": abrController.text,
      },
    );
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) => {
        getAllFabrics(),
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

  editFabric(int id) async {
    _helperServices.showLoader();

    var response = await FabricApiServiceProvider().editFabric(
      'update-fabric?fabric_id=$id',
      {
        "fabric_id": id,
        "name": nameController.text,
        "description": desorptionController.text,
        "abr": abrController.text,
      },
    );
    response.fold(
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) => {
        getAllFabrics(),
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

  void deleteItemLocally(int id) {
    final index = allFabrics!.indexWhere((element) => element.fabricId == id);
    if (index != -1) {
      allFabrics!.removeAt(index);

      final searchIndex =
          searchFabrics!.indexWhere((element) => element.fabricId == id);
      if (searchIndex != -1) {
        searchFabrics!.removeAt(searchIndex);
      }

      notifyListeners();
    }
  }

  deleteFabric(id, index) async {
    _helperServices.showLoader();
    var response = await FabricApiServiceProvider()
        .deleteFabric('delete-fabric?fabric_id=$id');
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
// is it is 500 means it is parent can not be deleted
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

// filters item in ui
  searchFabricsMethod(String name) {
    searchText = name;
    updateFabricsData();
  }

// provides data based on
  updateFabricsData() {
    searchFabrics?.clear();
    if (searchText.isEmpty) {
      searchFabrics?.addAll(allFabrics!);
    } else {
      searchFabrics?.addAll(
        allFabrics!
            .where((element) =>
                // search happen based on this fields
                element.name!.toLowerCase().contains(searchText) ||
                element.description!.toLowerCase().contains(searchText) ||
                element.abr!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }
   // Reset the search text
  void resetSearchFilter() {
    searchText = '';
    updateFabricsData();
  }

  void clearAllControllers() {
    nameController.clear();
    desorptionController.clear();
    abrController.clear();
  }
}
