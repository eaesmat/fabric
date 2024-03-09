import 'package:fabricproject/api/pati_api.dart';
import 'package:fabricproject/helper/generate_pati_name.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/pati_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class PatiController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController patiNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController toopController = TextEditingController();
  TextEditingController bundleCodeController = TextEditingController();

  int? designBundleId;
  List<Data>? allPati = [];
  List<Data>? allPatiWithNoFilter = [];
  List<Data>? searchPati = [];
  String searchText = "";
  int? lastPatiId;
  bool isCreated = false;

  PatiController(
    this._helperServices,
  ) {
    getAllPati(designBundleId);
  }

  // navigateToPatiCreate() {
  //   clearAllControllers();

  //   _helperServices.navigate(const PatiCreateScreen());
  // }

  String? getLastPatiName() {
    if (allPatiWithNoFilter != null && allPatiWithNoFilter!.isNotEmpty) {
      // Retrieve the last item in the list
      Data lastItem = allPatiWithNoFilter!.last;
      // Get the transportdeal_id of the last item
      String? lastPatiName = lastItem.patiname;
      return lastPatiName;
    } else {
      return null;
    }
  }

  int? getLastPatiId() {
    if (allPatiWithNoFilter != null && allPatiWithNoFilter!.isNotEmpty) {
      // Retrieve the last item in the list
      Data lastItem = allPatiWithNoFilter!.last;
      // Get the transportdeal_id of the last item
      int? lastPatiId = lastItem.patiId;
      return lastPatiId;
    } else {
      return null;
    }
  }

  createPatiName() async {
    await getAllPatiWithNoFilter();

    String patiName = getLastPatiName().toString();
    print(patiName); // ... other code ...
    print(allPatiWithNoFilter!.length); // ... other code ...

    // Generate and print the new patiid
    String generatedPatiName = GeneratePatiNameClass.generatePatiName(patiName);
    print('Generated Pati Name: $generatedPatiName');

    patiNameController.text = generatedPatiName;
    await createPati();
    await getAllPatiWithNoFilter();

    lastPatiId = getLastPatiId()!.toInt();

    // ... rest of the code ...
  } // navigateToPatiDesignColorEdit(Data data, int id) {
  //   clearAllControllers();

  //   fabricDesignColorIdController.text = data.fabricdesigncolorId.toString();
  //   warController.text = data.war.toString();
  //   patiIdController.text = data.patiId.toString();

  //   _helperServices.navigate(PatiDesignColorEditScreen(
  //     patiDesignColor: data,
  //     patiDesignColorId: id,
  //   ));
  // }

  navigateToPatiListScreen(int fabricDesignBundleId, int fabricDesignId,
      String fabricDesignName) async {
    clearAllControllers();
    designBundleId = fabricDesignBundleId;
    print("THE ID IS");
    print(designBundleId);

    // _helperServices.navigate(
    //   PatiListScreen(
    //     fabricDesignBundleId: fabricDesignBundleId,
    //     fabricDesignName: fabricDesignName,
    //     fabricDesignId: fabricDesignId,
    //   ),
    // );
    await getAllPati(designBundleId);
  }

  createPati() async {
    _helperServices.showLoader();

    var response = await PatiApiServiceProvider().createPati(
      'add-pati',
      {
        "pati_id": 0,
        "patiname": patiNameController.text,
        "description": descriptionController.text.isEmpty
            ? 'desc'
            : descriptionController.text,
        "toop": 0,
        "bundlecode": null,
      },
    );
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
        isCreated = false;
        print(l);
      },
      (r) {
        isCreated = true;
        // getAllPati(designBundleId!);
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

  editPati(int patiId) async {
    _helperServices.showLoader();

    var response = await PatiApiServiceProvider().editPati(
      'update-pati?pati_id$patiId',
      {
        "pati_id": patiId,
        "patiname": patiNameController.text,
        "description": descriptionController.text,
        "toop": toopController.text,
        "bundlecode": null,
      },
    );
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
        print(l);
      },
      (r) {
        getAllPati(designBundleId!);
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
    final index = allPati!.indexWhere((element) => element.patiId == id);
    if (index != -1) {
      allPati!.removeAt(index);

      final searchIndex =
          searchPati!.indexWhere((element) => element.patiId == id);
      if (searchIndex != -1) {
        searchPati!.removeAt(searchIndex);
      }

      notifyListeners();
    }
  }

  deletePati(id, index) async {
    _helperServices.showLoader();
    var response =
        await PatiApiServiceProvider().deletePati('delete-pati?pati_id=$id');
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

  getAllPati(int? designBundleId) async {
    _helperServices.showLoader();
    final response = await PatiApiServiceProvider().getPati('getPati');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
        print(l),
      },
      (r) {
        allPati = r.where((pati) {
          // Check all patidesigncolor elements for a matching designBundleId
          return pati.patidesigncolor!.any((patiDesignColor) =>
              patiDesignColor.designbundleId == designBundleId);
        }).toList();

        // Update searchPati directly without explicitly returning the filtered list
        searchPati?.clear();
        searchPati?.addAll(allPati!);

        _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  getAllPatiWithNoFilter() async {
    // _helperServices.showLoader();
    final response = await PatiApiServiceProvider().getPati('getPati');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
        print(l),
      },
      (r) {
        allPatiWithNoFilter = r;

        // _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  searchPatiMethod(String name) {
    searchText = name;
    updatePatiDesignColors();
  }

  updatePatiDesignColors() {
    searchPati?.clear();
    if (searchText.isEmpty) {
      searchPati?.addAll(allPati!);
    } else {
      searchPati?.addAll(
        allPati!
            .where((element) =>
                element.patiname
                    .toString()
                    .toLowerCase()
                    .contains(searchText) ||
                element.toop.toString().toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  void clearAllControllers() {
    patiNameController.clear();
    descriptionController.clear();
    toopController.clear();
  }
}
