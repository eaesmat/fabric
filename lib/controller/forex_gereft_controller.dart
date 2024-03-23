import 'package:fabricproject/api/forex_gereft_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/forex_gereft_model.dart';
import 'package:fabricproject/screens/forex_gereft/forex_gereft_create_screen.dart';
import 'package:fabricproject/screens/forex_gereft/forex_gereft_details_screen.dart';
import 'package:fabricproject/screens/forex_gereft/khalid_gereft_edit_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class ForexGereftController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController dateController = TextEditingController();
  TextEditingController selectedUserIdController = TextEditingController();
  TextEditingController selectedUserNameController = TextEditingController();
  TextEditingController dollarPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<Data> allForexGerefts = [];
  List<Data> searchForexGerefts = [];
  List<Data> cachedForexGerefts = [];
  String searchText = "";

  int? forexId = 0;

  ForexGereftController(
    this._helperServices,
  );

  navigateToForexGereftListScreen(int? forexId, String? forexName) async {
    clearAllControllers();
    _helperServices.navigate(
      ForexGereftDetailsScreen(
        forexId: forexId!,
        forexName: forexName!,
      ),
    );

    await getAllForexGerefts(forexId);
    this.forexId = forexId;
  }

  navigateToForexGereftCreate() {
    clearAllControllers();

    _helperServices.navigate(
      const ForexGereftCreateScreen(),
    );
  }

  navigateToForexGereftEdit(Data data, int gereftId) {
    clearAllControllers();

    descriptionController.text = data.description.toString();
    dateController.text = data.date.toString();
    dollarPriceController.text = data.doller.toString();
    selectedUserIdController.text = data.byPersonId.toString();
    selectedUserNameController.text = data.byPerson.toString();

    _helperServices.navigate(ForexGereftEditScreen(
      data: data,
      gereftId: gereftId,
    ));
  }

  Future<void> createForexGereft() async {
    _helperServices.showLoader();
    try {
      var response = await ForexGereftApiServiceProvider().createForexGereft(
        'add-greft-sarafi',
        {
          "sarafi_id": forexId,
          "description": descriptionController.text,
          "date": dateController.text,
          "doller": dollarPriceController.text,
          "user_id": selectedUserIdController.text,
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
            getAllForexGerefts(forexId!);
          }
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  Future<void> editForexGereft(int id) async {
    _helperServices.showLoader();

    try {
      final response = await ForexGereftApiServiceProvider().editForexGereft(
        'update-greft-sarafi?deposit_id=$id',
        {
          "description": descriptionController.text,
          "date": dateController.text,
          "doller": dollarPriceController.text,
          "user_id": selectedUserIdController.text,
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

          updateKhalidGerefLocally(
            id,
            Data(
              depositId: id,
              byPerson: selectedUserNameController.text,
              doller: double.tryParse(dollarPriceController.text),
              description: descriptionController.text,
              byPersonId: int.tryParse(selectedUserIdController.text),
              date: dateController.text,
            ),
          );
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  void updateKhalidGerefLocally(int id, Data updatedData) {
    int index =
        allForexGerefts.indexWhere((element) => element.depositId == id);
    if (index != -1) {
      allForexGerefts[index] = updatedData;
      int cacheIndex =
          cachedForexGerefts.indexWhere((element) => element.depositId == id);
      if (cacheIndex != -1) {
        cachedForexGerefts[cacheIndex] = updatedData; // Update cache
      }
      int searchIndex =
          searchForexGerefts.indexWhere((element) => element.depositId == id);
      if (searchIndex != -1) {
        searchForexGerefts[searchIndex] = updatedData; // Update search list
      }
      notifyListeners();
    }
  }

  Future<void> deleteForexGereft(int id) async {
    _helperServices.showLoader();
    try {
      final response = await ForexGereftApiServiceProvider()
          .deleteForexGereft('delete-greft-sarafi?deposit_id=$id');
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
    allForexGerefts.removeWhere((element) => element.depositId == id);
    cachedForexGerefts.removeWhere((element) => element.depositId == id);
    searchForexGerefts.removeWhere((element) => element.depositId == id);
    notifyListeners();
  }

  Future<void> getAllForexGerefts(int forexId) async {
    _helperServices.showLoader();
    try {
      final response = await ForexGereftApiServiceProvider()
          .getForexGereft('loadGreftSarafi?sarafi_id=$forexId');
      response.fold(
        (l) {
          _helperServices.goBack();
          _helperServices.showErrorMessage(l);
        },
        (r) {
          allForexGerefts = r;
          searchForexGerefts = List.from(allForexGerefts);
          cachedForexGerefts = List.from(allForexGerefts);
          _helperServices.goBack();
          notifyListeners();
        },
      );
    } catch (e) {
      _helperServices.goBack();
      _helperServices.showErrorMessage(e.toString());
    }
  }

  searchForexGereftsMethod(String name) {
    searchText = name;
    updateForexGereftData();
  }

  void updateForexGereftData() {
    searchForexGerefts.clear();
    if (searchText.isEmpty) {
      searchForexGerefts.addAll(cachedForexGerefts);
    } else {
      searchForexGerefts.addAll(
        cachedForexGerefts
            .where((element) =>
                (element.date
                        ?.toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.doller
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.description
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false) ||
                (element.byPerson
                        ?.toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false))
            .toList(),
      );
    }
    notifyListeners();
  }

  void clearAllControllers() {
    dateController.clear();
    dollarPriceController.clear();
    selectedUserIdController.clear();
    selectedUserNameController.clear();
    descriptionController.clear();
  }

  void resetSearchFilter() {
    searchText = '';
    updateForexGereftData();
  }
}
