import 'package:fabricproject/api/pati_design_color_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/pati_design_color_model.dart';
import 'package:fabricproject/screens/pati_design_color/pati_design_color_list_screen.dart';
import 'package:fabricproject/screens/pati_design_color/pati_design_create_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class PatiDesignColorController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController fabricDesignColorIdController = TextEditingController();
  TextEditingController warController = TextEditingController();
  TextEditingController patiIdController = TextEditingController();
  TextEditingController designBundleIdController = TextEditingController();

  int? patiId;
  List<Data>? allPatiDesignColors = [];
  List<Data>? searchPatiDesignColors = [];
  String searchText = "";

  PatiDesignColorController(
    this._helperServices,
  ) {
    getAllPatiDesignColors(patiId);
  }

  navigateToPatiDesignColorCreate() {
    clearAllControllers();

    _helperServices.navigate(const PatiDesignColorCreateScreen());
  }

  // navigateToPatiDesignColorEdit(Data data, int id) {
  //   clearAllControllers();

  //   fabricDesignColorIdController.text = data.fabricdesigncolorId.toString();
  //   warController.text = data.war.toString();
  //   patiIdController.text = data.patiId.toString();

  //   _helperServices.navigate(PatiDesignColorEditScreen(
  //     patiDesignColor: data,
  //     patiDesignColorId: id,
  //   ));
  // }

  navigateToPatiDesignListScreen(int id, String patiName) async {
    clearAllControllers();
    patiId = id;
    print("THE ID IS");
    print(patiId);

    PatiDesignColorListScreen(
      patiId: id,
      patiName: patiName,
    );
    await getAllPatiDesignColors(patiId);
  }

  createPatiDesignColor() async {
    print("____________________________________________");

    print("FabricDesignColors:");
    print(fabricDesignColorIdController.text);
    print("war:");
    print(warController.text);
    print("Pati id");
    print(patiIdController.text);
    print("design bundle id ");
    print(designBundleIdController.text);

    print("____________________________________________");
    // _helperServices.showLoader();

    var response =
        await PatiDesignColorApiServiceProvider().createPatiDesignColor(
      'add-pati-design-color',
      {
        "patidesigncolor_id": 0,
        "fabricdesigncolor_id": fabricDesignColorIdController.text,
        "war": warController.text,
        "pati_id": patiIdController.text,
        "designbundle_id": designBundleIdController.text,
        "user_id": 1,
      },
    );
    response.fold(
      (l) {
        // _helperServices.goBack();
        // _helperServices.showErrorMessage(l);
        print(l);
      },
      (r) {
        // getAllPatiDesignColors(patiId!);
        // _helperServices.goBack();
        // _helperServices.showMessage(
        //   const LocaleText('added'),
        //   Colors.green,
        //   const Icon(
        //     Icons.check,
        //     color: Pallete.whiteColor,
        //   ),
        // );

        clearAllControllers();
      },
    );
  }

  editPatiDesignColor(int patiDesignColorId, Data data) async {
    fabricDesignColorIdController.text = data.fabricdesigncolorId.toString();
    patiIdController.text = data.patiId.toString();
    designBundleIdController.text = data.designbundleId.toString();

   print("____________________________________________");

    print("FabricDesignColors:");
    print(fabricDesignColorIdController.text);
    print("war:");
    print(warController.text);
    print("Pati id");
    print(patiIdController.text);
    print("design bundle id ");
    print(designBundleIdController.text);

    print("____________________________________________");

    // _helperServices.showLoader();

    var response =
        await PatiDesignColorApiServiceProvider().editPatiDesignColor(
      'update-pati-design-color?patidesigncolor_id$patiDesignColorId',
      {
        "patidesigncolor_id": patiDesignColorId,
        "fabricdesigncolor_id": fabricDesignColorIdController.text,
        "war": warController.text,
        "pati_id": patiIdController.text,
        "designbundle_id": designBundleIdController.text,
        "user_id": 1,
      },
    );
    response.fold(
      (l) {
        // _helperServices.goBack();
        _helperServices.showErrorMessage(l);
        print(l);
      },
      (r) {
        // getAllPatiDesignColors(patiId!);
        // _helperServices.goBack();
        _helperServices.showMessage(
          const LocaleText('updated'),
          Colors.green,
          const Icon(
            Icons.check,
            color: Pallete.whiteColor,
          ),
        );
            print("updated");


        clearAllControllers();
      },
    );
  }

  void deleteItemLocally(int id) {
    final index = allPatiDesignColors!
        .indexWhere((element) => element.patidesigncolorId == id);
    if (index != -1) {
      allPatiDesignColors!.removeAt(index);

      final searchIndex = searchPatiDesignColors!
          .indexWhere((element) => element.patidesigncolorId == id);
      if (searchIndex != -1) {
        searchPatiDesignColors!.removeAt(searchIndex);
      }

      notifyListeners();
    }
  }

  deletePatiDesignColor(id, index) async {
    _helperServices.showLoader();
    var response = await PatiDesignColorApiServiceProvider()
        .deletePatiDesignColor(
            'delete-pati-design-color?patidesigncolor_id=$id');
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

  getAllPatiDesignColors(int? patiId) async {
    _helperServices.showLoader();
    final response = await PatiDesignColorApiServiceProvider()
        .getPatiDesignColor('getPatiDesignColor');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
        print(l),
      },
      (r) {
        allPatiDesignColors = r
            .where((patiDesignColor) => patiDesignColor.patiId == patiId)
            .toList();
        searchPatiDesignColors?.clear();
        searchPatiDesignColors?.addAll(allPatiDesignColors!);

        _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  searchPatiDesignColorsMethod(String name) {
    searchText = name;
    updatePatiDesignColors();
  }

  updatePatiDesignColors() {
    searchPatiDesignColors?.clear();
    if (searchText.isEmpty) {
      searchPatiDesignColors?.addAll(allPatiDesignColors!);
    } else {
      searchPatiDesignColors?.addAll(
        allPatiDesignColors!
            .where((element) =>
                element.war.toString().toLowerCase().contains(searchText) ||
                element.pati!.patiname!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  void clearAllControllers() {
    patiIdController.clear();
    fabricDesignColorIdController.clear();
    warController.clear();
    patiIdController.clear();
    
  }
}
