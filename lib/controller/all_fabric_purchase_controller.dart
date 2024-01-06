import 'package:fabricproject/api/fabric_purchase_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/fabric_purchase_model.dart';
import 'package:fabricproject/screens/all_fabric_purchase/all_fabric_purchase_create_screen.dart';
import 'package:fabricproject/screens/all_fabric_purchase/all_fabric_purchase_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class AllFabricPurchaseController extends ChangeNotifier {
  final HelperServices _helperServices;
  // Gets and sends data to the ui
  TextEditingController selectedCompanyIdController = TextEditingController();
  TextEditingController selectedCompanyNameController = TextEditingController();
  TextEditingController selectedFabricNameController = TextEditingController();
  TextEditingController selectedFabricIdController = TextEditingController();
  TextEditingController amountOfBundlesController = TextEditingController();
  TextEditingController amountOfMetersController = TextEditingController();
  TextEditingController amountOfWarsController = TextEditingController();
  TextEditingController yenPriceController = TextEditingController();
  TextEditingController totalYenPriceController = TextEditingController();
  TextEditingController exchangeRateController = TextEditingController();
  TextEditingController dollarPriceController = TextEditingController();
  TextEditingController totalDollarPriceController = TextEditingController();
  TextEditingController ttCommissionController = TextEditingController();
  TextEditingController packagePhotoController = TextEditingController();
  TextEditingController bankReceivedPhotoController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController fabricCodeController = TextEditingController();
  TextEditingController selectedVendorCompanyId = TextEditingController();
  TextEditingController selectedVendorCompanyName = TextEditingController();
  TextEditingController selectedTransportName = TextEditingController();
  TextEditingController selectedTransportId = TextEditingController();

  double sumOfFabricPurchaseTotalDollar =
      0; // Variable to hold the sum of the 'dollar' column
  double sumOfFabricPurchaseTotalYen =
      0; // Variable to hold the sum of the 'yen' column

// Hold api response data
  List<Data>? allFabricPurchases = [];
  List<Data>? searchFabricPurchases = [];
// Holds search textfield text
  String searchText = "";
  bool isAdded = false;

  AllFabricPurchaseController(
    this._helperServices,
  ) {
    getAllFabricPurchases();
  }

  navigateToFabricPurchaseCreate() {
    clearAllControllers();
    _helperServices.navigate(const AllFabricPurchaseCreateScreen());
  }

  navigateToFabricPurchaseEdit(Data data, int id) {
    clearAllControllers();
// pass these data to the edit screen
    selectedCompanyIdController.text = data.companyId.toString();
    selectedFabricIdController.text = data.fabricId.toString();
    selectedFabricNameController.text =
        ("${data.fabric!.name!},   ${data.fabric!.abr!}");
    selectedCompanyNameController.text =
        ("${data.company!.name!},   ${data.company!.marka!}");
    selectedVendorCompanyId.text =
        data.vendorcompany!.vendorcompanyId.toString();
    selectedVendorCompanyName.text = data.vendorcompany!.name.toString();
    amountOfBundlesController.text = data.bundle.toString();
    amountOfMetersController.text = data.meter.toString();
    amountOfWarsController.text = data.war.toString();
    yenPriceController.text = data.yenprice.toString();
    totalYenPriceController.text = data.totalyenprice.toString();
    dollarPriceController.text = data.dollerprice.toString();
    totalDollarPriceController.text = data.totaldollerprice.toString();
    exchangeRateController.text = data.yenexchange.toString();
    ttCommissionController.text = data.ttcommission.toString();
    packagePhotoController.text = data.packagephoto.toString();
    bankReceivedPhotoController.text = data.bankreceiptphoto.toString();
    dateController.text = data.date.toString();
    fabricCodeController.text = data.fabricpurchasecode.toString();
    _helperServices.navigate(
      AllFabricPurchaseEditScreen(
        fabricPurchaseData: data,
        fabricPurchaseId: id,
      ),
    );
  }

  int? getLastFabricPurchaseId() {
    if (allFabricPurchases != null && allFabricPurchases!.isNotEmpty) {
      // Retrieve the last item in the list
      Data lastItem = allFabricPurchases!.last;
      // Get the transportdeal_id of the last item
      int? lastTransportDealId = lastItem.fabricpurchaseId;
      return lastTransportDealId;
    } else {
      return null;
    }
  }

// Gets the purchases by vendor company id
  getAllFabricPurchases() async {
    _helperServices.showLoader();
    final response = await FabricPurchaseApiServiceProvider()
        .getFabricPurchase('getFabricPurchase');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) {
        // Gets only with the given vendor company id
// r holds data comes from api with success
        allFabricPurchases = r;
        // goBack pops the current stack
        _helperServices.goBack();
        searchFabricPurchases?.clear();
        searchFabricPurchases?.addAll(allFabricPurchases!);
        // this methods assign the recent data to the search List
        // updateForexData();
        notifyListeners();
      },
    );
  }

  // Function to calculate the sum of the column from the list of FabricPurchases
  double calculateSumOfTotalDollar(List<Data>? fabricPurchases) {
    double sum = 0;

    if (fabricPurchases != null) {
      for (var fabricPurchase in fabricPurchases) {
        sum += fabricPurchase.totaldollerprice ?? 0;
      }
    }
    return sum;
  }

  double calculateSumOfTotalYen(List<Data>? fabricPurchases) {
    double sum = 0;

    if (fabricPurchases != null) {
      for (var fabricPurchase in fabricPurchases) {
        sum += fabricPurchase.totalyenprice ?? 0;
      }
    }
    return sum;
  }

  createFabricPurchase() async {
    _helperServices.showLoader();

    var response =
        await FabricPurchaseApiServiceProvider().createFabricPurchase(
      'add-fabric-purchase',
      {
        "fabricpurchase_id": 0,
        "bundle": amountOfBundlesController.text,
        "meter": amountOfMetersController.text,
        "war": amountOfWarsController.text,
        "yenprice": yenPriceController.text,
        "yenexchange": exchangeRateController.text,
        "ttcommission": ttCommissionController.text,
        "packagephoto": packagePhotoController.text,
        "bankreceiptphoto": bankReceivedPhotoController.text,
        "date": dateController.text,
        "fabric_id": selectedFabricIdController.text,
        "company_id": selectedCompanyIdController.text,
        "vendorcompany_id": selectedVendorCompanyId.text,
        "fabricpurchasecode": fabricCodeController.text,
        "dollerprice": dollarPriceController.text,
        "totalyenprice": totalYenPriceController.text,
        "totaldollerprice": totalDollarPriceController.text,
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
        getAllFabricPurchases();
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

        // clearAllControllers();
      },
    );
  }

  editFabricPurchase(int fabricPurchaseId) async {
    _helperServices.showLoader();

    var response = await FabricPurchaseApiServiceProvider().editFabricPurchase(
      'update-fabric-purchase?$fabricPurchaseId',
      {
        "fabricpurchase_id": fabricPurchaseId,
        "bundle": amountOfBundlesController.text,
        "meter": amountOfMetersController.text,
        "war": amountOfWarsController.text,
        "yenprice": yenPriceController.text,
        "yenexchange": exchangeRateController.text,
        "ttcommission": ttCommissionController.text,
        "packagephoto": packagePhotoController.text,
        "bankreceiptphoto": bankReceivedPhotoController.text,
        "date": dateController.text,
        "fabric_id": selectedFabricIdController.text,
        "company_id": selectedCompanyIdController.text,
        "vendorcompany_id": selectedVendorCompanyId.text,
        "fabricpurchasecode": fabricCodeController.text,
        "dollerprice": dollarPriceController.text,
        "totalyenprice": totalYenPriceController.text,
        "totaldollerprice": totalDollarPriceController.text,
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
        getAllFabricPurchases();
        _helperServices.goBack();
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

// This method removes  or delete the item without reloading server
  void deleteItemLocally(int id) {
    final index = allFabricPurchases!
        .indexWhere((element) => element.fabricpurchaseId == id);
    if (index != -1) {
      allFabricPurchases!.removeAt(index);

      final searchIndex = searchFabricPurchases!
          .indexWhere((element) => element.fabricpurchaseId == id);
      if (searchIndex != -1) {
        searchFabricPurchases!.removeAt(searchIndex);
      }

      notifyListeners();
    }
  }

  deleteFabricPurchase(id, index) async {
    _helperServices.showLoader();
    var response = await FabricPurchaseApiServiceProvider()
        .deleteFabricPurchase('delete-fabric-purchase?fabricpurchase_id=$id');
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

  searchFabricPurchasesMethod(String name) {
    searchText = name;
    updateFabricPurchasesData();
  }

  updateFabricPurchasesData() {
    searchFabricPurchases?.clear();
    if (searchText.isEmpty) {
      searchFabricPurchases?.addAll(allFabricPurchases!);
    } else {
      searchFabricPurchases?.addAll(
        allFabricPurchases!
            .where((element) =>
                element.fabricpurchasecode!
                    .toLowerCase()
                    .contains(searchText) ||
                element.fabric!.name!.toLowerCase().contains(searchText) ||
                element.company!.name!.toLowerCase().contains(searchText) ||
                element.date!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    searchText = '';
    updateFabricPurchasesData();
  }

  void clearAllControllers() {
    selectedCompanyIdController.clear();
    selectedCompanyNameController.clear();
    selectedFabricNameController.clear();
    selectedFabricIdController.clear();
    amountOfBundlesController.clear();
    amountOfMetersController.clear();
    amountOfWarsController.clear();
    yenPriceController.clear();
    totalYenPriceController.clear();
    exchangeRateController.clear();
    dollarPriceController.clear();
    totalDollarPriceController.clear();
    ttCommissionController.clear();
    packagePhotoController.clear();
    bankReceivedPhotoController.clear();
    dateController.clear();
    fabricCodeController.clear();
    selectedVendorCompanyId.clear();
    selectedVendorCompanyName.clear();
    selectedTransportId.clear();
    selectedTransportName.clear();
  }
}
