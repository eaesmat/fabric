import 'package:fabricproject/api/transport_deals_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/transport_deals_model.dart';
import 'package:fabricproject/screens/transport/transport_details_screen.dart';
import 'package:fabricproject/screens/transport_deals/transport_deals_edit_screen.dart';
import 'package:fabricproject/screens/transport_deals/transport_deals_create_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class TransportDealsController extends ChangeNotifier {
  // helper class instance
  final HelperServices _helperServices;

  // Text editing controllers
  TextEditingController startDateController = TextEditingController();
  TextEditingController selectedFabricPurchaseNameController =
      TextEditingController();
  TextEditingController amountOfBundlesController = TextEditingController();
  TextEditingController singleKhatPriceController = TextEditingController();
  TextEditingController amountOfKhatController = TextEditingController();
  TextEditingController totalCostController = TextEditingController();
  TextEditingController warPriceController = TextEditingController();
  TextEditingController containerNameController = TextEditingController();
  TextEditingController selectedSaraiIdController = TextEditingController();
  TextEditingController selectedSaraiNameController = TextEditingController();
  TextEditingController selectedFabricPurchaseIdController =
      TextEditingController();
  TextEditingController selectedFabricPurchaseCodeController =
      TextEditingController();
  TextEditingController photoController = TextEditingController();
  TextEditingController warPriceFromUIController = TextEditingController();

  // Lists to hold data comes from API
  List<Data>? allTransportDeals = [];
  List<Data>? searchTransportDeals = [];

  // This will hold search text field text
  String searchText = "";
  int? transportId;

  TransportDealsController(this._helperServices);

  navigateToTransportDealCreate(int curTransportId) {
    clearAllControllers();
    _helperServices
        .navigate(TransportDealsCreateScreen(curTransportId: curTransportId));
  }

  navigateToTransportDealsEdit(Data data, int id, int curTransportId) {
    clearAllControllers();
    startDateController.text = data.startdate.toString();
    selectedFabricPurchaseIdController.text = data.fabricpurchaseId.toString();
    selectedFabricPurchaseCodeController.text =
        data.fabricpurchasecode.toString();
    amountOfBundlesController.text = data.bundle.toString();
    singleKhatPriceController.text = data.costperkhat.toString();
    amountOfKhatController.text = data.khatamount.toString();
    totalCostController.text = data.totalcost.toString();
    warPriceController.text = data.war.toString();
    containerNameController.text = data.containerName.toString();
    selectedSaraiIdController.text = data.saraiId.toString();
    selectedSaraiNameController.text = data.name.toString();

    _helperServices.navigate(TransportDealsEditScreen(
      curTransportId: curTransportId,
      transportDealId: id,
    ));
  }

  navigateToTransportDealDetailsScreen(String transportName, int id) async {
    clearAllControllers();
    transportId = id;

    _helperServices.navigate(TransportDetailsScreen(
      transportId: id,
      transportName: transportName,
    ));

    await getTransportDeals(id); // Wait for getAllFabricPurchases to complete
  }

  // Gets all the data
  getTransportDeals(int? transportId) async {
    _helperServices.showLoader();

    final response = await TransportDealsApiServiceProvider()
        .getTransportDeals('getTransportDeals/$transportId');

    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) {
        allTransportDeals = r;
        _helperServices.goBack();
        searchTransportDeals?.clear();
        searchTransportDeals?.addAll(allTransportDeals!);
        notifyListeners();
      },
    );
  }

  createTransportDeals(int curTransportId) async {
    _helperServices.showLoader();

    var response =
        await TransportDealsApiServiceProvider().createTransportDeals(
      'add-transport-deal',
      {
        "date": startDateController.text,
        "tp_id": curTransportId.toInt(),
        "fabricpurchase_id": selectedFabricPurchaseIdController.text,
        "bundle": amountOfBundlesController.text,
        "costperkhat": singleKhatPriceController.text,
        "khatamount": amountOfKhatController.text,
        "totalcost": totalCostController.text,
        "warcost": warPriceController.text,
        "container_name": containerNameController.text,
        "sarai_id": selectedSaraiIdController.text,
      },
    );

    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) => {
        getTransportDeals(curTransportId),
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

  updateTransportDeals(int curTransportId, transportDealId) async {
    _helperServices.showLoader();

    var response =
        await TransportDealsApiServiceProvider().createTransportDeals(
      'update-transport-deal?$transportDealId',
      {
        "date": startDateController.text,
        "tp_id": curTransportId.toInt(),
        "transportdeal_id": transportDealId,
        "fabricpurchase_id": selectedFabricPurchaseIdController.text,
        "bundle": amountOfBundlesController.text,
        "costperkhat": singleKhatPriceController.text,
        "khatamount": amountOfKhatController.text,
        "totalcost": totalCostController.text,
        "warcost": warPriceController.text,
        "container_name": containerNameController.text,
        "sarai_id": selectedSaraiIdController.text,
      },
    );

    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) => {
        getTransportDeals(curTransportId),
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

  searchTransportDealsMethod(String name) {
    searchText = name;
    updateTransportDealsData();
  }

  // Updates data UI according entered search text
  updateTransportDealsData() {
    searchTransportDeals?.clear();
    if (searchText.isEmpty) {
      searchTransportDeals?.addAll(allTransportDeals!);
    } else {
      searchTransportDeals?.addAll(
        allTransportDeals!
            .where((element) =>
                element.startdate.toString().contains(searchText) ||
                element.arrivaldate.toString().contains(searchText) ||
                element.khatamount.toString().contains(searchText) ||
                element.costperkhat.toString().contains(searchText) ||
                element.status.toString().contains(searchText) ||
                element.duration.toString().contains(searchText) ||
                element.bundle.toString().contains(searchText) ||
                element.totalcost.toString().contains(searchText) ||
                element.warcost.toString().contains(searchText) ||
                element.fabricpurchasecode.toString().contains(searchText) ||
                element.war.toString().contains(searchText) ||
                element.containerName
                    .toString()
                    .toLowerCase()
                    .contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
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
    containerNameController.clear();
    amountOfKhatController.clear();
    photoController.clear();
    warPriceController.clear();
    warPriceFromUIController.clear();
    containerNameController.clear();
  }

  void clearKhatCalculatedControllers() {
    singleKhatPriceController.clear();
    totalCostController.clear();
    amountOfKhatController.clear();
    warPriceController.clear();
  }
}
