import 'package:fabricproject/api/fabric_purchase_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/fabric_purchase_model.dart';
import 'package:fabricproject/screens/fabric_purchase/fabric_purchase_create_screen.dart';
import 'package:fabricproject/screens/fabric_purchase/fabric_purchase_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/screens/vendor_company/vendor_company_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class FabricPurchaseController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController vendorCompanyNameController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController selectedCompany = TextEditingController();
  TextEditingController selectedFabric = TextEditingController();
  TextEditingController fabricController = TextEditingController();
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

  int? vendorCompanyId;
  double sumOfFabricPurchaseTotalDollar =
      0; // Variable to hold the sum of the 'amount' column
  double sumOfFabricPurchaseTotalYen =
      0; // Variable to hold the sum of the 'amount' column

  List<Data>? allFabricPurchases = [];
  List<Data>? searchFabricPurchases = [];
  String searchText = "";

  FabricPurchaseController(
    this._helperServices,
  ) {
    getAllFabricPurchases(vendorCompanyId);
  }

  navigateToFabricPurchaseCreate() {
    clearAllControllers();
    _helperServices.navigate(const FabricPurchaseCreateScreen());
  }

  navigateToFabricPurchaseEdit(Data data, int id) {
    clearAllControllers();

    companyController.text = data.companyId.toString();
    fabricController.text = data.fabricId.toString();
    selectedFabric.text = ("${data.fabric!.name!},   ${data.fabric!.abr!}");
    selectedCompany.text =
        ("${data.company!.name!},   ${data.company!.marka!}");
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
    _helperServices.navigate(FabricPurchaseEditScreen(
      fabricPurchaseData: data,
      fabricPurchaseId: id,
    ));
  }

  navigateToVendorCompanyDetails(String vendorCompanyName, int id) async {
    clearAllControllers();
    vendorCompanyId = id; // Update the vendorCompanyId immediately

    _helperServices.navigate(
      VendorCompanyDetailsListScreen(
        vendorCompanyId: id,
        vendorCompanyName: vendorCompanyName,
      ),
    );
    print("the id $id");

    await getAllFabricPurchases(
        vendorCompanyId); // Wait for getAllFabricPurchases to complete
  }

  getAllFabricPurchases(int? vendorCompanyId) async {
    _helperServices.showLoader();
    final response = await FabricPurchaseApiServiceProvider()
        .getFabricPurchase('getFabricPurchase');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) {
        allFabricPurchases = r
            .where((fabricPurchase) =>
                fabricPurchase.vendorcompanyId == vendorCompanyId)
            .toList();
        searchFabricPurchases?.clear();
        searchFabricPurchases?.addAll(allFabricPurchases!);
        // Calculate the sum of the 'amount' column

        sumOfFabricPurchaseTotalDollar =
            calculateSumOfTotalDollar(allFabricPurchases);
        sumOfFabricPurchaseTotalYen =
            calculateSumOfTotalYen(allFabricPurchases);
        _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  // Function to calculate the sum of the 'amount' column from the list of FabricPurchases
  // Function to calculate the sum of the 'amount' column from the list of FabricPurchases
  double calculateSumOfTotalDollar(List<Data>? fabricPurchases) {
    double sum = 0;

    if (fabricPurchases != null) {
      for (var fabricPurchase in fabricPurchases) {
        // Replace 'amount' with the actual field name from your FabricPurchase model
        sum +=
            fabricPurchase.totaldollerprice ?? 0; // Add the 'amount' to the sum
      }
    }
    return sum;
  }

  double calculateSumOfTotalYen(List<Data>? fabricPurchases) {
    double sum = 0;

    if (fabricPurchases != null) {
      for (var fabricPurchase in fabricPurchases) {
        // Replace 'amount' with the actual field name from your FabricPurchase model
        sum += fabricPurchase.totalyenprice ?? 0; // Add the 'amount' to the sum
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
        "fabric_id": fabricController.text,
        "company_id": companyController.text,
        "vendorcompany_id":
            vendorCompanyId.toString(), // Use vendorCompanyId directly
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
        getAllFabricPurchases(vendorCompanyId!);
        print(" createMethod all the vendor id $vendorCompanyId");

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
        "fabric_id": fabricController.text,
        "company_id": companyController.text,
        "vendorcompany_id":
            vendorCompanyId.toString(), // Use vendorCompanyId directly
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
        getAllFabricPurchases(vendorCompanyId!);
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
            searchFabricPurchases!.removeAt(index),
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
                element.date!.toLowerCase().contains(searchText))
            // element.!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  void clearAllControllers() {
    vendorCompanyNameController.clear();
    companyController.clear();
    selectedCompany.clear();
    selectedFabric.clear();
    fabricController.clear();
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
  }
}
