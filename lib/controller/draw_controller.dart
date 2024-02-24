// Import necessary dependencies and files
import 'package:fabricproject/api/draw_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/draw_model.dart';
import 'package:fabricproject/screens/draw/draw_create_screen.dart';
import 'package:fabricproject/screens/draw/draw_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

// Define a class for DrawController that extends ChangeNotifier
class DrawController extends ChangeNotifier {
  final HelperServices _helperServices;

  // Controllers to send and get data to the UI
  TextEditingController dateController = TextEditingController();
  TextEditingController yenPriceController = TextEditingController();
  TextEditingController selectedForexController = TextEditingController();
  TextEditingController exchangeRateController = TextEditingController();
  TextEditingController dollarPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController vendorCompanyController = TextEditingController();
  TextEditingController forexController = TextEditingController();
  TextEditingController bankPhotoController = TextEditingController();

  // Variables to hold the sum of the columns
  double sumOfDrawTotalDollar = 0;
  double sumOfDrawTotalYen = 0;

  // Vendor company id to get data based on
  int? vendorCompanyId;

  // To hold API response as data
  List<Data>? allDraws = [];
  List<Data>? searchDraws = [];
  String searchText = "";

  // Constructor to initialize the DrawController
  DrawController(this._helperServices) {
    getAllDraws(vendorCompanyId);
  }

  // Navigate to the DrawCreateScreen
  navigateToDrawCreate() {
    clearAllControllers();
    _helperServices.navigate(const DrawCreateScreen());
  }

  // Navigate to the DrawEditScreen with provided data and id
  navigateToDrawEdit(Data data, int id) {
    clearAllControllers();
    // Set controller values with data
    selectedForexController.text = ("${data.sarafi!.fullname}");
    forexController.text = data.sarafiId.toString();
    dateController.text = data.drawDate.toString();
    yenPriceController.text = data.yen.toString();
    dollarPriceController.text = data.doller.toString();
    exchangeRateController.text = data.exchangerate.toString();
    descriptionController.text = data.description.toString();
    bankPhotoController.text = data.photo.toString();
    bankPhotoController.text = data.photo.toString();

    _helperServices.navigate(DrawEditScreen(
      drawData: data,
      drawId: id,
    ));
  }

  // Navigate to VendorCompanyDetails with provided name and id
  navigateToVendorCompanyDetails(String vendorCompanyName, int id) async {
    clearAllControllers();
    vendorCompanyId = id;
    await getAllDraws(vendorCompanyId);
  }

  // Create a draw using API
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
        "sarafi_id": forexController.text,
        "yen": yenPriceController.text.isEmpty ? '' : yenPriceController.text,
        "exchangerate": exchangeRateController.text.isEmpty
            ? ''
            : exchangeRateController.text,
        "vendorcompany_id":
            vendorCompanyId.toString(), // Use vendorCompanyId directly
        "user_id": 1,
      },
    );
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        getAllDraws(vendorCompanyId!);
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

  // Edit a draw using API
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
        "vendorcompany_id":
            vendorCompanyId.toString(), // Use vendorCompanyId directly
        "user_id": 1,
      },
    );
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        getAllDraws(vendorCompanyId!);
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

  // Delete an item locally from the list
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

  // Delete a draw using API
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

  // Get all draws from the API based on vendor company id
  getAllDraws(int? vendorCompanyId) async {
    _helperServices.showLoader();
    final response = await DrawApiServiceProvider().getDraw('getDraw');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) {
        allDraws =
            r.where((draw) => draw.vendorcompanyId == vendorCompanyId).toList();
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

  // Function to calculate the sum of the 'amount' column from the list of draws
  double calculateSumOfTotalDollar(List<Data>? draws) {
    double sum = 0;

    if (draws != null) {
      for (var draw in draws) {
        sum += draw.doller ?? 0;
      }
    }
    return sum;
  }

  double calculateSumOfTotalYen(List<Data>? draws) {
    double sum = 0;

    if (draws != null) {
      for (var draw in draws) {
        sum += draw.yen ?? 0;
      }
    }
    return sum;
  }

  // Search draws based on provided name
  searchDrawsMethod(String name) {
    searchText = name;
    updateDrawsData();
  }

  // Update draws data based on search text
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

  // Clear values of all controllers
  void clearAllControllers() {
    dateController.clear();
    dollarPriceController.clear();
    descriptionController.clear();
    bankPhotoController.clear();
    forexController.clear();
    yenPriceController.clear();
    exchangeRateController.clear();
    vendorCompanyController.clear();
    selectedForexController.clear();
  }
}
