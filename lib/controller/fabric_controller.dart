import 'package:fabricproject/api/fabric_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/fabric_model.dart';
import 'package:fabricproject/screens/fabric/fabric_create_screen.dart';
import 'package:fabricproject/screens/fabric/fabric_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class FabricController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController abrController = TextEditingController();
  List<Data> allFabrics = [];
  List<Data> searchFabrics = [];
  String searchText = "";

  // Cached data to avoid unnecessary API calls
  List<Data> cachedFabrics = [];

  FabricController(this._helperServices) {
    getAllFabrics();
  }

  navigateToFabricCreate() {
    clearAllControllers();
    _helperServices.navigate(const FabricCreateScreen());
  }

  navigateToFabricEdit(Data data, int id) {
    clearAllControllers();
    nameController.text = data.name ?? '';
    abrController.text = data.abr ?? '';
    descriptionController.text = data.description ?? '';
    _helperServices.navigate(FabricEditScreen(
      fabricData: data,
      fabricId: id,
    ));
  }

  Future<void> getAllFabrics() async {
    _helperServices.showLoader();
    try {
      final response = await FabricApiServiceProvider().getFabric('getFabric');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allFabrics = r;
          searchFabrics = List.from(allFabrics);
          cachedFabrics = List.from(allFabrics); // Cache initial data
          _helperServices.goBack();
          updateFabricsData();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> createFabric() async {
    _helperServices.showLoader();
    try {
      final response = await FabricApiServiceProvider().createFabric(
        'add-fabric',
        {
          "fabric_id": 0,
          "name": nameController.text,
          "description": descriptionController.text,
          "abr": abrController.text,
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
            getAllFabrics();
          }
          clearAllControllers();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> editFabric(int id) async {
    _helperServices.showLoader();
    try {
      final response = await FabricApiServiceProvider().editFabric(
        'update-fabric?fabric_id=$id',
        {
          "fabric_id": id,
          "name": nameController.text,
          "description": descriptionController.text,
          "abr": abrController.text,
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
              const LocaleText('updated'),
              Colors.green,
              const Icon(
                Icons.edit_note_outlined,
                color: Pallete.whiteColor,
              ),
            );
            updateFabricLocally(
              id,
              Data(
                fabricId: id,
                name: nameController.text,
                description: descriptionController.text,
                abr: abrController.text,
              ),
            );
          }
          clearAllControllers();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void updateFabricLocally(int id, Data updatedData) {
    int index = allFabrics.indexWhere((element) => element.fabricId == id);
    if (index != -1) {
      allFabrics[index] = updatedData;
      int cacheIndex =
          cachedFabrics.indexWhere((element) => element.fabricId == id);
      if (cacheIndex != -1) {
        cachedFabrics[cacheIndex] = updatedData; // Update cache
      }
      int searchIndex =
          searchFabrics.indexWhere((element) => element.fabricId == id);
      if (searchIndex != -1) {
        searchFabrics[searchIndex] = updatedData; // Update search list
      }
      notifyListeners();
    }
  }

  void deleteItemLocally(int id) {
    allFabrics.removeWhere((element) => element.fabricId == id);
    cachedFabrics.removeWhere((element) => element.fabricId == id);
    searchFabrics.removeWhere((element) => element.fabricId == id);
    notifyListeners();
  }

  Future<void> deleteFabric(int id) async {
    _helperServices.showLoader();
    try {
      final response = await FabricApiServiceProvider()
          .deleteFabric('delete-fabric?fabric_id=$id');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          _helperServices.goBack();
          if (r == 200) {
            _helperServices.showMessage(
              const LocaleText('deleted'),
              Colors.red,
              const Icon(
                Icons.close,
                color: Pallete.whiteColor,
              ),
            );
            deleteItemLocally(id);
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

  searchFabricsMethod(String text) {
    searchText = text;
    updateFabricsData();
  }

  updateFabricsData() {
    searchFabrics.clear();
    if (searchText.isEmpty) {
      searchFabrics.addAll(cachedFabrics);
    } else {
      searchFabrics.addAll(
        cachedFabrics.where(
          (element) =>
              (element.name
                      ?.toLowerCase()
                      .contains(searchText.toLowerCase()) ??
                  false) ||
              (element.description
                      ?.toLowerCase()
                      .contains(searchText.toLowerCase()) ??
                  false) ||
              (element.abr?.toLowerCase().contains(searchText.toLowerCase()) ??
                  false),
        ),
      );
    }
    notifyListeners();
  }

  void resetSearchFilter() {
    searchText = '';
    updateFabricsData();
  }

  void clearAllControllers() {
    nameController.clear();
    descriptionController.clear();
    abrController.clear();
  }
}
