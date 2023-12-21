import 'package:fabricproject/api/sarai_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/sarai_model.dart';
import 'package:fabricproject/screens/sarai/sarai_edit_screen.dart';
import 'package:fabricproject/screens/sarai/sarai_create_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class SaraiController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  // TextEditingController userController = TextEditingController();
  List<Data>? allSarais = [];
  List<Data>? searchSarais = [];
  String searchText = "";

  SaraiController(this._helperServices) {
    getAllSarais();
  }
  navigateToSaraiCreate() {
    _helperServices.navigate(const SaraiCreateScreen());
  }

  navigateToSaraiEdit(Data data, int id) {
    nameController.text = data.name.toString();
    descriptionController.text = data.description.toString();
    phoneController.text = data.phone.toString();
    locationController.text = data.location.toString();
    _helperServices.navigate(
      SaraiEditScreen(
        saraiData: data,
        saraiId: id,
      ),
    );
  }

  getAllSarais() async {
    _helperServices.showLoader();
    final response = await SaraiApiServiceProvider().getSarai('getSarai');
    response.fold(
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) {
        allSarais = r;
        _helperServices.goBack();
        updateSaraisData();
      },
    );
  }

  createSarai() async {
    _helperServices.showLoader();

    var response = await SaraiApiServiceProvider().createSarai(
      'add-sarai',
      {
        "sarai_id": 0,
        "name": nameController.text,
        "description": descriptionController.text,
        "phone": phoneController.text,
        "location": locationController.text,
      },
    );
    response.fold(
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) => {
        getAllSarais(),
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
        descriptionController.clear(),
        phoneController.clear(),
        locationController.clear(),
      },
    );
  }

  editSarai(int id) async {
    _helperServices.showLoader();
    var response = await SaraiApiServiceProvider().editSarai(
      'update-sarai?sarai_id=$id',
      {
        "sarai_id": id,
        "name": nameController.text,
        "description": descriptionController.text,
        "phone": phoneController.text,
        "location": locationController.text,
      },
    );
    response.fold(
      (l) => {_helperServices.goBack(), _helperServices.showErrorMessage(l)},
      (r) => {
        getAllSarais(),
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
        descriptionController.clear(),
        phoneController.clear(),
        locationController.clear(),
      },
    );
  }

  deleteSarai(id, index) async {
    _helperServices.showLoader();
    var response = await SaraiApiServiceProvider()
        .deleteSarai('delete-sarai?sarai_id=$id');
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
            searchSarais!.removeAt(index),
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

  searchSarisMethod(String name) {
    searchText = name;
    updateSaraisData();
  }

  updateSaraisData() {
    searchSarais?.clear();
    if (searchText.isEmpty) {
      searchSarais?.addAll(allSarais!);
    } else {
      searchSarais?.addAll(
        allSarais!
            .where(
              (element) =>
                  element.name!.toLowerCase().contains(searchText) ||
                  element.description!.toLowerCase().contains(searchText) ||
                  element.phone!.toLowerCase().contains(searchText) ||
                  element.location!.toLowerCase().contains(searchText),
            )
            .toList(),
      );
    }
    notifyListeners();
  }
}
