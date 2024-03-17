// Import necessary dependencies and files
import 'package:fabricproject/api/fabric_design_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/fabric_design_model.dart';
import 'package:fabricproject/screens/fabric_design/fabric_design_create_screen.dart';
import 'package:fabricproject/screens/fabric_design/fabric_design_edit_screen.dart';
import 'package:fabricproject/screens/fabric_design/fabric_design_list_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

// Controller class responsible for managing the state and logic related to fabric designs
class FabricDesignController extends ChangeNotifier {
  final HelperServices _helperServices;

  // Text editing controllers for various input fields
  TextEditingController nameController = TextEditingController();
  TextEditingController amountOfBundlesController = TextEditingController();
  TextEditingController amountOfWarsController = TextEditingController();
  TextEditingController amountOfToopController = TextEditingController();

  // Variables to store fabric purchase information and fabric designs
  List<Data> allFabricDesigns = [];
  List<Data> searchFabricDesigns = [];
  List<Data> cachedFabricDesigns = [];
  int? remainingWar = 0;
  int? remainingBundle = 0;
  String searchText = "";

  // Constructor to initialize the controller with helper services and fetch initial data
  FabricDesignController(this._helperServices);

  // Navigation function to the fabric design create screen
  navigateToFabricDesignCreate(int fabricPurchaseId) {
    clearAllControllers();
    _helperServices.navigate(
      FabricDesignCreateScreen(
        fabricPurchaseId: fabricPurchaseId,
      ),
    );
  }

  // Navigation function to the fabric design edit screen
  navigateToFabricDesignEdit(Data data, int fabricDesignId, fabricPurchaseId) {
    clearAllControllers();
    // Populate controllers with existing data for editing
    nameController.text = data.name.toString();
    amountOfBundlesController.text = data.bundle.toString();
    amountOfWarsController.text = data.war.toString();
    amountOfToopController.text = data.toop.toString();

    _helperServices.navigate(
      FabricDesignEditScreen(
        fabricDesignData: data,
        fabricDesignId: fabricDesignId,
        fabricPurchaseId: fabricPurchaseId,
      ),
    );
  }

  // Navigation function to the fabric design list screen
  navigateToFabricDesignListScreen(String fabricPurchaseCode, int id) async {
    clearAllControllers();
    _helperServices.navigate(
      FabricDesignListScreen(
        fabricPurchaseId: id,
        fabricPurchaseCode: fabricPurchaseCode,
      ),
    );
    await getAllFabricDesigns(id);
  }

  // Function to create a new fabric design through the API
  Future<void> createFabricDesign(int fabricPurchaseId) async {
    _helperServices.showLoader();
    try {
      var response = await FabricDesignApiServiceProvider().createFabricDesign(
        'add-fabric-design',
        {
          "name": nameController.text,
          "bundle": amountOfBundlesController.text,
          "war": amountOfWarsController.text,
          "toop": amountOfToopController.text,
          "fp_id": fabricPurchaseId,
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
            getAllFabricDesigns(fabricPurchaseId);
          }
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> editFabricDesign(int fabricDesignId, fabricPurchaseId) async {
    _helperServices.showLoader();
    try {
      final response = await FabricDesignApiServiceProvider().editFabricDesign(
        'update-fabric-design',
        {
          "fd_id": fabricDesignId,
          "name": nameController.text,
          "bundle": amountOfBundlesController.text,
          "war": amountOfWarsController.text,
          "toop": amountOfToopController.text,
          "fp_id": fabricPurchaseId,
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

          getFabricDesignRemainBundleAndWar(fabricPurchaseId);

          updateFabricDesignLocally(
            fabricDesignId,
            Data(
              fabricdesignId: fabricDesignId,
              name: nameController.text,
              bundle: int.tryParse(amountOfBundlesController.text),
              war: int.tryParse(amountOfBundlesController.text),
              toop: int.tryParse(amountOfToopController.text),
            ),
          );
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> deleteFabricDesign(int fabricDesignId, fabricPurchaseId) async {
    _helperServices.showLoader();
    try {
      final response = await FabricDesignApiServiceProvider()
          .deleteFabricDesign('delete-fabric-design?fd_id=$fabricDesignId');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          _helperServices.goBack();
          if (r == 200) {
            getFabricDesignRemainBundleAndWar(fabricPurchaseId);
            deleteItemLocally(fabricDesignId);
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
    allFabricDesigns.removeWhere((element) => element.fabricdesignId == id);
    cachedFabricDesigns.removeWhere((element) => element.fabricdesignId == id);
    searchFabricDesigns.removeWhere((element) => element.fabricdesignId == id);
    notifyListeners();
  }

  void updateFabricDesignLocally(int id, Data updatedData) {
    int index =
        allFabricDesigns.indexWhere((element) => element.fabricdesignId == id);
    if (index != -1) {
      allFabricDesigns[index] = updatedData;
      int cacheIndex = cachedFabricDesigns
          .indexWhere((element) => element.fabricdesignId == id);
      if (cacheIndex != -1) {
        cachedFabricDesigns[cacheIndex] = updatedData; // Update cache
      }
      int searchIndex = searchFabricDesigns
          .indexWhere((element) => element.fabricdesignId == id);
      if (searchIndex != -1) {
        searchFabricDesigns[searchIndex] = updatedData; // Update search list
      }
      notifyListeners();
    }
  }

  // Function to fetch all fabric designs from the API
  Future<void> getAllFabricDesigns(int fabricPurchaseId) async {
    _helperServices.showLoader();
    try {
      final response = await FabricDesignApiServiceProvider()
          .getFabricDesign('getFabricDesign/$fabricPurchaseId');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allFabricDesigns = r;

          searchFabricDesigns = List.from(allFabricDesigns);
          cachedFabricDesigns =
              List.from(allFabricDesigns); // Cache initial data
          _helperServices.goBack();

          notifyListeners();
          getFabricDesignRemainBundleAndWar(fabricPurchaseId);
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  // Function to fetch all fabric designs from the API
  Future<void> getFabricDesignRemainBundleAndWar(int fabricPurchaseId) async {
    try {
      final response = await FabricDesignApiServiceProvider()
          .getFabricDesignRemainBundleAndWar(
              'getRemainBundleAndWar?fabricpurchase_id=$fabricPurchaseId');
      response.fold(
        (l) {
          _helperServices.showErrorMessage(l);
        },
        (r) {
          remainingBundle = r.bundle;
          remainingWar = r.war;

          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  // Function to perform a search on fabric designs based on the provided name
  searchFabricDesignMethod(String name) {
    searchText = name;
    updateFabricDesignsData();
  }

  // Function to update the fabric designs data based on the search text
  void updateFabricDesignsData() {
    searchFabricDesigns.clear();
    if (searchText.isEmpty) {
      searchFabricDesigns.addAll(cachedFabricDesigns);
    } else {
      searchFabricDesigns.addAll(
        cachedFabricDesigns
            .where(
              (element) =>
                  (element.name
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.bundle
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.toop
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.toop
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false),
            )
            .toList(),
      );
    }
    notifyListeners();
  }

  // Function to clear all text editing controllers
  void clearAllControllers() {
    nameController.clear();
    amountOfToopController.clear();
    amountOfBundlesController.clear();
    amountOfWarsController.clear();
  }
}
