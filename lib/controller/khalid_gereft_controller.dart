import 'package:fabricproject/api/khalid_gereft_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/khalid_gereft_model.dart';
import 'package:fabricproject/screens/khalid_gereft/khalid_gereft_create_screen.dart';
import 'package:fabricproject/screens/khalid_gereft/khalid_gereft_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class KhalidGereftController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController dateController = TextEditingController();
  TextEditingController selectedForexIdController = TextEditingController();
  TextEditingController selectedForexNameController = TextEditingController();
  TextEditingController dollarPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  double sumOfDrawTotalDollar = 0; // Variable to hold the sum of the  column
  double sumOfDrawTotalYen = 0; // Variable to hold the sum of the column

  List<Data> allKhalidGerefts = [];
  List<Data> searchKhalidGerefts = [];
  List<Data> cachedKhalidGerefts = [];
  String searchText = "";

  KhalidGereftController(
    this._helperServices,
  ) {
    getAllKhalidGerefts();
  }

  navigateToKhalidGereftCreate() {
    clearAllControllers();

    _helperServices.navigate(
      const KhalidGereftCreateScreen(),
    );
  }

  navigateToKhalidGereftEdit(Data data, int id) {
    clearAllControllers();
    if (data.sarafName != null && data.sarafiId != null) {
      selectedForexIdController.text = data.sarafiId.toString();
      selectedForexNameController.text = data.sarafName.toString();
    }
    descriptionController.text = data.description.toString();
    dateController.text = data.drawDate.toString();
    dollarPriceController.text = data.doller.toString();

    _helperServices.navigate(KhalidGereftEditScreen(
      data: data,
      gereftId: id,
    ));
  }

  Future<void> createKhalidGereft() async {
    _helperServices.showLoader();
    try {
      var response = await KhalidGereftApiServiceProvider().createKhalidGereft(
        'addKhalidGreft',
        {
          "date": dateController.text,
          "sarafi_id": selectedForexIdController.text,
          "doller": dollarPriceController.text,
          "description": descriptionController.text,
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
            getAllKhalidGerefts();
          }
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> editKhalidGereft(int id) async {
    _helperServices.showLoader();

    try {
      final response = await KhalidGereftApiServiceProvider().editKhalidGereft(
        'updateKhalidGreft',
        {
          "draw_id": id,
          "date": dateController.text,
          "sarafi_id": selectedForexIdController.text,
          "doller": dollarPriceController.text,
          "description": descriptionController.text,
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

          updateKhalidGerefLocally(
            id,
            Data(
              drawId: id,
              drawDate:
                  dateController.text.isNotEmpty ? dateController.text : null,
              doller: dollarPriceController.text.isNotEmpty
                  ? double.tryParse(dollarPriceController.text)
                  : null,
              description: descriptionController.text.isNotEmpty
                  ? descriptionController.text
                  : null,
              sarafName: selectedForexNameController.text.isNotEmpty
                  ? selectedForexNameController.text
                  : null,
            ),
          );
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void updateKhalidGerefLocally(int id, Data updatedData) {
    int index = allKhalidGerefts.indexWhere((element) => element.drawId == id);
    if (index != -1) {
      allKhalidGerefts[index] = updatedData;
      int cacheIndex =
          cachedKhalidGerefts.indexWhere((element) => element.drawId == id);
      if (cacheIndex != -1) {
        cachedKhalidGerefts[cacheIndex] = updatedData; // Update cache
      }
      int searchIndex =
          searchKhalidGerefts.indexWhere((element) => element.drawId == id);
      if (searchIndex != -1) {
        searchKhalidGerefts[searchIndex] = updatedData; // Update search list
      }
      notifyListeners();
    }
  }

 Future<void> deleteKhalidGereft(int id) async {
    _helperServices.showLoader();
    try {
      final response = await KhalidGereftApiServiceProvider()
          .deleteKhalidGereft('deleteKhalidGreft?draw_id=$id');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          _helperServices.goBack();
          if (r == 200) {
            deleteItemLocally(id);
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
    allKhalidGerefts.removeWhere((element) => element.drawId == id);
    cachedKhalidGerefts.removeWhere((element) => element.drawId == id);
    searchKhalidGerefts.removeWhere((element) => element.drawId == id);
    notifyListeners();
  }

  Future<void> getAllKhalidGerefts() async {
    _helperServices.showLoader();
    try {
      final response = await KhalidGereftApiServiceProvider()
          .getKhalidGereft('loadKhalidGreft');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allKhalidGerefts = r;
          searchKhalidGerefts = List.from(allKhalidGerefts);
          cachedKhalidGerefts = List.from(allKhalidGerefts);
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }
  // // Function to calculate the sum of the 'amount' column from the list of FabricPurchases
  // double calculateSumOfTotalDollar(List<Data>? draws) {
  //   double sum = 0;

  //   if (draws != null) {
  //     for (var draw in draws) {
  //       // Replace 'amount' with the actual field name from your FabricPurchase model
  //       sum += draw.doller ?? 0; // Add the 'amount' to the sum
  //     }
  //   }
  //   return sum;
  // }

  // double calculateSumOfTotalYen(List<Data>? draws) {
  //   double sum = 0;

  //   if (draws != null) {
  //     for (var draw in draws) {
  //       // Replace 'amount' with the actual field name from your FabricPurchase model
  //       sum += draw.yen ?? 0; // Add the 'amount' to the sum
  //     }
  //   }
  //   return sum;
  // }

  searchKhalidGereftsMethod(String name) {
    searchText = name;
    updateKhalidGereftData();
  }

  void updateKhalidGereftData() {
    searchKhalidGerefts.clear();
    if (searchText.isEmpty) {
      searchKhalidGerefts.addAll(cachedKhalidGerefts);
    } else {
      searchKhalidGerefts.addAll(
        cachedKhalidGerefts
            .where((element) =>
                (element.drawDate
                        ?.toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.doller
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.description
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.sarafName?.toLowerCase().contains(searchText) ??
                    false))
            .toList(),
      );
    }
    notifyListeners();
  }

  void clearAllControllers() {
    dateController.clear();
    dollarPriceController.clear();
    selectedForexIdController.clear();
    selectedForexNameController.clear();
    descriptionController.clear();
  }

  void resetSearchFilter() {
    searchText = '';
    updateKhalidGereftData();
  }
}
