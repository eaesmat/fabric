import 'package:fabricproject/api/draw_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/draw_model.dart';
import 'package:fabricproject/screens/khalid_draw/khalid_draw_edit_screen.dart';
import 'package:fabricproject/screens/khalid_draw/khalid_draw_create_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class KhalidDrawController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController dateController = TextEditingController();
  TextEditingController yenPriceController = TextEditingController();
  TextEditingController selectedForexController = TextEditingController();
  TextEditingController exchangeRateController = TextEditingController();
  TextEditingController dollarPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController forexController = TextEditingController();
  TextEditingController bankPhotoController = TextEditingController();

  double sumOfDrawTotalDollar = 0; // Variable to hold the sum of the  column
  double sumOfDrawTotalYen = 0; // Variable to hold the sum of the column

  List<Data>? allDraws = [];
  List<Data>? searchDraws = [];
  String searchText = "";

  KhalidDrawController(
    this._helperServices,
  ) {
    getAllDraws();
  }

  navigateToDrawCreate() {
    clearAllControllers();

    _helperServices.navigate(const KhalidDrawCreateScreen());
  }

  navigateToDrawEdit(Data data, int id) {
    clearAllControllers();
    if (data.sarafiId != null) {
      selectedForexController.text = ("${data.sarafi!.fullname}");
      forexController.text = data.sarafiId.toString();
    }

    dollarPriceController.text = data.doller.toString();
    descriptionController.text = data.description.toString();

    _helperServices.navigate(KhalidDrawEditScreen(
      drawData: data,
      drawId: id,
    ));
  }

  createDraw() async {
    _helperServices.showLoader();

    var response = await DrawApiServiceProvider().createDraw(
      'add-draw',
      {
        "draw_id": 0,
        "draw_date": dateController.text,
        "doller": dollarPriceController.text.isEmpty
            ? ''
            : dollarPriceController.text,
        "description": descriptionController.text.isEmpty
            ? ''
            : descriptionController.text,
        "photo":
            bankPhotoController.text.isEmpty ? '' : bankPhotoController.text,
        "sarafi_id": forexController.text.isEmpty ? null : forexController.text,
        "yen": yenPriceController.text.isEmpty ? '' : yenPriceController.text,
        "exchangerate": exchangeRateController.text.isEmpty
            ? ''
            : exchangeRateController.text,
        "vendorcompany_id": null, // Use vendorCompanyId directly
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
        getAllDraws();
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

  editDraw(int drawId) async {
    _helperServices.showLoader();

    var response = await DrawApiServiceProvider().editDraw(
      'update-draw?draw_id$drawId',
      {
        "draw_id": drawId,
        "draw_date": dateController.text,
        "doller": dollarPriceController.text.isEmpty
            ? ''
            : dollarPriceController.text,
        "description": descriptionController.text.isEmpty
            ? ''
            : descriptionController.text,
        "photo":
            bankPhotoController.text.isEmpty ? '' : bankPhotoController.text,
        "sarafi_id": forexController.text,
        "yen": yenPriceController.text.isEmpty ? '' : yenPriceController.text,
        "exchangerate": exchangeRateController.text.isEmpty
            ? ''
            : exchangeRateController.text,
        "vendorcompany_id": null,
// Use vendorCompanyId directly
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
        getAllDraws();
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
    final index = allDraws!.indexWhere((element) => element.drawId == id);
    if (index != -1) {
      allDraws!.removeAt(index);

      final searchIndex =
          searchDraws!.indexWhere((element) => element.drawId == id);
      if (searchIndex != -1) {
        searchDraws!.removeAt(searchIndex);
      }

      notifyListeners();
    }
  }

  deleteDraw(id, index) async {
    _helperServices.showLoader();
    var response =
        await DrawApiServiceProvider().deleteDraw('delete-draw?draw_id=$id');
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

  getAllDraws() async {
    _helperServices.showLoader();
    final response = await DrawApiServiceProvider().getDraw('getDraw');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
        print(l),
      },
      (r) {
        allDraws = r.where((draw) => draw.vendorcompanyId == null).toList();
        searchDraws?.clear();
        searchDraws?.addAll(allDraws!);
        // Calculate the sum of the 'amount' column

        sumOfDrawTotalDollar = calculateSumOfTotalDollar(allDraws);
        sumOfDrawTotalYen = calculateSumOfTotalYen(allDraws);
        _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  // Function to calculate the sum of the 'amount' column from the list of FabricPurchases
  double calculateSumOfTotalDollar(List<Data>? draws) {
    double sum = 0;

    if (draws != null) {
      for (var draw in draws) {
        // Replace 'amount' with the actual field name from your FabricPurchase model
        sum += draw.doller ?? 0; // Add the 'amount' to the sum
      }
    }
    return sum;
  }

  double calculateSumOfTotalYen(List<Data>? draws) {
    double sum = 0;

    if (draws != null) {
      for (var draw in draws) {
        // Replace 'amount' with the actual field name from your FabricPurchase model
        sum += draw.yen ?? 0; // Add the 'amount' to the sum
      }
    }
    return sum;
  }

  searchDrawsMethod(String name) {
    searchText = name;
    updateDrawsData();
  }

  updateDrawsData() {
    searchDraws?.clear();
    if (searchText.isEmpty) {
      searchDraws?.addAll(allDraws!);
    } else {
      searchDraws?.addAll(
        allDraws!
            .where((element) =>
                element.description!.toLowerCase().contains(searchText) ||
                element.drawDate!.toLowerCase().contains(searchText) ||
                element.sarafi!.fullname!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  void clearAllControllers() {
    dateController.clear();
    dollarPriceController.clear();
    descriptionController.clear();
    forexController.clear();
    selectedForexController.clear();
  }
}
