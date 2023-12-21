import 'package:fabricproject/api/transport_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/transport_model.dart';
import 'package:fabricproject/screens/transport/transport_create_screen.dart';
import 'package:fabricproject/screens/transport/transport_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class TransportController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController desorptionController = TextEditingController();
  // TextEditingController userController = TextEditingController();
  List<Data>? allTransports = [];
  List<Data>? searchTransports = [];
  String searchText = "";

  TransportController(this._helperServices) {
    getAllTransports();
  }
  navigateToTransportCreate() {
    _helperServices.navigate(const TransportCreateScreen());
  }

  navigateToTransportEdit(Data data, int id) {
    nameController.text = data.name.toString();
    phoneController.text = data.phone.toString();
    desorptionController.text = data.description.toString();
    _helperServices.navigate(
      TransportEditScreen(transportData: data, transportId: id),
    );
  }

  getAllTransports() async {
    _helperServices.showLoader();
    final response =
        await TransportApiServiceProvider().getTransport('getTransport');
    response.fold(
        (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
        (r) {
      allTransports = r;
      _helperServices.goBack();
      updateTransportsData();
    });
  }

  createTransport() async {
    print("create trnsport controller");

    _helperServices.showLoader();

    var response = await TransportApiServiceProvider().createTransport(
      'add-transport',
      {
        "transport_id": 0,
        "name": nameController.text,
        "phone": phoneController.text,
        "description": desorptionController.text,
      },
    );
    response.fold(
        (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
        (r) => {
              getAllTransports(),
              _helperServices.goBack(),
              _helperServices.showMessage(
                const LocaleText('added'),
                Colors.green,
                const Icon(
                  Icons.check,
                  color: Pallete.whiteColor,
                ),
              ),
              nameController.clear(),
              phoneController.clear(),
              desorptionController.clear(),
            });
  }

  editTransport(int id) async {
    _helperServices.showLoader();

    var response = await TransportApiServiceProvider().editTransport(
      'update-transport?transport_id=$id',
      {
        "transport_id": id,
        "name": nameController.text,
        "phone": phoneController.text,
        "description": desorptionController.text,
      },
    );
    response.fold(
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) => {
        getAllTransports(),
        _helperServices.goBack(),
        _helperServices.showMessage(
          const LocaleText('updated'),
          Colors.green,
          const Icon(
            Icons.edit_note_outlined,
            color: Pallete.whiteColor,
          ),
        ),
        nameController.clear(),
        phoneController.clear(),
        desorptionController.clear(),
      },
    );
  }

  deleteTransport(id, index) async {
    _helperServices.showLoader();
    var response = await TransportApiServiceProvider()
        .deleteTransport('delete-transport?transport_id=$id');
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
            searchTransports!.removeAt(index),
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

  searchTransportsMethod(String name) {
    searchText = name;
    updateTransportsData();
  }

  updateTransportsData() {
    searchTransports?.clear();
    if (searchText.isEmpty) {
      searchTransports?.addAll(allTransports!);
    } else {
      searchTransports?.addAll(
        allTransports!
            .where((element) =>
                element.name!.toLowerCase().contains(searchText) ||
                element.phone!.toLowerCase().contains(searchText) ||
                element.description!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }
}
