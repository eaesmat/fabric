import 'package:fabricproject/api/forex_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/forex_model.dart';
import 'package:fabricproject/screens/forex/forex_create_screen.dart';
import 'package:fabricproject/screens/forex/forex_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class ForexController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController shopNoController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  List<Data> allForex = [];
  List<Data> searchForex = [];
  String searchText = "";

  // Cached data to avoid unnecessary API calls
  List<Data> cachedForex = [];

  ForexController(this._helperServices) {
    getAllForex();
  }

  navigateToForexCreate() {
    clearAllControllers();
    _helperServices.navigate(const ForexCreateScreen());
  }

  navigateToForexEdit(Data data, int id) {
    clearAllControllers();
    fullNameController.text = data.fullname ?? '';
    descriptionController.text = data.description ?? '';
    phoneController.text = data.phone ?? '';
    shopNoController.text = data.shopno ?? '';
    locationController.text = data.location ?? '';
    _helperServices.navigate(
      ForexEditScreen(
        forexData: data,
        forexId: id,
      ),
    );
  }

  Future<void> getAllForex() async {
    _helperServices.showLoader();
    try {
      final response = await ForexApiServiceProvider().getForex('getSarafi');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allForex = r;
          searchForex = List.from(allForex);
          cachedForex = List.from(allForex); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> createForex() async {
    _helperServices.showLoader();
    try {
      final response = await ForexApiServiceProvider().createForex(
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
            getAllForex();
          }
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> editForex(int id) async {
    _helperServices.showLoader();
    try {
      final response = await ForexApiServiceProvider().editForex(
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

          updateForexLocally(
            id,
            Data(
              sarafiId: id,
              fullname: fullNameController.text,
              description: descriptionController.text,
              phone: phoneController.text,
              shopno: shopNoController.text,
              location: locationController.text,
            ),
          );
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void updateForexLocally(int id, Data updatedData) {
    int index = allForex.indexWhere((element) => element.sarafiId == id);
    if (index != -1) {
      allForex[index] = updatedData;
      int cacheIndex =
          cachedForex.indexWhere((element) => element.sarafiId == id);
      if (cacheIndex != -1) {
        cachedForex[cacheIndex] = updatedData; // Update cache
      }
      int searchIndex =
          searchForex.indexWhere((element) => element.sarafiId == id);
      if (searchIndex != -1) {
        searchForex[searchIndex] = updatedData; // Update search list
      }
      notifyListeners();
    }
  }

  Future<void> deleteForex(int id, int index) async {
    _helperServices.showLoader();
    try {
      final response = await ForexApiServiceProvider()
          .deleteForex('delete-sarafi?sarafi_id=$id');
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

  void searchForexMethod(String text) {
    searchText = text;
    updateForexData();
  }

  void updateForexData() {
    searchForex.clear();
    if (searchText.isEmpty) {
      searchForex.addAll(cachedForex);
    } else {
      searchForex.addAll(
        cachedForex
            .where(
              (element) =>
                  (element.fullname
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.description
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.phone
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.shopno
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.location
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
    updateForexData();
  }

  void deleteItemLocally(int id) {
    allForex.removeWhere((element) => element.sarafiId == id);
    cachedForex.removeWhere((element) => element.sarafiId == id);
    searchForex.removeWhere((element) => element.sarafiId == id);
    notifyListeners();
  }

  void clearAllControllers() {
    fullNameController.clear();
    descriptionController.clear();
    phoneController.clear();
    shopNoController.clear();
    locationController.clear();
  }
}
