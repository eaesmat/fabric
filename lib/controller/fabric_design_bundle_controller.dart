import 'package:fabricproject/api/fabric_design_bundle_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/fabric_design_bundle_model.dart';
import 'package:fabricproject/screens/fabric_design_bundle/fabric_design_bundle_create_screen.dart';
import 'package:fabricproject/screens/fabric_design_bundle/fabric_design_bundle_edit_screen.dart';
import 'package:fabricproject/screens/fabric_design_bundle/fabric_design_bundle_list_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/no_bundle_color_screen_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class FabricDesignBundleController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController bundleNameController = TextEditingController();
  TextEditingController amountOfBundleToopController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController warBundleController = TextEditingController();

  int fabricDesignId = 0; // Initialize with a default value
  List<Data> allFabricDesignBundles = [];
  List<Data> searchFabricDesignBundles = [];
  List<Data> cachedFabricDesignBundles = [];

  String searchText = "";

  int? remainingToop = 0;
  int? remainingBundle = 0;

  // Cached data to avoid unnecessary API calls
  FabricDesignBundleController(
    this._helperServices,
  ) {
    // getAllFabricDesignBundles(fabricDesignId);
  }

  navigateToFabricDesignBundleCreate() {
    clearAllControllers();

    _helperServices.navigate(const FabricDesignBundleCreateScreen());
  }

  navigateToFabricDesignBundleEdit(Data data, int id) {
    clearAllControllers();
    bundleNameController.text = data.bundlename.toString();
    amountOfBundleToopController.text = data.bundletoop.toString();
    warBundleController.text = data.bundlewar.toString();

    _helperServices.navigate(FabricDesignBundleEditScreen(
      fabricDesignBundleData: data,
      fabricDesignBundleId: id,
    ));
  }

  navigateToFabricDesignBundleListScreen(
    String fabricDesignName,
    fabricPurchaseCode,
    int fabricDesignId,
    colorCount,
    colorLength,
  ) async {
    clearAllControllers();

    if (colorLength != 0) {
      await getAllFabricDesignBundles(
        fabricDesignId,
      );
      _helperServices.navigate(
        FabricDesignBundleListScreen(
          fabricDesignId: fabricDesignId,
          fabricDesignName: fabricDesignName,
          colorLength: colorLength,
          fabricPurchaseCode: fabricPurchaseCode,
        ),
      );
    } else {
      _helperServices.navigate(
        const NoBundleColorScreen(warningText: 'no_colors_are_added'),
      );
    }
    this.fabricDesignId = fabricDesignId;
  }

  Future<void> createFabricDesignBundle() async {
    _helperServices.showLoader();
    try {
      var response =
          await FabricDesignBundleApiServiceProvider().createFabricDesignBundle(
        'add-design-bundle',
        {
          "bundlename": bundleNameController.text,
          "bundletoop": amountOfBundleToopController.text,
          "bundlewar": warBundleController.text,
          "description": 0,
          "fd_id": fabricDesignId.toString(),
        },
      );

      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          getAllFabricDesignBundles(fabricDesignId);
          _helperServices.goBack();
          _helperServices.showMessage(
            const LocaleText('added'),
            Colors.green,
            const Icon(
              Icons.check,
              color: Pallete.whiteColor,
            ),
          );
          getFabricDesignRemainBundleAndWar(fabricDesignId);
          clearAllControllers();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> distributeFabricDesignBundle(int fabricDesignBundleId) async {
    _helperServices.showLoader();
    print(fabricDesignBundleId);
    try {
      var response =
          await FabricDesignBundleApiServiceProvider().distributingDesignBundle(
        'distributed-design-bundles?designbundle_id=$fabricDesignBundleId',
      );

      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          getAllFabricDesignBundles(fabricDesignId);
          _helperServices.goBack();
          _helperServices.showMessage(
            const LocaleText('distributed'),
            Colors.green,
            const Icon(
              Icons.check,
              color: Pallete.whiteColor,
            ),
          );
          getFabricDesignRemainBundleAndWar(fabricDesignId);
          clearAllControllers();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> completeDesignBundleStatus(int fabricDesignBundleId) async {
    _helperServices.showLoader();
    print(fabricDesignBundleId);
    try {
      var response = await FabricDesignBundleApiServiceProvider()
          .completeDesignBundleStatus(
        'complete-design-bundle-status?designbundle_id=$fabricDesignBundleId',
      );

      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          getAllFabricDesignBundles(fabricDesignId);
          _helperServices.goBack();
          _helperServices.showMessage(
            const LocaleText('completed'),
            Colors.green,
            const Icon(
              Icons.check,
              color: Pallete.whiteColor,
            ),
          );
          getFabricDesignRemainBundleAndWar(fabricDesignId);
          clearAllControllers();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> editFabricDesignBundle(int fabricDesignBundleId) async {
    _helperServices.showLoader();
    try {
      var response =
          await FabricDesignBundleApiServiceProvider().editFabricDesignBundle(
        'update-design-bundle?designbundle_id$fabricDesignBundleId',
        {
          "designbundle_id": fabricDesignBundleId,
          "bundlename": bundleNameController.text,
          "bundletoop": amountOfBundleToopController.text,
          "bundlewar": warBundleController.text,
          "description": 0,
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
          getFabricDesignRemainBundleAndWar(fabricDesignId);

          updateFabricDesignBundleLocally(
            fabricDesignBundleId,
            Data(
              designbundleId: fabricDesignBundleId,
              bundlename: bundleNameController.text,
              description: 0,
              bundletoop: int.tryParse(amountOfBundleToopController.text),
              bundlewar: int.tryParse(warBundleController.text),
            ),
          );
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void updateFabricDesignBundleLocally(int id, Data updatedData) {
    int index = allFabricDesignBundles
        .indexWhere((element) => element.designbundleId == id);
    if (index != -1) {
      allFabricDesignBundles[index] = updatedData;
      int cacheIndex = cachedFabricDesignBundles
          .indexWhere((element) => element.designbundleId == id);
      if (cacheIndex != -1) {
        cachedFabricDesignBundles[cacheIndex] = updatedData; // Update cache
      }
      int searchIndex = searchFabricDesignBundles
          .indexWhere((element) => element.designbundleId == id);
      if (searchIndex != -1) {
        searchFabricDesignBundles[searchIndex] =
            updatedData; // Update search list
      }
      notifyListeners();
    }
  }

  Future<void> deleteFabricDesignBundle(int fabricDesignBundleId) async {
    _helperServices.showLoader();
    try {
      final response = await FabricDesignBundleApiServiceProvider()
          .deleteFabricDesignBundle(
              'delete-design-bundle?designbundle_id=$fabricDesignBundleId');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          _helperServices.goBack();
          if (r == 200) {
            deleteItemLocally(fabricDesignBundleId);
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
    allFabricDesignBundles
        .removeWhere((element) => element.designbundleId == id);
    cachedFabricDesignBundles
        .removeWhere((element) => element.designbundleId == id);
    searchFabricDesignBundles
        .removeWhere((element) => element.designbundleId == id);
    notifyListeners();
  }

  Future<void> getAllFabricDesignBundles(int fabricDesignId) async {
    _helperServices.showLoader();
    try {
      final response = await FabricDesignBundleApiServiceProvider()
          .getFabricDesignBundle('getDesignBundle/$fabricDesignId');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allFabricDesignBundles = r;
          searchFabricDesignBundles = List.from(allFabricDesignBundles);
          cachedFabricDesignBundles =
              List.from(allFabricDesignBundles); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
          getFabricDesignRemainBundleAndWar(fabricDesignId);
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> getFabricDesignRemainBundleAndWar(int fabricDesignId) async {
    try {
      final response = await FabricDesignBundleApiServiceProvider()
          .getFabricDesignRemainBundleAndToop(
              'remaining-toop-and-bundle?fabricdesign_id=$fabricDesignId');
      response.fold(
        (l) {
          _helperServices.showErrorMessage(l);
        },
        (r) {
          remainingBundle = r.bundle;
          remainingToop = r.toop;

          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void searchFabricDesignBundlesMethod(String text) {
    searchText = text;
    updateFabricDesignBundleData();
  }

  void updateFabricDesignBundleData() {
    searchFabricDesignBundles.clear();
    if (searchText.isEmpty) {
      searchFabricDesignBundles.addAll(cachedFabricDesignBundles);
    } else {
      searchFabricDesignBundles.addAll(
        cachedFabricDesignBundles
            .where(
              (element) =>
                  (element.bundlename
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.bundletoop
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.description
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.bundlewar
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.toopwar
                          ?.toString()
                          .toLowerCase()
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

  void resetSearchFilter() {
    searchText = '';
    updateFabricDesignBundleData();
  }

  void clearAllControllers() {
    bundleNameController.clear();
    amountOfBundleToopController.clear();
    descriptionController.clear();
    warBundleController.clear();
  }
}
