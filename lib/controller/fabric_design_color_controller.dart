import 'package:fabricproject/api/fabric_design_color_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/fabric_design_color_model.dart';
import 'package:fabricproject/model/fabric_design_model.dart' as fabric_design_data;
import 'package:fabricproject/screens/fabric_design%20_color/fabric_design_color_list_screen.dart';
import 'package:fabricproject/screens/fabric_design%20_color/fabric_design_color_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/no_bundle_color_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class FabricDesignColorController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController selectedColorNameController = TextEditingController();
  TextEditingController selectedColorIdController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  List<Data> allFabricDesignColors = [];
  List<Data> searchFabricDesignColors = [];
  String searchText = "";

  List<Map<String, dynamic>> selectedColors = [];
  List<Map<String, dynamic>> transferFormData = [];
  int fabricDesignId = 0; // Initialize with a default value

  // Cached data to avoid unnecessary API calls
  List<Data> cachedFabricDesignColors = [];

  FabricDesignColorController(this._helperServices);

  void updateJsonData() {
    // Clear data before adding new data
    transferFormData.clear();

    // Add selectedColors data
    transferFormData.addAll([
      {"name": "fd_id", "value": "$fabricDesignId"},
    ]);
    transferFormData.addAll(selectedColors);
    notifyListeners(); // Notify listeners after adding an item
  }

  void addItemToData(String name, String value) {
    selectedColors.add({"name": name, "value": value});
    notifyListeners(); // Notify listeners after adding an item
  }

  void removeItemFromData(String name) {
    selectedColors.removeWhere((item) => item["name"] == name);
  }

  void createColors() {
    updateJsonData();
    createFabricDesignColor();
    clearAllControllers();
  }

  navigateToFabricDesignColorEdit(Data data, int fabricDesignId) {
    clearAllControllers();
    // Populate controllers with existing data for editing
    selectedColorNameController.text = data.colorname.toString();
    selectedColorIdController.text = data.colorId.toString();

    _helperServices.navigate(
      FabricDesignColorEditScreen(
        fabricDesignColorData: data,
        fabricDesignColorId: fabricDesignId,
      ),
    );
  }

  navigateToFabricDesignColorsListScreen(
    String fabricDesignName,
    fabricPurchaseCode,
    int fabricDesignId,
    colorCount,
    colorLength,
    fabric_design_data.Data fabricDesignData,

  ) async {
    if (colorCount == 0) {
      await getAllFabricDesignColors(
        fabricDesignId,
      );
      _helperServices.navigate(
        FabricDesignColorListScreen(
          fabricDesignData: fabricDesignData,
          fabricDesignId: fabricDesignId,
          fabricDesignName: fabricDesignName,
          colorCount: colorCount,
          colorLength: colorLength,
          fabricPurchaseCode: fabricPurchaseCode,
        ),
      );
    } else {
      _helperServices.navigate(
        const NoBundleColorScreen(
            warningText: 'toops_are_added_can_not_add_new_color'),
      );
    }
    this.fabricDesignId = fabricDesignId;
  }

  Future<void> getAllFabricDesignColors(int fabricDesignId) async {
    _helperServices.showLoader();
    try {
      final response = await FabricDesignColorApiServiceProvider()
          .getFabricDesignColor('getFabricDesignColor/$fabricDesignId');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allFabricDesignColors = r;
          searchFabricDesignColors = List.from(allFabricDesignColors);
          cachedFabricDesignColors =
              List.from(allFabricDesignColors); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> createFabricDesignColor() async {
    try {
      var response =
          await FabricDesignColorApiServiceProvider().createFabricDesignColor(
        'add-fabric-design-color',
        transferFormData,
      );

      response.fold(
        (l) {
          _helperServices.showErrorMessage(l);
        },
        (r) {
          if (r == 200) {
            getAllFabricDesignColors(fabricDesignId);
            _helperServices.showMessage(
              const LocaleText('added'),
              Colors.green,
              const Icon(
                Icons.check,
                color: Pallete.whiteColor,
              ),
            );
          }
          if (r == 500) {
            _helperServices.showMessage(
              const LocaleText('duplicated_color_is_not_allowed'),
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

  Future<void> editFabricDesignColor(int fabricDesignColorId) async {
    _helperServices.showLoader();
    try {
      final response =
          await FabricDesignColorApiServiceProvider().editFabricDesignColor(
        'update-fabric-design-color?fabricdesigncolor_id=$fabricDesignColorId',
        {
          "colorname": selectedColorIdController.text,
          "fd_id": fabricDesignId.toString(),
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

          updateFabricDesignColorLocally(
            fabricDesignColorId,
            Data(
              fabricdesigncolorId: fabricDesignColorId,
              colorname: selectedColorNameController.text,
              colorId: int.tryParse(selectedColorIdController.text),
              

            ),
          );
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void updateFabricDesignColorLocally(int id, Data updatedData) {
    int index = allFabricDesignColors
        .indexWhere((element) => element.fabricdesigncolorId == id);
    if (index != -1) {
      allFabricDesignColors[index] = updatedData;
      int cacheIndex = cachedFabricDesignColors
          .indexWhere((element) => element.fabricdesigncolorId == id);
      if (cacheIndex != -1) {
        cachedFabricDesignColors[cacheIndex] = updatedData; // Update cache
      }
      int searchIndex = searchFabricDesignColors
          .indexWhere((element) => element.fabricdesigncolorId == id);
      if (searchIndex != -1) {
        searchFabricDesignColors[searchIndex] =
            updatedData; // Update search list
      }
      notifyListeners();
    }
  }

  Future<void> deleteFabricDesignColor(int fabricDesignColorId) async {
    _helperServices.showLoader();
    try {
      final response = await FabricDesignColorApiServiceProvider()
          .deleteFabricDesignColor(
              'delete-fabric-design-color?fabricdesigncolor_id=$fabricDesignColorId');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          _helperServices.goBack();
          if (r == 200) {
            deleteItemLocally(fabricDesignColorId);
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
    allFabricDesignColors
        .removeWhere((element) => element.fabricdesigncolorId == id);
    cachedFabricDesignColors
        .removeWhere((element) => element.fabricdesigncolorId == id);
    searchFabricDesignColors
        .removeWhere((element) => element.fabricdesigncolorId == id);
    notifyListeners();
  }

  void searchFabricDesignColorsMethod(String text) {
    searchText = text;
    updateFabricDesignColorsData();
  }

  void updateFabricDesignColorsData() {
    searchFabricDesignColors.clear();
    if (searchText.isEmpty) {
      searchFabricDesignColors.addAll(cachedFabricDesignColors);
    } else {
      searchFabricDesignColors.addAll(
        cachedFabricDesignColors
            .where(
              (element) => (element.colorname
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
    updateFabricDesignColorsData();
  }

  void clearAllControllers() {
    selectedColorIdController.clear();
    selectedColorNameController.clear();
    photoController.clear();
    selectedColors.clear();
    notifyListeners();
  }
}
