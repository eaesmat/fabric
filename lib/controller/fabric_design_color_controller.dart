import 'package:fabricproject/api/fabric_design_color_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/fabric_design_color_model.dart';
import 'package:fabricproject/screens/fabric_design/fabric_design_details_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class FabricDesignColorController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController colorNameController = TextEditingController();
  TextEditingController amountOfBundlesController = TextEditingController();
  TextEditingController amountOfWarsController = TextEditingController();
  TextEditingController amountOfToopController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  int? fabricDesignId;
  List<Data>? allFabricDesignColors = [];
  List<Data>? searchFabricDesignColors = [];
  String searchText = "";

  FabricDesignColorController(
    this._helperServices,
  ) {
    getAllFabricDesignColors(fabricDesignId);
  }

  // navigateToFabricDesignColorCreate() {
  //   clearAllControllers();

  //   _helperServices.navigate(const FabricDesignColorCreateScreen());
  // }

  // navigateToFabricDesignColorEdit(Data data, int id) {
  //   clearAllControllers();

  //   colorNameController.text = data.colorname.toString();
  //   amountOfBundlesController.text = data.bundle.toString();
  //   amountOfWarsController.text = data.war.toString();
  //   amountOfToopController.text = data.toop.toString();
  //   photoController.text = data.photo.toString();

  //   _helperServices.navigate(
  //     FabricDesignColorEditScreen(
  //       fabricDesignColorData: data,
  //       fabricDesignColorId: id,
  //     ),
  //   );
  // }

  navigateToFabricDesignDetails(String fabricDesignName, int id) async {
    clearAllControllers();
    fabricDesignId = id;

    _helperServices.navigate(
      FabricDesignDetailsScreen(
        fabricDesignId: id,
        fabricDesignName: fabricDesignName,
      ),
    );
    await getAllFabricDesignColors(
      fabricDesignId,
    );
  }

  createFabricDesignColor() async {
    _helperServices.showLoader();

    var response =
        await FabricDesignColorApiServiceProvider().createFabricDesignColor(
      'add-fabric-design-color',
      {
        "fabricdesigncolor_id": 0,
        "colorname": colorNameController.text,
        "bundle": null,
        "war": null,
        "toop": null,
        "fabricdesign_id": fabricDesignId.toString(),
        "photo": null,
        "user_id": 1,
      },
    );
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        getAllFabricDesignColors(fabricDesignId!);
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

  editFabricDesignColor(int fabricDesignColor) async {
    _helperServices.showLoader();

    var response =
        await FabricDesignColorApiServiceProvider().editFabricDesignColor(
      'update-fabric-design-color?fabricdesigncolor_id$fabricDesignColor',
      {
        "fabricdesigncolor_id": 0,
        "colorname": colorNameController.text,
        "bundle": amountOfBundlesController.text,
        "war": amountOfWarsController.text,
        "toop": amountOfToopController.text,
        "fabricdesign_id": fabricDesignId.toString(),
        "photo": photoController.text,
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
        getAllFabricDesignColors(fabricDesignId!);
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
    final index = allFabricDesignColors!
        .indexWhere((element) => element.fabricdesigncolorId == id);
    if (index != -1) {
      allFabricDesignColors!.removeAt(index);

      final searchIndex = searchFabricDesignColors!
          .indexWhere((element) => element.fabricdesigncolorId == id);
      if (searchIndex != -1) {
        searchFabricDesignColors!.removeAt(searchIndex);
      }

      notifyListeners();
    }
  }

  deleteFabricDesignColor(id, index) async {
    print(id);
    _helperServices.showLoader();
    var response = await FabricDesignColorApiServiceProvider()
        .deleteFabricDesignColor(
            'delete-fabric-design-color?fabricdesigncolor_id=$id');
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

  getAllFabricDesignColors(int? fabricDesignId) async {
    _helperServices.showLoader();
    final response = await FabricDesignColorApiServiceProvider()
        .getFabricDesignColor('getFabricDesignColor');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
        print(l),
      },
      (r) {
        allFabricDesignColors = r
            .where((fabricDesignColor) =>
                fabricDesignColor.fabricdesignId == fabricDesignId)
            .toList();
        searchFabricDesignColors?.clear();
        searchFabricDesignColors?.addAll(allFabricDesignColors!);

        _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  searchFabricDesignColorMethod(String text) {
    searchText = text;
    updateFabricDesignColorData();
  }

  updateFabricDesignColorData() {
    searchFabricDesignColors?.clear();
    if (searchText.isEmpty) {
      searchFabricDesignColors?.addAll(allFabricDesignColors!);
    } else {
      searchFabricDesignColors?.addAll(
        allFabricDesignColors!
            .where(
              (element) => element.colorname!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()),
            )
            .toList(),
      );
    }
    notifyListeners();
  }

  void clearAllControllers() {
    colorNameController.clear();
    amountOfToopController.clear();
    amountOfBundlesController.clear();
    amountOfWarsController.clear();
    photoController.clear();
  }
}
