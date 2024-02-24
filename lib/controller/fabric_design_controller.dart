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
  TextEditingController designImageController = TextEditingController();
  TextEditingController designNameController = TextEditingController();

  // Variables to store fabric purchase information and fabric designs
  int? fabricPurchaseId;
  List<Data>? allFabricDesigns = [];
  List<Data>? searchFabricDesigns = [];
  String searchText = "";

  // Constructor to initialize the controller with helper services and fetch initial data
  FabricDesignController(this._helperServices) {
    getAllFabricDesigns(fabricPurchaseId);
  }

  // Navigation function to the fabric design create screen
  navigateToFabricDesignCreate() {
    clearAllControllers();
    _helperServices.navigate(const FabricDesignCreateScreen());
  }

  // Navigation function to the fabric design edit screen
  navigateToFabricDesignEdit(Data data, int id) {
    clearAllControllers();
    // Populate controllers with existing data for editing
    nameController.text = data.name.toString();
    amountOfBundlesController.text = data.bundle.toString();
    amountOfWarsController.text = data.war.toString();
    amountOfToopController.text = data.toop.toString();
    designNameController.text = data.designname.toString();
    designImageController.text = data.designimage.toString();

    _helperServices.navigate(FabricDesignEditScreen(
      fabricDesignData: data,
      fabricDesignId: id,
    ));
  }

  // Navigation function to the fabric design list screen
  navigateToFabricDesignListScreen(String fabricPurchaseCode, int id) async {
    clearAllControllers();
    fabricPurchaseId = id;
    _helperServices.navigate(
      FabricDesignListScreen(
        fabricPurchaseId: id,
        fabricPurchaseCode: fabricPurchaseCode,
      ),
    );
    await getAllFabricDesigns(fabricPurchaseId);
  }

  // Function to create a new fabric design through the API
  createFabricDesign() async {
    _helperServices.showLoader();

    var response = await FabricDesignApiServiceProvider().createFabricDesign(
      'add-fabric-design',
      {
        "fabricdesign_id": 0,
        "name": nameController.text,
        "bundle": amountOfBundlesController.text,
        "war": amountOfWarsController.text,
        "toop": amountOfToopController.text,
        "fabricpurchase_id": fabricPurchaseId.toString(),
        "designimage": designImageController.text,
        "designname": designNameController.text,
        "user_id": 1,
      },
    );
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        // Refresh fabric designs list and show success message
        getAllFabricDesigns(fabricPurchaseId!);
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

  // Function to edit an existing fabric design through the API
  editFabricDesign(int fabricDesignId) async {
    _helperServices.showLoader();

    var response = await FabricDesignApiServiceProvider().editFabricDesign(
      'update-fabric-design?fabricdesign_id$fabricDesignId',
      {
        "fabricdesign_id": fabricDesignId,
        "name": nameController.text,
        "bundle": amountOfBundlesController.text,
        "war": amountOfWarsController.text,
        "toop": amountOfToopController.text,
        "fabricpurchase_id": fabricPurchaseId.toString(),
        "designimage": designImageController.text,
        "designname": designNameController.text,
        "user_id": 1,
      },
    );
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        // Refresh fabric designs list and show success message
        getAllFabricDesigns(fabricPurchaseId!);
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

  // Function to delete an existing fabric design through the API
  void deleteItemLocally(int id) {
    final index =
        allFabricDesigns!.indexWhere((element) => element.fabricdesignId == id);
    if (index != -1) {
      allFabricDesigns!.removeAt(index);

      final searchIndex = searchFabricDesigns!
          .indexWhere((element) => element.fabricdesignId == id);
      if (searchIndex != -1) {
        searchFabricDesigns!.removeAt(searchIndex);
      }

      notifyListeners();
    }
  }

  // Function to delete a fabric design through the API
  deleteFabricDesign(id, index) async {
    _helperServices.showLoader();
    var response = await FabricDesignApiServiceProvider()
        .deleteFabricDesign('delete-fabric-design?fabricdesign_id=$id');
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

  // Function to fetch all fabric designs from the API
  getAllFabricDesigns(int? fabricPurchaseId) async {
    _helperServices.showLoader();
    final response = await FabricDesignApiServiceProvider()
        .getFabricDesign('getFabricDesign');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) {
        // Filter fabric designs based on fabric purchase ID
        allFabricDesigns = r
            .where((fabricDesign) =>
                fabricDesign.fabricpurchaseId == fabricPurchaseId)
            .toList();
        searchFabricDesigns?.clear();
        searchFabricDesigns?.addAll(allFabricDesigns!);

        _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  // Function to perform a search on fabric designs based on the provided name
  searchFabricDesignMethod(String name) {
    searchText = name;
    updateFabricDesignsData();
  }

  // Function to update the fabric designs data based on the search text
  updateFabricDesignsData() {
    searchFabricDesigns?.clear();
    if (searchText.isEmpty) {
      searchFabricDesigns?.addAll(allFabricDesigns!);
    } else {
      searchFabricDesigns?.addAll(
        allFabricDesigns!
            .where(
                (element) => element.name!.toLowerCase().contains(searchText))
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
    designImageController.clear();
    designNameController.clear();
  }
}
