import 'package:fabricproject/api/khalid_rasid_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/khalid_rasid_model.dart';
import 'package:fabricproject/screens/khalid_rasid/khalid_draw_edit_screen.dart';
import 'package:fabricproject/screens/khalid_rasid/khalid_rasid_create_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class KhalidRasidController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController dateController = TextEditingController();
  TextEditingController yenPriceController = TextEditingController();
  TextEditingController selectedForexIdController = TextEditingController();
  TextEditingController selectedForexNameController = TextEditingController();
  TextEditingController selectedVendorCompanyName = TextEditingController();
  TextEditingController selectedVendorCompanyId = TextEditingController();
  TextEditingController exchangeRateController = TextEditingController();
  TextEditingController dollarPriceController = TextEditingController();
  TextEditingController forexController = TextEditingController();
  TextEditingController bankPhotoController = TextEditingController();

  double sumOfDrawTotalDollar = 0; // Variable to hold the sum of the  column
  double sumOfDrawTotalYen = 0; // Variable to hold the sum of the column

  List<Data> allKhalidRasids = [];
  List<Data> searchKhalidRasids = [];
  List<Data> cachedKhalidRasids = [];
  String searchText = "";

  KhalidRasidController(
    this._helperServices,
  ) {
    getAllKhalidRasids();
  }

  navigateToKhalidRasidCreate() {
    clearAllControllers();

    _helperServices.navigate(
      const KhalidRasidCreateScreen(),
    );
  }

  navigateToKhalidRasidEdit(Data data, int id) {
    clearAllControllers();
    dateController.text = data.drawDate.toString();
    yenPriceController.text = data.yen.toString();
    exchangeRateController.text = data.exchangerate.toString();
    dollarPriceController.text = data.doller.toString();
    selectedVendorCompanyName.text = data.vendorcompanyName.toString();
    selectedVendorCompanyId.text = data.vendorcompanyId.toString();
    selectedForexIdController.text = data.sarafiId.toString();
    selectedForexNameController.text = data.sarafiName.toString();

    _helperServices.navigate(KhalidRasidEditScreen(
      data: data,
      khalidRasidId: id,
    ));
  }

  Future<void> createKhalidRasd() async {
    _helperServices.showLoader();
    try {
      var response = await KhalidRasidApiServiceProvider().createKhalidRasid(
        'addKhalidRasidat',
        {
          "date": dateController.text,
          "sarafi_id": selectedForexIdController.text,
          "exchangerate": exchangeRateController.text,
          "vc_id": selectedVendorCompanyId.text,
          "priceindoller": dollarPriceController.text,
          "yen": yenPriceController.text,
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
            getAllKhalidRasids();
          }
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> editKhalidRasid(int id) async {

    try {
      final response = await KhalidRasidApiServiceProvider().editKhalidRasid(
        'updateKhalidRasidat',
        {
          "draw_id": id,
          "sarafi_id": selectedForexIdController.text,
          "exchangerate": exchangeRateController.text,
          "priceindoller": dollarPriceController.text,
          // the vc-name is the  id only var name  issues
          "yen": yenPriceController.text,
          "vc_name": selectedVendorCompanyId.text,
          "date": dateController.text,
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

          updateKhalidRasidLocally(
            id,
            Data(
              drawId: id,
              drawDate: dateController.text,
              yen: double.tryParse(yenPriceController.text),
              doller: double.tryParse(dollarPriceController.text),
              exchangerate: double.tryParse(exchangeRateController.text),
              photo: bankPhotoController.text,
              vendorcompanyName: selectedVendorCompanyName.text,
              sarafiName: selectedForexNameController.text,
            ),
          );
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void updateKhalidRasidLocally(int id, Data updatedData) {
    int index = allKhalidRasids.indexWhere((element) => element.drawId == id);
    if (index != -1) {
      allKhalidRasids[index] = updatedData;
      int cacheIndex =
          cachedKhalidRasids.indexWhere((element) => element.drawId == id);
      if (cacheIndex != -1) {
        cachedKhalidRasids[cacheIndex] = updatedData; // Update cache
      }
      int searchIndex =
          searchKhalidRasids.indexWhere((element) => element.drawId == id);
      if (searchIndex != -1) {
        searchKhalidRasids[searchIndex] = updatedData; // Update search list
      }
      notifyListeners();
    }
  }

 Future<void> deleteKhalidRasid(int id) async {
    _helperServices.showLoader();
    try {
      final response = await KhalidRasidApiServiceProvider()
          .deleteKhalid('deleteKhalidRasidat?draw_id=$id');
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
    allKhalidRasids.removeWhere((element) => element.drawId == id);
    cachedKhalidRasids.removeWhere((element) => element.drawId == id);
    searchKhalidRasids.removeWhere((element) => element.drawId == id);
    notifyListeners();
  }

  Future<void> getAllKhalidRasids() async {
    _helperServices.showLoader();
    try {
      final response = await KhalidRasidApiServiceProvider()
          .getKhalidRasid('loadKhalidRasidat');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
          print("rasiderrero run ");
        },
        (r) {
          allKhalidRasids = r;
          searchKhalidRasids = List.from(allKhalidRasids);
          cachedKhalidRasids = List.from(allKhalidRasids);
          _helperServices.goBack();
          print("data is here khalid ");
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

  searchKhalidRasidsMethod(String name) {
    searchText = name;
    updateDrawsData();
  }

  void updateDrawsData() {
    searchKhalidRasids.clear();
    if (searchText.isEmpty) {
      searchKhalidRasids.addAll(cachedKhalidRasids);
    } else {
      searchKhalidRasids.addAll(
        cachedKhalidRasids
            .where((element) =>
                (element.drawDate
                        ?.toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.yen
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.doller
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.exchangerate
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.vendorcompanyName
                        ?.toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.sarafiName?.toLowerCase().contains(searchText) ??
                    false))
            .toList(),
      );
    }
    notifyListeners();
  }

  void clearAllControllers() {
    dateController.clear();
    dollarPriceController.clear();
    forexController.clear();
    selectedForexIdController.clear();
    selectedForexNameController.clear();
    selectedVendorCompanyId.clear();
    selectedVendorCompanyName.clear();
    exchangeRateController.clear();
  }

  void resetSearchFilter() {
    searchText = '';
    updateDrawsData();
  }
}
