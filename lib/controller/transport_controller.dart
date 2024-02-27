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
  TextEditingController descriptionController = TextEditingController();

  List<Data> allTransports = [];
  List<Data> searchTransports = [];
  List<Data> cachedTransports = [];
  String searchText = "";

  TransportController(this._helperServices) {
    getAllTransports();
  }

  navigateToTransportCreate() {
    clearAllControllers();
    _helperServices.navigate(const TransportCreateScreen());
  }

  navigateToTransportEdit(Data data, int id) {
    clearAllControllers();
    nameController.text = data.name ?? '';
    phoneController.text = data.phone ?? '';
    descriptionController.text = data.description ?? '';
    _helperServices.navigate(
      TransportEditScreen(transportData: data, transportId: id),
    );
  }

  Future<void> getAllTransports() async {
    _helperServices.showLoader();
    try {
      final response =
          await TransportApiServiceProvider().getTransport('getTransport');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allTransports = r;
          searchTransports = List.from(allTransports);
          cachedTransports = List.from(allTransports); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> createTransport() async {
    _helperServices.showLoader();
    try {
      var response = await TransportApiServiceProvider().createTransport(
        'add-transport',
        {
          "transport_id": 0,
          "name": nameController.text,
          "phone": phoneController.text,
          "description": descriptionController.text,
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
            getAllTransports();
          }
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> editTransport(int id) async {
    _helperServices.showLoader();
    try {
      var response = await TransportApiServiceProvider().editTransport(
        'update-transport?transport_id=$id',
        {
          "transport_id": id,
          "name": nameController.text,
          "phone": phoneController.text,
          "description": descriptionController.text,
        },
      );
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

          updateTransportLocally(
            id,
            Data(
              transportId: id,
              name: nameController.text,
              description: descriptionController.text,
              phone: phoneController.text,
            ),
          );
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void updateTransportLocally(int id, Data updatedData) {
    int index =
        allTransports.indexWhere((element) => element.transportId == id);
    if (index != -1) {
      allTransports[index] = updatedData;
      int cacheIndex =
          cachedTransports.indexWhere((element) => element.transportId == id);
      if (cacheIndex != -1) {
        cachedTransports[cacheIndex] = updatedData; // Update cache
      }
      int searchIndex =
          searchTransports.indexWhere((element) => element.transportId == id);
      if (searchIndex != -1) {
        searchTransports[searchIndex] = updatedData; // Update search list
      }
      notifyListeners();
    }
  }

  Future<void> deleteTransport(int id) async {
    _helperServices.showLoader();
    try {
      final response = await TransportApiServiceProvider()
          .deleteTransport('delete-transport?transport_id=$id');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          _helperServices.goBack();
          if (r == 200) {
            deleteTransportLocally(id);
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

  void searchTransportsMethod(String name) {
    searchText = name;
    updateTransportsData();
  }

  void updateTransportsData() {
    searchTransports.clear();
    if (searchText.isEmpty) {
      searchTransports.addAll(allTransports);
    } else {
      searchTransports.addAll(
        allTransports.where(
          (element) =>
              (element.name
                      ?.toLowerCase()
                      .contains(searchText.toLowerCase()) ??
                  false) ||
              (element.phone
                      ?.toLowerCase()
                      .contains(searchText.toLowerCase()) ??
                  false) ||
              (element.description
                      ?.toLowerCase()
                      .contains(searchText.toLowerCase()) ??
                  false),
        ),
      );
    }
    notifyListeners();
  }

  void resetSearchFilter() {
    searchText = '';
    updateTransportsData();
  }

  void deleteTransportLocally(int id) {
    allTransports.removeWhere((element) => element.transportId == id);
    searchTransports.removeWhere((element) => element.transportId == id);
    notifyListeners();
  }

  void clearAllControllers() {
    nameController.clear();
    phoneController.clear();
    descriptionController.clear();
  }
}
