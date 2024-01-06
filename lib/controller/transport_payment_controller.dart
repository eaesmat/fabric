import 'package:fabricproject/api/transport_payment_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/transport_payment._model.dart';
import 'package:fabricproject/screens/transport_payment/transport_payment_create_screen.dart';
import 'package:fabricproject/screens/transport_payment/transport_payment_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class TransportPaymentController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController dateOneController = TextEditingController();
  TextEditingController dateTwoController = TextEditingController();
  TextEditingController personController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  int? transportId;
  List<Data>? allTransportPayment = [];
  List<Data>? searchTransportPayment = [];
  String searchText = "";
  double sumOfTotalTransportPaymentAmount = 0;

  TransportPaymentController(
    this._helperServices,
  ) {
    getAllTransportPayment(transportId);
  }

  navigateToTransportPaymentCreate() {
    clearAllControllers();

    _helperServices.navigate(
      const TransportPaymentCreateScreen(),
    );
  }

  navigateToTransportPaymentEdit(Data data, int id) {
    clearAllControllers();
    dateOneController.text = data.date1.toString();
    dateTwoController.text = data.date2.toString();
    personController.text = data.person.toString();
    amountController.text = data.amount.toString();

    _helperServices.navigate(
      TransportPaymentEditScreen(
        transportPaymentData: data,
        transportPaymentId: id,
      ),
    );
  }

  navigateToTransportDealDetailsScreen(String transportName, int id) async {
    clearAllControllers();
    transportId = id;
    await getAllTransportPayment(transportId);
  }

  createTransportPayment() async {
    _helperServices.showLoader();

    var response =
        await TransportPaymentApiServiceProvider().createTransportPayment(
      'add-transport-payment',
      {
        "transportpayment_id": 0,
        "date1": dateOneController.text,
        "date2": null,
        "person": personController.text,
        "amount": amountController.text,
        "transport_id": transportId.toString(),
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
        getAllTransportPayment(transportId!);
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

  editTransportPayment(int transportPaymentId) async {
    _helperServices.showLoader();

    var response =
        await TransportPaymentApiServiceProvider().editTransportPayment(
      'update-transport-payment?transportpayment_id=$transportPaymentId',
      {
        "transportpayment_id": transportPaymentId,
        "date1": dateOneController.text,
        "date2": null,
        "person": personController.text,
        "amount": amountController.text,
        "transport_id": transportId.toString(),
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
        getAllTransportPayment(transportId!);
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
    final index = allTransportPayment!
        .indexWhere((element) => element.transportpaymentId == id);
    if (index != -1) {
      allTransportPayment!.removeAt(index);

      final searchIndex = searchTransportPayment!
          .indexWhere((element) => element.transportpaymentId == id);
      if (searchIndex != -1) {
        searchTransportPayment!.removeAt(searchIndex);
      }

      notifyListeners();
    }
  }

  deleteTransportPayment(id, index) async {
    _helperServices.showLoader();
    var response = await TransportPaymentApiServiceProvider()
        .deleteTransportPayment(
            'delete-transport-payment?transportpayment_id=$id');
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

  getAllTransportPayment(int? transportId) async {
    _helperServices.showLoader();
    final response = await TransportPaymentApiServiceProvider()
        .getTransportPayment('getTransportPayment');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) {
        allTransportPayment = r
            .where((transportPayment) =>
                transportPayment.transportId == transportId)
            .toList();
        searchTransportPayment?.clear();
        searchTransportPayment?.addAll(allTransportPayment!);

        sumOfTotalTransportPaymentAmount =
            calculateSumOfTotalAmount(allTransportPayment);
        print("amount");
        print(sumOfTotalTransportPaymentAmount);
        _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  double calculateSumOfTotalAmount(List<Data>? transportPayments) {
    double sum = 0;

    if (transportPayments != null) {
      for (var transportPayment in transportPayments) {
        // Replace 'amount' with the actual field name from your FabricPurchase model
        sum += transportPayment.amount ?? 0; // Add the 'amount' to the sum
      }
    }
    return sum;
  }

  searchTransportPaymentMethod(String text) {
    searchText = text;
    updateTransportPayment();
  }

  updateTransportPayment() {
    searchTransportPayment?.clear();
    if (searchText.isEmpty) {
      searchTransportPayment?.addAll(allTransportPayment!);
    } else {
      searchTransportPayment?.addAll(
        allTransportPayment!
            .where((element) =>
                element.date1!.toLowerCase().contains(searchText) ||
                element.date1!.toLowerCase().contains(searchText) ||
                element.person!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    searchText = '';
    updateTransportPayment();
  }

  void clearAllControllers() {
    dateOneController.clear();
    dateTwoController.clear();
    personController.clear();
    amountController.clear();
  }
}
