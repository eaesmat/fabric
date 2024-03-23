import 'package:fabricproject/api/all_fabric_purchases_api.dart';
import 'package:fabricproject/api/fabric_purchase_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/all_fabric_purchases_model.dart';
import 'package:fabricproject/screens/all_fabric_purchase/all_fabric_purchase_create_screen.dart';
import 'package:fabricproject/screens/all_fabric_purchase/all_fabric_purchase_edit_screen.dart';
import 'package:fabricproject/screens/hesabat_china/hesabat_china_fabric_purchase_edit_screen.dart';
import 'package:fabricproject/screens/hesabat_china/hesabat_china_purchase_create_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class AllFabricPurchasesController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController selectedCompanyIdController = TextEditingController();
  TextEditingController abrController = TextEditingController();
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

  List<Data> allFabricPurchases = [];
  List<Data> searchAllFabricPurchases = [];
  List<Data> cachedForex = [];

  String totalDollerPirce = "";
  String submitDoller = "";
  String balance = "";
  String kldhmd = "";
  String searchText = "";

  AllFabricPurchasesController(this._helperServices) {
    getAllFabricPurchases();
  }

  navigateToFabricPurchaseCreate(String purchaseType) {
    // dispose();
    clearAllControllers();

    if (purchaseType == 'khalid') {
      _helperServices.navigate(
        const AllFabricPurchaseCreateScreen(),
      );
    } else {
      _helperServices.navigate(
        const HesabatChinaFabricPurchaseCreateScreen(),
      );
    }
  }

  navigateToFabricPurchaseEdit(
      Data data, int fabricPurchaseId, String purchaseType) {
    clearAllControllers();
    amountOfBundlesController.text = data.bundle.toString();
    amountOfMetersController.text = data.meter.toString();
    amountOfWarsController.text = data.war.toString();
    yenPriceController.text = data.yenprice.toString();
    exchangeRateController.text = data.yenexchange.toString();
    ttCommissionController.text = data.ttcommission.toString();
    dateController.text = data.date.toString();
    selectedFabricIdController.text = data.fabricId.toString();
    selectedCompanyIdController.text = data.companyId.toString();
    selectedVendorCompanyId.text = data.vendorcompanyId.toString();
    fabricCodeController.text = data.fabricpurchasecode.toString();
    dollarPriceController.text = data.dollerprice.toString();
    totalYenPriceController.text = data.totalyenprice.toString();
    totalDollarPriceController.text = data.totaldollerprice.toString();
    selectedVendorCompanyName.text = data.vendorcompany.toString();
    selectedCompanyNameController.text = data.marka.toString();
    selectedFabricNameController.text = data.fabricName.toString();

    if (purchaseType == 'khalid') {
      _helperServices.navigate(
        AllFabricPurchaseEditScreen(
          fabricPurchaseId: fabricPurchaseId,
          status: data.status.toString(),
        ),
      );
    } else {
      _helperServices.navigate(
        HesabatChinaPurchaseEditScreen(
          fabricPurchaseId: fabricPurchaseId,
          status: data.status.toString(),
        ),
      );
    }
  }

  Future<void> getAllFabricPurchases() async {
    _helperServices.showLoader();
    try {
      final response = await AllFabricPurchasesApiServiceProvider()
          .getAllFabricPurchase('loadKhalidPurchase');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allFabricPurchases = r;
          searchAllFabricPurchases = List.from(allFabricPurchases);
          cachedForex = List.from(allFabricPurchases); // Cache initial data
          _helperServices.goBack();
          getKhalidCalculation();

          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> getKhalidCalculation() async {
    try {
      final response = await AllFabricPurchasesApiServiceProvider()
          .getKhalidCalculation('statusResult');
      response.fold(
        (l) {
          _helperServices.showErrorMessage(l);
        },
        (r) {
          totalDollerPirce = r.totalDollerPirce.toString();
          submitDoller = r.submitDoller.toString();
          balance = r.balance.toString();
          kldhmd = r.kldhmd.toString();

          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void printControllerValues() {
    print("selectedCompanyIdController: ${selectedCompanyIdController.text}");

    print("selectedFabricIdController: ${selectedFabricIdController.text}");
    print("amountOfBundlesController: ${amountOfBundlesController.text}");
    print("amountOfMetersController: ${amountOfMetersController.text}");
    print("amountOfWarsController: ${amountOfWarsController.text}");
    print("yenPriceController: ${yenPriceController.text}");
    print("totalYenPriceController: ${totalYenPriceController.text}");
    print("exchangeRateController: ${exchangeRateController.text}");
    print("dollarPriceController: ${dollarPriceController.text}");
    print("totalDollarPriceController: ${totalDollarPriceController.text}");
    print("ttCommissionController: ${ttCommissionController.text}");
    print("packagePhotoController: ${packagePhotoController.text}");
    print("bankReceivedPhotoController: ${bankReceivedPhotoController.text}");
    print("dateController: ${dateController.text}");
    print("selectedVendorCompanyId: ${selectedVendorCompanyId.text}");
    print("selectedTransportId: ${selectedTransportId.text}");
  }

  Future<void> createFabricPurchase() async {
    // printControllerValues();
    _helperServices.showLoader();
    try {
      final response =
          await AllFabricPurchasesApiServiceProvider().createFabricPurchase(
        'addKhalidPurchase',
        {
          "vc_id": selectedVendorCompanyId.text,
          "fabric_id":
              "${selectedFabricIdController.text} ${abrController.text}",
          "bundle": amountOfBundlesController.text,
          "meter": amountOfMetersController.text,
          "war": amountOfWarsController.text,
          "priceinyen": yenPriceController.text,
          "allpriceinyen": totalYenPriceController.text,
          "yenexchange": exchangeRateController.text,
          "priceindoller": dollarPriceController.text,
          "allpriceindoller": totalDollarPriceController.text,
          "company_id": selectedCompanyIdController.text,
          "date": dateController.text,
          "fabriccode": fabricCodeController.text,
          // "bankreceipt": "(binary)",
          // "packagereceipt": "(binary)",
          "transport_id": selectedTransportId.text,
          "ttcomission": ttCommissionController.text
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
            getAllFabricPurchases();
            clearAllControllers();
          }
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> editFabricPurchase(int fabricPurchaseId, String status) async {
    _helperServices.showLoader();
    try {
      final response = await FabricPurchaseApiServiceProvider()
          .editFabricPurchase(
              'updateKhalidPurchase?fabricpurchase_id=$fabricPurchaseId', {
        "bundle": amountOfBundlesController.text,
        "meter": amountOfMetersController.text,
        "war": amountOfWarsController.text,
        "yenprice": yenPriceController.text,
        "allpriceinyen": totalYenPriceController.text,
        "priceindoller": dollarPriceController.text,
        "allpriceindoller": totalDollarPriceController.text,
        "yenexchange": exchangeRateController.text,
        "ttcommission": ttCommissionController.text,
        "date": dateController.text,
        "fabric_id": "${selectedFabricIdController.text} ${abrController.text}",
        "company_id": selectedCompanyIdController.text,
        "vc_id": selectedVendorCompanyId.text,
        // "bankreceipt": "(binary)",
        // "packagereceipt": "(binary)",
        "fabricpurchasecode": fabricCodeController.text,
      });
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

          updateKhalidPurchaseLocally(
            fabricPurchaseId,
            Data(
              fabricpurchaseId: fabricPurchaseId,
              bundle: int.tryParse(amountOfBundlesController.text),
              meter: double.tryParse(amountOfMetersController.text),
              war: double.tryParse(amountOfWarsController.text),
              yenprice: double.tryParse(yenPriceController.text),
              yenexchange: double.tryParse(exchangeRateController.text),
              ttcommission: double.tryParse(ttCommissionController.text),
              date: dateController.text,
              fabricId: int.tryParse(selectedFabricIdController.text),
              companyId: int.tryParse(selectedCompanyIdController.text),
              vendorcompanyId: int.tryParse(selectedVendorCompanyId.text),
              fabricpurchasecode: fabricCodeController.text,
              dollerprice: double.tryParse(dollarPriceController.text),
              totalyenprice: double.tryParse(totalYenPriceController.text),
              totaldollerprice:
                  double.tryParse(totalDollarPriceController.text),
              vendorcompany: selectedVendorCompanyName.text,
              marka: selectedCompanyNameController.text,
              fabricName: selectedFabricNameController.text,
              status: status,
            ),
          );
          clearAllControllers();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void updateKhalidPurchaseLocally(int id, Data updatedData) {
    int index = allFabricPurchases
        .indexWhere((element) => element.fabricpurchaseId == id);
    if (index != -1) {
      allFabricPurchases[index] = updatedData;
      int cacheIndex =
          cachedForex.indexWhere((element) => element.fabricpurchaseId == id);
      if (cacheIndex != -1) {
        cachedForex[cacheIndex] = updatedData; // Update cache
      }
      int searchIndex = searchAllFabricPurchases
          .indexWhere((element) => element.fabricpurchaseId == id);
      if (searchIndex != -1) {
        searchAllFabricPurchases[searchIndex] =
            updatedData; // Update search list
      }
      notifyListeners();
    }
  }

  Future<void> deleteFabricPurchase(int id) async {
    _helperServices.showLoader();
    try {
      final response = await AllFabricPurchasesApiServiceProvider()
          .deleteFabricPurchase('deleteKhalidPurchase?fabricpurchase_id=$id');
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
    allFabricPurchases.removeWhere((element) => element.fabricpurchaseId == id);
    cachedForex.removeWhere((element) => element.fabricpurchaseId == id);
    searchAllFabricPurchases
        .removeWhere((element) => element.fabricpurchaseId == id);
    notifyListeners();
  }

  searchAllFabricPurchasesMethod(String name) {
    searchText = name;
    updateAllFabricPurchasesMarkaData();
  }

  void updateAllFabricPurchasesMarkaData() {
    searchAllFabricPurchases.clear();
    if (searchText.isEmpty) {
      searchAllFabricPurchases.addAll(cachedForex);
    } else {
      searchAllFabricPurchases.addAll(
        cachedForex
            .where(
              (element) =>
                  (element.bundle
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.meter
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.war
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.yenprice
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.yenexchange
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.ttcommission
                          ?.toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.packagephoto?.toLowerCase().contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.bankreceiptphoto
                          ?.toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                      false) ||
                  (element.date?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
                  (element.fabricpurchasecode?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
                  (element.dollerprice?.toString().toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
                  (element.totalyenprice?.toString().toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
                  (element.totaldollerprice?.toString().toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
                  (element.status?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
                  (element.vendorcompany?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
                  (element.marka?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
                  (element.fabricName?.toLowerCase().contains(searchText.toLowerCase()) ?? false),
            )
            .toList(),
      );
    }
    notifyListeners();
  }

  @override
  void dispose() {
    selectedCompanyIdController.dispose();
    abrController.dispose();
    selectedCompanyNameController.dispose();
    selectedFabricNameController.dispose();
    selectedFabricIdController.dispose();
    amountOfBundlesController.dispose();
    amountOfMetersController.dispose();
    amountOfWarsController.dispose();
    yenPriceController.dispose();
    totalYenPriceController.dispose();
    exchangeRateController.dispose();
    dollarPriceController.dispose();
    totalDollarPriceController.dispose();
    ttCommissionController.dispose();
    packagePhotoController.dispose();
    bankReceivedPhotoController.dispose();
    dateController.dispose();
    fabricCodeController.dispose();
    selectedVendorCompanyId.dispose();
    selectedVendorCompanyName.dispose();
    selectedTransportName.dispose();
    selectedTransportId.dispose();
    super.dispose();
  }

  void clearAllControllers() {
    selectedCompanyIdController.clear();
    abrController.clear();
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
    selectedTransportName.clear();
    selectedTransportId.clear();
  }

  void resetSearchFilter() {
    searchText = '';
    updateAllFabricPurchasesMarkaData();
  }
}
