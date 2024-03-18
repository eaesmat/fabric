import 'package:fabricproject/api/fabric_design_toop_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/fabric_design_toop_model.dart';
import 'package:fabricproject/screens/fabric_design_bundle_toop/fabric_design_bundle_toop_edit_screen.dart';
import 'package:fabricproject/screens/fabric_design_bundle_toop/fabric_design_bundle_toop_list_screen.dart';
import 'package:fabricproject/screens/fabric_design_bundle_toop/fabric_design_bundle_toop_create_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:fabricproject/model/fabric_design_bundle_toop_color_model.dart'
    // ignore: library_prefixes
    as fabricDBTColor;

class FabricDesignToopController extends ChangeNotifier {
  final HelperServices _helperServices;

  TextEditingController selectedColorNameController = TextEditingController();
  TextEditingController selectedColorIdController = TextEditingController();
  TextEditingController warToopController = TextEditingController();

  List<Data> allFabricDesignToop = [];
  List<Data> searchFabricDesignToop = [];
  List<Data> cachedFabricDesignToop = [];
// for fabricDesignBundleColors to get them
  List<fabricDBTColor.Data> allFabricDesignToopColors = [];
  List<fabricDBTColor.Data> searchFabricDesignToopColors = [];
  List<fabricDBTColor.Data> cachedFabricDesignToopColors = [];
  String searchText = "";

  int? remainingToop = 0;
  int? totalWar = 0;
  int fabricDesignBundleId = 0;

  // Cached data to avoid unnecessary API calls

  FabricDesignToopController(this._helperServices);

  navigateToFabricDesignBundleToopColorCreate(int fabricDesignBundleId) {
    clearAllControllers();
    _helperServices.navigate(
      FabricDesignBundleToopColorCreateScreen(
        fabricDesignBundleId: fabricDesignBundleId,
      ),
    );
  }

  navigateToFabricDesignBundleToopEdit(
      int fabricDesignBundleToopColorId, fabricDesignPatiColorId, data) {
    clearAllControllers();
    selectedColorIdController.text = data.fabricdesigncolorId.toString();
    selectedColorNameController.text = data.colorname ?? '';
    warToopController.text = data.war.toString();

    _helperServices.navigate(
      FabricDesignBundleToopEditScreen(
        fabricDesignBundleToopColorId: fabricDesignBundleToopColorId,
        fabricDesignPatiColorId: fabricDesignPatiColorId,
      ),
    );
  }

  navigateToFabricDesignBundleToopListScreen(
    int fabricDesignBundleId,
    String fabricPurchaseCode,
    fabricBundleName,
    fabricDesignName,
  ) async {
    clearAllControllers();

    await getAllFabricDesignToop(
      fabricDesignBundleId,
    );
    _helperServices.navigate(
      FabricDesignBundleToopListScreen(
        fabricDesignBundleId: fabricDesignBundleId,
        fabricPurchaseCode: fabricPurchaseCode,
        fabricBundleName: fabricBundleName,
        fabricDesignName: fabricDesignName,
      ),
    );

    await getAllFabricDesignToopColor(
      fabricDesignBundleId,
    );

    this.fabricDesignBundleId = fabricDesignBundleId;
  }

  Future<void> getAllFabricDesignToop(int fabricDesignBundleId) async {
    _helperServices.showLoader();
    try {
      final response = await FabricDesignToopApiServiceProvider()
          .getFabricDesignToop('getBundleToop/$fabricDesignBundleId');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allFabricDesignToop = r;
          searchFabricDesignToop = List.from(allFabricDesignToop);
          cachedFabricDesignToop =
              List.from(allFabricDesignToop); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> getAllFabricDesignToopColor(int fabricDesignBundleId) async {
    try {
      final response = await FabricDesignToopApiServiceProvider()
          .getFabricDesignBundleToopColor('design-toop/$fabricDesignBundleId');
      response.fold(
        (l) {
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allFabricDesignToopColors = r;
          searchFabricDesignToopColors = List.from(allFabricDesignToopColors);
          cachedFabricDesignToopColors =
              List.from(allFabricDesignToopColors); // Cache initial data
          notifyListeners();
          getFabricDesignRemainBundleAndWar(fabricDesignBundleId);
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> createFabricDesignBundleToopColor(
      int fabricDesignBundleId) async {
    _helperServices.showLoader();
    try {
      final response =
          await FabricDesignToopApiServiceProvider().createFabricDesignToop(
        'design-toop-add?fabricdesignbundle_id=$fabricDesignBundleId',
        {
          "fabricdesignbundle_id": fabricDesignBundleId,
          "wartoop": warToopController.text,
          "fabricDesignColor_id": selectedColorIdController.text,
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
            getAllFabricDesignToop(fabricDesignBundleId);
            getFabricDesignRemainBundleAndWar(fabricDesignBundleId);
          }
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> editFabricDesignBundleToop(
      int fabricDesignBundleToopColorId, patiDesignColorId) async {
    _helperServices.showLoader();
    try {
      final response =
          await FabricDesignToopApiServiceProvider().editFabricDesignToop(
        'design-toop-update',
        {
          "wartoop": warToopController.text,
          "patiDesignColor_id": patiDesignColorId,
          "fabricDesignColor_id": selectedColorIdController.text,
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

          updateFabricDesignBundleToop(
            patiDesignColorId,
            fabricDesignBundleToopColorId,
            Data(
              patidesigncolorId: patiDesignColorId,
              fabricdesigncolorId: fabricDesignBundleToopColorId,
              war: int.tryParse(warToopController.text),
              colorname: selectedColorNameController.text,
            ),
          );
          getFabricDesignRemainBundleAndWar(fabricDesignBundleId);
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void updateFabricDesignBundleToop(
      int patidesigncolorId, int fabricdesigncolorId, Data updatedData) {
    int index = allFabricDesignToop.indexWhere((element) =>
        element.patidesigncolorId == patidesigncolorId &&
        element.fabricdesigncolorId == fabricdesigncolorId);
    if (index != -1) {
      allFabricDesignToop[index] = updatedData;
      int cacheIndex = cachedFabricDesignToop.indexWhere((element) =>
          element.patidesigncolorId == patidesigncolorId &&
          element.fabricdesigncolorId == fabricdesigncolorId);
      if (cacheIndex != -1) {
        cachedFabricDesignToop[cacheIndex] = updatedData; // Update cache
      }
      int searchIndex = searchFabricDesignToop.indexWhere((element) =>
          element.patidesigncolorId == patidesigncolorId &&
          element.fabricdesigncolorId == fabricdesigncolorId);
      if (searchIndex != -1) {
        searchFabricDesignToop[searchIndex] = updatedData; // Update search list
      }
      notifyListeners();
    }
  }

  Future<void> deleteFabricDesignBundleToop(
      int patidesigncolorId, int fabricdesigncolorId) async {
    _helperServices.showLoader();
    try {
      final response = await FabricDesignToopApiServiceProvider()
          .deleteFabricDesignToop(
              'design-toop-delete?patidesigncolor_id=$patidesigncolorId');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          _helperServices.goBack();
          if (r == 200) {
            deleteItemLocally(patidesigncolorId, fabricdesigncolorId);
            _helperServices.showMessage(
              const LocaleText('deleted'),
              Colors.red,
              const Icon(
                Icons.close,
                color: Pallete.whiteColor,
              ),
            );
            getFabricDesignRemainBundleAndWar(fabricDesignBundleId);
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

  Future<void> getFabricDesignRemainBundleAndWar(
      int fabricDesignBundleId) async {
    try {
      final response = await FabricDesignToopApiServiceProvider()
          .getFabricDesignRemainWarAndToop(
              'remaining-and-total-toop?fabricdesignbundle_id=$fabricDesignBundleId');
      response.fold(
        (l) {
          _helperServices.showErrorMessage(l);
        },
        (r) {
          totalWar = r.war;
          remainingToop = r.toop;

          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void deleteItemLocally(int patidesigncolorId, int fabricdesigncolorId) {
    allFabricDesignToop.removeWhere((element) =>
        element.patidesigncolorId == patidesigncolorId &&
        element.fabricdesigncolorId == fabricdesigncolorId);
    cachedFabricDesignToop.removeWhere((element) =>
        element.patidesigncolorId == patidesigncolorId &&
        element.fabricdesigncolorId == fabricdesigncolorId);
    searchFabricDesignToop.removeWhere((element) =>
        element.patidesigncolorId == patidesigncolorId &&
        element.fabricdesigncolorId == fabricdesigncolorId);
    notifyListeners();
  }

  void searchFabricDesignToopMethod(String text) {
    searchText = text;
    updateFabricDesignToopData();
  }

  void updateFabricDesignToopData() {
    searchFabricDesignToop.clear();
    if (searchText.isEmpty) {
      searchFabricDesignToop.addAll(cachedFabricDesignToop);
    } else {
      searchFabricDesignToop.addAll(
        cachedFabricDesignToop
            .where(
              (element) =>
                  (element.war
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.colorname
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.status
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false),
            )
            .toList(),
      );
    }
    notifyListeners();
  }

  void searchFabricDesignToopColorMethod(String text) {
    searchText = text;
    updateFabricDesignToopColorData();
  }

  void updateFabricDesignToopColorData() {
    searchFabricDesignToopColors.clear();
    if (searchText.isEmpty) {
      searchFabricDesignToopColors.addAll(cachedFabricDesignToopColors);
    } else {
      searchFabricDesignToopColors.addAll(
        cachedFabricDesignToopColors
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
    updateFabricDesignToopData();
  }

  void clearAllControllers() {
    selectedColorIdController.clear();
    selectedColorNameController.clear();
    warToopController.clear();
  }
}
