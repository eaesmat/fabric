import 'dart:convert';
import 'package:fabricproject/api/sarai_item_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/sarai_item_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class SaraiItemController extends ChangeNotifier {
  final HelperServices _helperServices;

  TextEditingController fabricNameController = TextEditingController();
  TextEditingController indateController = TextEditingController();
  TextEditingController totalBundleController = TextEditingController();
  TextEditingController fabricIdController = TextEditingController();
  TextEditingController saraiIdController = TextEditingController();
  TextEditingController outBundleController = TextEditingController();
  TextEditingController inBundleController = TextEditingController();

  List<Data>? allSaraiItems = [];
  List<Data>? searchSaraiItems = [];
  String searchText = "";

  SaraiItemController(this._helperServices);

  getAllSaraiItems(int saraiId) async {
    _helperServices.showLoader();
    final response = await SaraiItemApiServiceProvider().getSaraiItem('getSaraiItem?sarai_id=$saraiId');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
      },
      (r) {
        allSaraiItems = r;
        _helperServices.goBack();
        searchSaraiItems?.clear();
        searchSaraiItems?.addAll(allSaraiItems!);
        notifyListeners();
      },
    );
  }

  searchSaraiItemMethod(String name) {
    searchText = name;
    updateSaraiItemData();
  }

  updateSaraiItemData() {
    searchSaraiItems?.clear();
    if (searchText.isEmpty) {
      searchSaraiItems?.addAll(allSaraiItems!);
    } else {
      searchSaraiItems?.addAll(
        allSaraiItems!
            .where((element) =>
                element.name!.toLowerCase().contains(searchText) ||
                element.indate!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  void resetSearchFilter() {
    searchText = '';
    updateSaraiItemData();
  }
}
