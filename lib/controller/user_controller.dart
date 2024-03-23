import 'package:fabricproject/api/user_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/user_model.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final HelperServices _helperServices;

  List<Data> allUsers = [];
  List<Data> searchUsers = [];
  String searchText = "";

  // Cached data to avoid unnecessary API calls
  List<Data> cachedUsers = [];

  UserController(this._helperServices) {
    getAllUsers();
  }

  Future<void> getAllUsers() async {
    _helperServices.showLoader();
    try {
      final response = await UserApiServiceProvider()
          .getUser('getUser');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allUsers = r;
          searchUsers = List.from(allUsers);
          cachedUsers =
              List.from(allUsers); // Cache initial data
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void searchUsersMethod(String text) {
    searchText = text;
    updateUserData();
  }

void updateUserData() {
  searchUsers.clear();
  if (searchText.isEmpty) {
    searchUsers.addAll(cachedUsers);
  } else {
    searchUsers.addAll(
      cachedUsers.where(
        (element) =>
          (element.username?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.name?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.surname?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.address?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.dob?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.email?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.privilage?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.status?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.purchase?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.system?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.transport?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.stock?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.customers?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.sarafi?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.dues?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.phone?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.sales?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.manager?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.reports?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.sarai?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.mazar?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.thirdfloor?.toLowerCase().contains(searchText.toLowerCase()) ?? false) ||
          (element.firstfloor?.toLowerCase().contains(searchText.toLowerCase()) ?? false),
      ).toList(),
    );
  }
  notifyListeners();
}


  void resetSearchFilter() {
    searchText = '';
    updateUserData();
  }
}
