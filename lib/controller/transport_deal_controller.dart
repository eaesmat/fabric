import 'dart:async';

import 'package:fabricproject/api/container_api.dart';
import 'package:fabricproject/api/sarai_api.dart';
import 'package:fabricproject/api/transport_deal_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/transport_deal_model.dart';
import 'package:fabricproject/screens/sarai/sarai_details_screen.dart';
import 'package:fabricproject/screens/transport/transport_details_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class TransportDealController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController startDateController = TextEditingController();
  TextEditingController selectedSaraiNameController = TextEditingController();
  TextEditingController selectedSaraiIdController = TextEditingController();
  TextEditingController saraiInDealIdController = TextEditingController();
  TextEditingController saraiInDealDate = TextEditingController();
  TextEditingController amountOfBundlesController = TextEditingController();
  TextEditingController transportIdController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController warPriceController = TextEditingController();
  TextEditingController totalCostController = TextEditingController();
  TextEditingController selectedFabricPurchaseIdController =
      TextEditingController();
  TextEditingController singleKhatPriceController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController selectedFabricPurchaseNameController =
      TextEditingController();
  TextEditingController containerIdController = TextEditingController();
  TextEditingController warPriceFromUIController = TextEditingController();
  TextEditingController containerNameController = TextEditingController();
  TextEditingController amountOfKhatController = TextEditingController();
  TextEditingController selectedFabricPurchaseCodeController =
      TextEditingController();
  TextEditingController photoController = TextEditingController();

  int? transportId;
  List<Data>? allTransportDeals = [];
  List<Data>? searchTransportDeals = [];
  List<Data>? searchTransportDealsWithNoFilter = [];
  List<Data>? allTransportDealsWithNoFilter = [];
  List<Data>? allReceiptTransportDeals = [];
  List<Data>? searchAllReceiptTransportDeals = [];

  List? filteredContainers;
  List? filteredSarai;
  String searchText = "";
  bool isAdded = false;
  bool isUpdated = false;
  bool noContainer = false;
  bool noSaraInDeal =
      false; // used to hold the id just to check whether the sarai in deal from update  is null not not
  double sumOfTransportDealTotalCost =
      0; // Variable to hold the sum of the 'totalCost' column
  double sumOfTransportDealTotalBundle =
      0; // Variable to hold the sum of the 'bundle' column
  double sumOfTransportDealTotalDueBundle =
      0; // Variable to hold the sum of the 'bundle' column

  TransportDealController(
    this._helperServices,
  ) {
    getAllTransportDeal(transportId);
  }

  navigateToTransportDealCreate() {
    containerNameController.clear();
    clearAllControllers();

    // _helperServices.navigate(const TransportDealCreateScreen());
  }

  navigateToTransportDealEdit(Data data, int? transportDealId, containerId,
      int? saraiId, saraInDealId, String saraiInDate) async {
    clearAllControllers();
    containerNameController.clear();

    if (transportDealId != null) {
      await getContainer(transportDealId);
    }

    if (saraiId != null) {
      await getSarai(saraiId);
    }

    if (saraInDealId == null || saraInDealId == 0) {
      noSaraInDeal = true;
      print("if works");
    } else {
      saraiInDealIdController.text = saraInDealId.toString();
      noSaraInDeal = false;
    }
    if (containerId == null || containerId == 0) {
      noContainer = true;
      print("if works");
    } else {
      saraiInDealIdController.text = saraInDealId.toString();
      noContainer = false;
    }

    print("indeal id ");
    print(saraInDealId);

    if (filteredContainers != null && filteredContainers!.isNotEmpty) {
      print(filteredContainers![0].name);
      containerNameController.text = filteredContainers![0].name;
      containerIdController.text =
          filteredContainers![0].containerId.toString();
    } else {}
    print("the lenght");
    print(saraInDealId);

    startDateController.text = data.startdate.toString();
    amountOfBundlesController.text = data.bundle.toString();
    singleKhatPriceController.text = data.costperkhat.toString();
    warPriceController.text = data.warcost.toString();

    amountOfKhatController.text = data.khatamount.toString();
    totalCostController.text = data.totalcost.toString();
    selectedFabricPurchaseCodeController.text =
        data.fabricpurchase!.fabricpurchasecode.toString();

    if (filteredSarai != null && filteredSarai!.isNotEmpty) {
      print(filteredSarai![0].name);
      selectedSaraiNameController.text = filteredSarai![0].name;
      selectedSaraiIdController.text = filteredSarai![0].saraiId.toString();
    } else {
      // Handle the case where filteredSarai is empty or null
    }

    photoController.text = data.photo.toString();
    durationController.text = data.duration.toString();
    saraiInDealDate.text = saraiInDate;
    selectedFabricPurchaseIdController.text = data.fabricpurchaseId.toString();

    // _helperServices.navigate(
    //   TransportDealEditScreen(
    //       transportDealData: data, transportDealId: transportDealId ?? 0),
    // );
  }

  getContainer(int transportDealId) async {
    // _helperServices.showLoader();
    final response =
        await ContainerApiServiceProvider().getContainer('getContainer');
    response.fold(
      (l) {
        // _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        // Filtering the containers based on transportDealId
        filteredContainers = r
            .where((container) => container.transportdealId == transportDealId)
            .toList();

        // Do something with filteredContainers if needed

        // _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  getSarai(int saraiId) async {
    _helperServices.showLoader();
    final response = await SaraiApiServiceProvider().getSarai('getSarai');
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        // Filtering the containers based on transportDealId
        filteredSarai = r.where((sarai) => sarai.saraiId == saraiId).toList();

        // Do something with filteredContainers if needed

        _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  navigateToTransportDealDetailsScreen(String transportName, int id) async {
    clearAllControllers();
    transportId = id;

    _helperServices.navigate(
      TransportDetailsScreen(
        transportId: id,
        transportName: transportName,
      ),
    );

    await getAllTransportDeal(
        transportId); // Wait for getAllFabricPurchases to complete
  }

  // navigateToSaraiDetailsScreen(String saraiName, int saraiId) async {
  //   clearAllControllers();

  //   _helperServices.navigate(
  //     SaraiDetailsScreen(
  //       saraiId: saraiId,
  //       saraiName: saraiName,
  //     ),
  //   );

  //   await getAllReceiptTransportDeals(
  //       saraiId); // Wait for getAllFabricPurchases to complete
  // }

  getAllReceiptTransportDeals(int saraiId) async {
    _helperServices.showLoader();
    final response = await TransportDealApiServiceProvider()
        .getTransportDeal('getTransportDeal');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) {
        print("The deal lenght");
        print(r.length);
      
        allReceiptTransportDeals = r
            .where((transportDeal) =>
                transportDeal.status != 'pending' &&
                transportDeal.arrivaldate != null &&
                transportDeal.saraiindeal!
                    .any((saraiInDeal) => saraiInDeal.saraiId == saraiId))
            .toList();
        searchAllReceiptTransportDeals?.clear();
        searchAllReceiptTransportDeals?.addAll(allReceiptTransportDeals!);

        _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  getAllTransportDeal(int? transportId) async {
    _helperServices.showLoader();
    final response = await TransportDealApiServiceProvider()
        .getTransportDeal('getTransportDeal');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) {
        print("The deal lenght");
        print(r.length);
        allTransportDealsWithNoFilter = r
            .where((transportDeal) => transportDeal.status == 'pending')
            .toList();
        allReceiptTransportDeals = r
            .where((transportDeal) =>
                transportDeal.status != 'pending' &&
                transportDeal.arrivaldate != null &&
                transportDeal.saraiindeal!
                    .any((saraiInDeal) => saraiInDeal.saraiId == 1))
            .toList();
        searchAllReceiptTransportDeals?.clear();
        searchAllReceiptTransportDeals?.addAll(allReceiptTransportDeals!);
        // goBack pops the current stack
        searchTransportDealsWithNoFilter?.clear();
        searchTransportDealsWithNoFilter
            ?.addAll(allTransportDealsWithNoFilter!);
        print("the no filter lenght");
        print(searchTransportDealsWithNoFilter!.length);
        allTransportDeals = r
            .where((transportDeal) => transportDeal.transportId == transportId)
            .toList();
        searchTransportDeals?.clear();
        searchTransportDeals?.addAll(allTransportDeals!);
        print("the  filter lenght");
        print(searchTransportDeals!.length);
        sumOfTransportDealTotalCost =
            calculateSumOfTotalCost(allTransportDeals);

        sumOfTransportDealTotalBundle =
            calculateSumOfTotalBundles(allTransportDeals);

        sumOfTransportDealTotalDueBundle =
            calculateSumOfTotalDueBundles(allTransportDeals);

        _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  double calculateSumOfTotalCost(List<Data>? transportDeals) {
    double sum = 0;

    if (transportDeals != null) {
      for (var transportDeal in transportDeals) {
        // Replace 'amount' with the actual field name from your FabricPurchase model
        sum += transportDeal.totalcost ?? 0; // Add the 'amount' to the sum
      }
    }
    return sum;
  }

  double calculateSumOfTotalBundles(List<Data>? transportDeals) {
    double sum = 0;

    if (transportDeals != null) {
      for (var transportDeal in transportDeals) {
        // Replace 'amount' with the actual field name from your FabricPurchase model
        sum += transportDeal.bundle ?? 0; // Add the 'amount' to the sum
      }
    }
    return sum;
  }

  double calculateSumOfTotalDueBundles(List<Data>? transportDeals) {
    double sum = 0;

    if (transportDeals != null) {
      for (var transportDeal in transportDeals) {
        if (transportDeal.status != "pending") {
          sum += transportDeal.bundle ?? 0; // Add the 'bundle' to the sum
        }
      }
    }
    return sum;
  }

  int? getLastTransportDealId() {
    if (allTransportDeals != null && allTransportDeals!.isNotEmpty) {
      // Retrieve the last item in the list
      Data lastItem = allTransportDeals!.last;
      // Get the transportdeal_id of the last item
      int? lastTransportDealId = lastItem.transportdealId;
      return lastTransportDealId;
    } else {
      return null;
    }
  }

  createTransportDeal() async {
    _helperServices.showLoader();

    var response = await TransportDealApiServiceProvider().createTransportDeal(
      'add-transport-deal',
      {
        "transportdeal_id": 0,
        "startdate": startDateController.text,
        "arrivaldate": null,
        "fabricpurchase_id": selectedFabricPurchaseIdController.text,
        "khatamount": amountOfKhatController.text,
        "costperkhat": singleKhatPriceController.text,
        "transport_id": transportId.toString(),
        "status": "pending",
        "duration": durationController.text,
        "bundle": amountOfBundlesController.text,
        "photo": photoController.text,
        "totalcost": totalCostController.text,
        "warcost": warPriceController.text,
        "user_id": 1,
      },
    );
    response.fold(
      (l) {
        isAdded = false;
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        getAllTransportDeal(transportId!);
        isAdded = true;
        _helperServices.goBack();
        _helperServices.showMessage(
          const LocaleText('added'),
          Colors.green,
          const Icon(
            Icons.check,
            color: Pallete.whiteColor,
          ),
        );
        print("added");
      },
    );
  }

  // Method to refresh transport deal data after insertion
  Future<void> refreshTransportDealData() async {
    await getAllTransportDeal(transportId); // Refresh data
    notifyListeners(); // Notify listeners to update the UI
  }

  editTransportDeal(int transportDealId) async {
    _helperServices.showLoader();

    var response = await TransportDealApiServiceProvider().editTransportDeal(
      'update-transport-deal?$transportDealId',
      {
        "transportdeal_id": transportDealId,
        "startdate": startDateController.text,
        "arrivaldate": null,
        "fabricpurchase_id": selectedFabricPurchaseIdController.text,
        "khatamount": amountOfKhatController.text,
        "costperkhat": singleKhatPriceController.text,
        "transport_id": transportId.toString(),
        "status": "pending",
        "duration": durationController.text,
        "bundle": amountOfBundlesController.text,
        "photo": photoController.text,
        "totalcost": totalCostController.text,
        "warcost": warPriceController.text,
        "user_id": 1,
      },
    );
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
        isUpdated = false;
        print("transport deal error ");
      },
      (r) {
        _helperServices.goBack();
        isUpdated = true;
        _helperServices.showMessage(
          const LocaleText('updated'),
          Colors.green,
          const Icon(
            Icons.check,
            color: Pallete.whiteColor,
          ),
        );

        // clearAllControllers();
      },
    );
  }

  editTransportDealStatusReceived(int transportDealId, Data data) async {
    int transportId = data.transportId!.toInt();
    DateTime selectedDate = DateTime.now();
    String currentDate =
        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
    startDateController.text = data.startdate.toString();

    amountOfKhatController.text = data.khatamount.toString();
    singleKhatPriceController.text = data.costperkhat.toString();
    transportIdController.text = data.transportId.toString();
    selectedFabricPurchaseIdController.text = data.fabricpurchaseId.toString();
    durationController.text = data.duration.toString();
    amountOfBundlesController.text = data.bundle.toString();
    photoController.text = data.photo.toString();
    totalCostController.text = data.totalcost.toString();
    warPriceController.text = data.warcost.toString();

    _helperServices.showLoader();

    var response = await TransportDealApiServiceProvider().editTransportDeal(
      'update-transport-deal?$transportDealId',
      {
        "transportdeal_id": transportDealId,
        "startdate": startDateController.text,
        "arrivaldate": currentDate,
        "fabricpurchase_id": selectedFabricPurchaseIdController.text,
        "khatamount": amountOfKhatController.text,
        "costperkhat": singleKhatPriceController.text,
        "transport_id": transportIdController.text,
        "status": "received",
        "duration": durationController.text,
        "bundle": amountOfBundlesController.text,
        "photo": photoController.text,
        "totalcost": totalCostController.text,
        "warcost": warPriceController.text,
        "user_id": 1,
      },
    );
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
        isUpdated = false;
      },
      (r) {
        _helperServices.goBack();
        isUpdated = true;
        getAllTransportDeal(transportId);
        print("transport deal success ");
        _helperServices.showMessage(
          const LocaleText('updated'),
          Colors.green,
          const Icon(
            Icons.check,
            color: Pallete.whiteColor,
          ),
        );

        // clearAllControllers();
      },
    );
  }

  deleteTransportDeal(id, index) async {
    _helperServices.showLoader();
    var response = await TransportDealApiServiceProvider()
        .deleteTransportDeal('delete-transport-deal?transportdeal_id=$id');
    _helperServices.goBack();
    response.fold(
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
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
            searchTransportDeals!.removeAt(index),
            notifyListeners(),
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

  searchTransportDealMethod(String name) {
    searchText = name;
    updateTransportDealData();
  }

  searchTransportDealWithNoFilterMethod(String name) {
    searchText = name;
    updateTransportDealDataWithNoFilter();
  }

  searchAllReceiptTransportDealsMethod(String name) {
    searchText = name;
    updateTransportDealDataWithNoFilter();
  }

  updateSearchAllReceiptTransportDeals() {
    searchAllReceiptTransportDeals?.clear();

    if (searchText.isEmpty) {
      searchAllReceiptTransportDeals?.addAll(allReceiptTransportDeals!);
    } else {
      searchAllReceiptTransportDeals?.addAll(
        allReceiptTransportDeals!
            .where((element) =>
                element.fabricpurchase!.fabricpurchasecode!
                    .toLowerCase()
                    .contains(searchText) ||
                element.arrivaldate!.toLowerCase().contains(searchText) ||
                element.fabricpurchase!.fabricpurchasecode!
                    .toLowerCase()
                    .contains(searchText) ||
                element.startdate!.toLowerCase().contains(searchText))
            // element.!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  updateTransportDealData() {
    searchTransportDeals?.clear();

    if (searchText.isEmpty) {
      searchTransportDeals?.addAll(allTransportDeals!);
    } else {
      searchTransportDeals?.addAll(
        allTransportDeals!
            .where((element) =>
                element.fabricpurchase!.fabricpurchasecode!
                    .toLowerCase()
                    .contains(searchText) ||
                element.arrivaldate!.toLowerCase().contains(searchText) ||
                element.fabricpurchase!.fabricpurchasecode!
                    .toLowerCase()
                    .contains(searchText) ||
                element.startdate!.toLowerCase().contains(searchText))
            // element.!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  updateTransportDealDataWithNoFilter() {
    searchTransportDealsWithNoFilter?.clear();

    if (searchText.isEmpty) {
      searchTransportDealsWithNoFilter?.addAll(allTransportDealsWithNoFilter!);
    } else {
      searchTransportDealsWithNoFilter?.addAll(
        allTransportDealsWithNoFilter!
            .where((element) =>
                element.fabricpurchase!.fabricpurchasecode!
                    .toLowerCase()
                    .contains(searchText) ||
                element.arrivaldate!.toLowerCase().contains(searchText) ||
                element.fabricpurchase!.fabricpurchasecode!
                    .toLowerCase()
                    .contains(searchText) ||
                element.startdate!.toLowerCase().contains(searchText))
            // element.!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    searchText = '';
    updateTransportDealData();
  }

  void clearAllControllers() {
    startDateController.clear();
    amountOfBundlesController.clear();
    singleKhatPriceController.clear();
    totalCostController.clear();
    selectedSaraiNameController.clear();
    selectedFabricPurchaseCodeController.clear();
    selectedFabricPurchaseIdController.clear();
    selectedSaraiIdController.clear();
    selectedSaraiNameController.clear();
    durationController.clear();
    containerIdController.clear();
    selectedFabricPurchaseNameController.clear();
    amountOfKhatController.clear();
    amountOfBundlesController.clear();
    photoController.clear();
    warPriceController.clear();
    amountOfBundlesController.clear();
  }

  void clearKhatCalculatedControllers() {
    singleKhatPriceController.clear();
    totalCostController.clear();
    amountOfKhatController.clear();
    warPriceController.clear();
  }
}
