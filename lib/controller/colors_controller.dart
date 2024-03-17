import 'package:fabricproject/api/colors_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/colors_model.dart';
import 'package:fabricproject/screens/fabric_design%20_color/color_create_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class ColorsController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController colorNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<Data> allColors = [];
  List<Data> searchColors = [];
  String searchText = "";
  List<Data>? selectedColors = [];

  // Cached data to avoid unnecessary API calls
  List<Data> cachedColors = [];

  ColorsController(this._helperServices) {
    getAllColors();
  }
  void addColorToSelected(Data color) {
    selectedColors ??= [];
    selectedColors!.add(color);
    notifyListeners();
  }

  // Method to remove an item from selectedItems
  void removeColorFromSelected(Data item) {
    selectedColors?.remove(item);
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }

  navigateToColorCreate() {
    clearAllControllers();
    _helperServices.navigate(
      const ColorCreateScreen(),
    );
  }

  navigateToForexEdit(Data data, int id) {
    clearAllControllers();
    colorNameController.text = data.colorname ?? '';
    descriptionController.text = data.colordescription ?? '';

    // _helperServices.navigate(
    //   ForexEditScreen(
    //     forexData: data,
    //     forexId: id,
    //   ),
    // );
  }

  Future<void> getAllColors() async {
    _helperServices.showLoader();
    try {
      final response = await ColorsApiServiceProvider().getColor('loadColors');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allColors = r;
          searchColors = List.from(allColors);
          cachedColors = List.from(allColors); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> createColor() async {
    // _helperServices.showLoader();
    try {
      final response = await ColorsApiServiceProvider().createColor(
        'storeColor',
        {
          "value": colorNameController.text, // values takes the color name
          "description": descriptionController.text,
        },
      );

      response.fold(
        (l) {
          // _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          // _helperServices.goBack();

          _helperServices.showMessage(
            const LocaleText('added'),
            Colors.green,
            const Icon(
              Icons.check,
              color: Pallete.whiteColor,
            ),
          );
          print(r);

          // Add the new color locally
          _addColorLocally(
              r, colorNameController.text, descriptionController.text);

          // Clear text controllers
          clearAllControllers();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void _addColorLocally(int colorId, String colorName, String description) {
    Data newColor = Data(
      colorId: colorId,
      colorname: colorName,
      colordescription: description,
    );
    allColors.add(newColor);
    cachedColors.add(newColor);
    searchColors.add(newColor);
    notifyListeners();
  }

  void searchColorsMethod(String text) {
    searchText = text;
    updateForexData();
  }

  void updateForexData() {
    searchColors.clear();
    if (searchText.isEmpty) {
      searchColors.addAll(cachedColors);
    } else {
      searchColors.addAll(
        cachedColors
            .where(
              (element) =>
                  (element.colorname
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.colordescription
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

  void clearAllControllers() {
    colorNameController.clear();
    descriptionController.clear();
    selectedColors?.clear();
  }
}
