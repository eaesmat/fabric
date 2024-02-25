import 'package:fabricproject/api/transfer_bundles_api.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:flutter_locales/flutter_locales.dart';

class TransferBundlesController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController transporterNameController = TextEditingController();
  TextEditingController selectedSaraiToIdController = TextEditingController();
  TextEditingController selectedSaraiToNameController = TextEditingController();
  TextEditingController selectedMarkaIdController = TextEditingController();
  TextEditingController selectedMarkaNameController = TextEditingController();
  TextEditingController selectedFabricCodeController = TextEditingController();
  TextEditingController selectedFabricCodeIdController =
      TextEditingController();
  TextEditingController saraiIdController = TextEditingController();

  List<Map<String, dynamic>> selectedBundles = [];
  List<Map<String, dynamic>> transferFormData = [];

  TransferBundlesController(this._helperServices);

  void updateJsonData() {
    // Clear data before adding new data
    transferFormData.clear();

    // Add data from existing controllers
    transferFormData.addAll([
      {"name": "sarai_id", "value": saraiIdController.text},
      {"name": "transportername", "value": transporterNameController.text},
      {"name": "sarai_to_id", "value": selectedSaraiToIdController.text},
      {"name": "marka_id", "value": selectedMarkaIdController.text},
      {"name": "purchase_id", "value": selectedFabricCodeIdController.text},
    ]);

    // Add selectedBundles data
    transferFormData.addAll(selectedBundles);

    notifyListeners(); // Notify listeners that the data has changed
  }

  void addItemToData(String name, String value) {
    selectedBundles.add({"name": name, "value": value});
    notifyListeners(); // Notify listeners after adding an item
  }

  void removeItemFromData(String name) {
    selectedBundles.removeWhere((item) => item["name"] == name);
    notifyListeners(); // Notify listeners after removing an item
  }

  void addAllItemsToData() {
    updateJsonData();
    notifyListeners(); // Notify listeners after adding all items
    // print("All items added to Data: $transferFormData");
  }

  transferBundles() async {
    _helperServices.showLoader();

    // Update the call to transferBundles in your TransferBundlesController class
    var response = await TransferBundlesApiServiceProvider().transferBundles(
      'transferBundles',
      transferFormData, // Pass transferFormData directly
    );

    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) => {
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

  void clearAllControllers() {
    transporterNameController.clear();
    selectedSaraiToIdController.clear();
    selectedSaraiToNameController.clear();
    selectedMarkaIdController.clear();
    selectedMarkaNameController.clear();
    selectedFabricCodeController.clear();
    selectedFabricCodeIdController.clear();
    saraiIdController.clear();
    // Clear selectedBundles and transferFormData
    selectedBundles.clear();
    transferFormData.clear();
    notifyListeners(); // Notify listeners after clearing controllers
  }
}
