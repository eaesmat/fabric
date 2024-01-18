import 'package:fabricproject/api/customer_payment_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/customer_payment_model.dart';
import 'package:fabricproject/screens/customer_payment/customer_payment_create_screen.dart';
import 'package:fabricproject/screens/customer_payment/customer_payment_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class CustomerPaymentController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController personController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountDollarController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController amountAfghaniController = TextEditingController();

  int? customerId;
  List<Data>? allCustomersPayments = [];
  List<Data>? searchCustomersPayments = [];
  String searchText = "";

  CustomerPaymentController(
    this._helperServices,
  ) {
    getAllCustomerPayments(customerId);
  }

  navigateToCustomerPaymentCreate() {
    clearAllControllers();

    _helperServices.navigate(const CustomerPaymentCreateScreen());
  }

  navigateToCustomerPaymentEdit(int customerPaymentId, Data data) async {
    clearAllControllers();
    amountDollarController.text = data.amountdollar.toString();
    amountAfghaniController.text = data.amountafghani.toString();
    personController.text = data.person.toString();
    descriptionController.text = data.description.toString();
    dateController.text = data.date.toString();

    _helperServices.navigate(
      CustomerPaymentEditScreen(
          customerPaymentData: data, customerPaymentId: customerPaymentId),
    );
  }

  navigateToCustomerPaymentDetailsScreen(String customerName, int id) async {
    clearAllControllers();
    customerId = id;

    await getAllCustomerPayments(
        customerId); // Wait for getAllFabricPurchases to complete
  }

  getAllCustomerPayments(int? customerId) async {
    _helperServices.showLoader();
    final response = await CustomerPaymentApiServiceProvider()
        .getCustomerPayment('getCustomerPayment');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) {
        allCustomersPayments = r
            .where(
                (customerPayment) => customerPayment.customerId == customerId)
            .toList();
        searchCustomersPayments?.clear();
        searchCustomersPayments?.addAll(allCustomersPayments!);

        _helperServices.goBack();
        notifyListeners();
      },
    );
  }

  createCustomerPayment() async {
    _helperServices.showLoader();

    var response =
        await CustomerPaymentApiServiceProvider().createCustomerPayment(
      'add-customer-payment',
      {
        "customerpayment_id": 0,
        "date": dateController.text,
        "person": personController.text,
        "description": descriptionController.text,
        "amountdollar": amountDollarController.text,
        "customer_id": customerId.toString(),
        "user_id": 1,
        "amountafghani": amountAfghaniController.text,
      },
    );
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        getAllCustomerPayments(customerId!);
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

  editCustomerPayment(int customerPaymentId) async {
    _helperServices.showLoader();

    var response =
        await CustomerPaymentApiServiceProvider().editCustomerPayment(
      'update-customer-payment?$customerPaymentId',
      {
        "customerpayment_id": customerPaymentId,
        "date": dateController.text,
        "person": personController.text,
        "description": descriptionController.text,
        "amountdollar": amountDollarController.text,
        "customer_id": customerId.toString(),
        "user_id": 1,
        "amountafghani": amountAfghaniController.text,
      },
    );
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        getAllCustomerPayments(customerId);
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

  deleteCustomerDeal(id, index) async {
    _helperServices.showLoader();
    var response = await CustomerPaymentApiServiceProvider()
        .deleteCustomerPayment(
            'delete-customer-payment?customerpayment_id=$id');
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
            searchCustomersPayments!.removeAt(index),
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

  searchCustomerPaymentMethod(String name) {
    searchText = name;
    updateCustomerPaymentData();
  }

  updateCustomerPaymentData() {
    searchCustomersPayments?.clear();

    if (searchText.isEmpty) {
      searchCustomersPayments?.addAll(allCustomersPayments!);
    } else {
      searchCustomersPayments?.addAll(
        allCustomersPayments!
            .where((element) =>
                element.person.toString().toLowerCase().contains(searchText) ||
                element.description
                    .toString()
                    .toLowerCase()
                    .contains(searchText) ||
                element.amountdollar
                    .toString()
                    .toLowerCase()
                    .contains(searchText) ||
                element.amountafghani
                    .toString()
                    .toLowerCase()
                    .contains(searchText) ||
                element.date!.toLowerCase().contains(searchText))
            // element.!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  // Reset the search text
  void resetSearchFilter() {
    searchText = '';
    updateCustomerPaymentData();
  }

  void clearAllControllers() {
    personController.clear();
    descriptionController.clear();
    amountAfghaniController.clear();
    amountDollarController.clear();
    dateController.clear();
  }
}
