import 'package:fabricproject/api/container_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/container_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class ContainerController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController nameController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController transportDealController = TextEditingController();
  TextEditingController desorptionController = TextEditingController();
  List<Data>? allContainers;
  List<Data> searchContainers = [];
  String searchText = "";

  ContainerController(
    this._helperServices,
  );

  // navigateToContainerCreate() {
  //   clearAllController();
  //   _helperServices.navigate(const ContainerCreateScreen());
  // }

  getAllContainers(transportDealId) async {
    // _helperServices.showLoader();
    final response =
        await ContainerApiServiceProvider().getContainer('getContainer');
    response.fold(
      (l) {
        // _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        allContainers = r
            .where((container) => container.transportdealId == transportDealId)
            .toList();
        searchContainers.clear();
        searchContainers.addAll(allContainers!);
        // _helperServices.goBack();
        print("data");
        print(searchContainers);
        notifyListeners();
      },
    );
  }

  createContainer() async {
    // _helperServices.showLoader();

    var response = await ContainerApiServiceProvider().createContainer(
      'add-container',
      {
        "container_id": 0,
        "name": nameController.text,
        "description": desorptionController.text.isEmpty
            ? null
            : desorptionController.text,
        "status": statusController.text.isEmpty ? null : statusController.text,
        "transportdeal_id": transportDealController.text,
      },
    );
    response.fold(
      (l) {
        // _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        // _helperServices.goBack();
        clearAllController();
      },
    );
  }

  editContainer(int containerId) async {

    // _helperServices.showLoader();

    var response = await ContainerApiServiceProvider().editContainer(
      'update-container?container_id=$containerId',
      {
        "container_id": containerId,
        "name": nameController.text.isEmpty ? "" : nameController.text,
        "description":
            desorptionController.text.isEmpty ? "" : desorptionController.text,
        "status": statusController.text.isEmpty ? "" : statusController.text,
        "transportdeal_id": transportDealController.text,
      },
    );
    response.fold(
      (l) {
        // _helperServices.goBack();
        _helperServices.showErrorMessage(l);
        print("container error");
      },
      (r) {
        // _helperServices.goBack();
        clearAllController();
        print("container success");
      },
    );
  }

  void deleteItemLocally(int id) {
    final index =
        allContainers!.indexWhere((element) => element.containerId == id);
    if (index != -1) {
      allContainers!.removeAt(index);
      final searchIndex =
          searchContainers.indexWhere((element) => element.containerId == id);
      if (searchIndex != -1) {
        searchContainers.removeAt(searchIndex);
      }
      notifyListeners();
    }
  }

  deleteContainer(id, index) async {
    _helperServices.showLoader();
    var response = await ContainerApiServiceProvider()
        .deleteContainer('delete-container?container_id=$id');
    _helperServices.goBack();
    response.fold(
      (l) {
        _helperServices.goBack();
        _helperServices.showErrorMessage(l);
      },
      (r) {
        if (r == 200) {
          _helperServices.showMessage(
            const LocaleText('deleted'),
            Colors.red,
            const Icon(
              Icons.close,
              color: Pallete.whiteColor,
            ),
          );
          deleteItemLocally(id);
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
  }

  searchContainerMethod(String name) {
    searchText = name;
    updateContainersData();
  }

  updateContainersData() {
    searchContainers.clear();
    if (searchText.isEmpty) {
      searchContainers.addAll(allContainers!);
    } else {
      searchContainers.addAll(
        allContainers!
            .where((element) =>
                element.name!.toLowerCase().contains(searchText) ||
                element.status!.toLowerCase().contains(searchText) ||
                element.description!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  void resetSearchFilter() {
    searchText = '';
    updateContainersData();
  }

  void clearAllController() {
    nameController.clear();
    statusController.clear();
    desorptionController.clear();
  }
}
