import 'package:fabricproject/api/fabric_design_bundle_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/fabric_design_bundle_model.dart';
import 'package:fabricproject/theme/pallete.dart';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class FabricDesignBundleController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController bundleNameController = TextEditingController();
  TextEditingController amountOfBundleToopController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  int? fabricDesignId;
  List<Data>? allFabricDesignBundles = [];
  List<Data>? searchFabricDesignBundles = [];
  String searchText = "";

  FabricDesignBundleController(
    this._helperServices,
  ) {
    getAllFabricDesignBundles(fabricDesignId);
  }

  navigateToFabricDesignBundleCreate() {
    clearAllControllers();

    // _helperServices.navigate(const FabricDesignBundleCreateScreen());
  }

  navigateToFabricDesignBundleEdit(Data data, int id) {
    clearAllControllers();
    bundleNameController.text = data.bundlename.toString();
    amountOfBundleToopController.text = data.bundletoop.toString();

    // _helperServices.navigate(FabricDesignBundleEditScreen(
    //   fabricDesignBundleData: data,
    //   fabricDesignBundleId: id,
    // ));
  }

  navigateToFabricDesignDetails(String fabricDesignName, int id) async {
    clearAllControllers();
    fabricDesignId = id;
//  pass data do not navigate as the design color already navigates
    // _helperServices.navigate(
    //   FabricDesignDetailsScreen(
    //     fabricDesignId: id,
    //     fabricDesignName: fabricDesignName,
    //   ),
    // );
    await getAllFabricDesignBundles(
      fabricDesignId,
    );
  }

  createFabricDesignBundle() async {
    _helperServices.showLoader();

    var response =
        await FabricDesignBundleApiServiceProvider().createFabricDesignBundle(
      'add-design-bundle',
      {
        "designbundle_id": 0,
        "bundlename": bundleNameController.text,
        "bundletoop": amountOfBundleToopController.text,
        "description": 0,
        "fabricdesign_id": fabricDesignId.toString(),
        "status": null,
        "user_id": 1,
      },
    );
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        getAllFabricDesignBundles(fabricDesignId!);
        _helperServices.goBack();
        _helperServices.showMessage(
          const LocaleText('added'),
          Colors.green,
          const Icon(
            Icons.check,
            color: Pallete.whiteColor,
          ),
        );

        clearAllControllers();
      },
    );
  }

  editFabricDesignBundle(int fabricDesignBundleId) async {
    _helperServices.showLoader();

    var response =
        await FabricDesignBundleApiServiceProvider().editFabricDesignBundle(
      'update-design-bundle?designbundle_id$fabricDesignBundleId',
      {
        "designbundle_id": fabricDesignBundleId,
        "bundlename": bundleNameController.text,
        "bundletoop": amountOfBundleToopController.text,
        "description": 0,
        "fabricdesign_id": fabricDesignId.toString(),
        "status": null,
        "user_id": 1,
      },
    );
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
        print(l);
      },
      (r) {
        getAllFabricDesignBundles(fabricDesignId!);
        _helperServices.goBack();
        _helperServices.showMessage(
          const LocaleText('updated'),
          Colors.green,
          const Icon(
            Icons.check,
            color: Pallete.whiteColor,
          ),
        );

        clearAllControllers();
      },
    );
  }

  void deleteItemLocally(int id) {
    final index = allFabricDesignBundles!
        .indexWhere((element) => element.designbundleId == id);
    if (index != -1) {
      allFabricDesignBundles!.removeAt(index);

      final searchIndex = searchFabricDesignBundles!
          .indexWhere((element) => element.designbundleId == id);
      if (searchIndex != -1) {
        searchFabricDesignBundles!.removeAt(searchIndex);
      }

      notifyListeners();
    }
  }

  deleteFabricDesignBundle(id, index) async {
    _helperServices.showLoader();
    var response = await FabricDesignBundleApiServiceProvider()
        .deleteFabricDesignBundle('delete-design-bundle?designbundle_id=$id');
    _helperServices.goBack();
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
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

  getAllFabricDesignBundles(int? fabricDesignId) async {
    _helperServices.showLoader();
    final response = await FabricDesignBundleApiServiceProvider()
        .getFabricDesignBundle('getDesignBundle');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
        print(l),
      },
      (r) {
        allFabricDesignBundles = r
            .where((fabricDesignBundle) =>
                fabricDesignBundle.fabricdesignId == fabricDesignId)
            .toList();
        searchFabricDesignBundles?.clear();
        searchFabricDesignBundles?.addAll(allFabricDesignBundles!);

        _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  searchFabricDesignBundleMethod(String text) {
    searchText = text;
    updateFabricDesignBundleData();
  }

  updateFabricDesignBundleData() {
    searchFabricDesignBundles?.clear();
    if (searchText.isEmpty) {
      searchFabricDesignBundles?.addAll(allFabricDesignBundles!);
    } else {
      searchFabricDesignBundles?.addAll(
        allFabricDesignBundles!
            .where((element) =>
                element.bundlename!.toLowerCase().contains(searchText) ||
                element.bundletoop
                    .toString()
                    .toLowerCase()
                    .contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  void clearAllControllers() {
    bundleNameController.clear();
    amountOfBundleToopController.clear();
    // descriptionController.clear();
    statusController.clear();
  }
}
