import 'package:fabricproject/api/sarain_in_deal_api.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/model/sarai_in_deal_model.dart';
import 'package:flutter/material.dart';

class SaraiInDealController extends ChangeNotifier {
  final HelperServices _helperServices;
  TextEditingController inDateController = TextEditingController();
  TextEditingController transportDealIdController = TextEditingController();
  TextEditingController saraiFrom = TextEditingController();
  TextEditingController saraiIdController = TextEditingController();

  List<Data>? allSaraiInDeal = [];
  List<Data>? searchSaraiInDeal = [];
  String searchText = "";

  SaraiInDealController(
    this._helperServices,
  ) {
    // getAllSaraiInDeal();
  }

  // navigateToDrawCreate() {
  //   clearAllControllers();

  //   _helperServices.navigate(const DrawCreateScreen());
  // }

  // navigateToDrawEdit(Data data, int id) {
  //   clearAllControllers();

  //   selectedForexController.text = ("${data.sarafi!.fullname}");
  //   forexController.text = data.sarafiId.toString();
  //   dateController.text = data.drawDate.toString();
  //   yenPriceController.text = data.yen.toString();
  //   dollarPriceController.text = data.doller.toString();
  //   exchangeRateController.text = data.exchangerate.toString();
  //   descriptionController.text = data.description.toString();
  //   bankPhotoController.text = data.photo.toString();
  //   bankPhotoController.text = data.photo.toString();

  //   _helperServices.navigate(DrawEditScreen(
  //     drawData: data,
  //     drawId: id,
  //   ));
  // }

  createSaraiInDeal() async {
    // _helperServices.showLoader();
    DateTime selectedDate = DateTime.now();
    String currentDate =
        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

    var response = await SaraiInDealApiServiceProvider().createSaraiInDeal(
      'add-sarai-in-deal',
      {
        "saraiindeal_id": 0,
        "indate": currentDate,
        "transportdeal_id": transportDealIdController.text,
        "saraifrom": null,
        "sarai_id": saraiIdController.text,
      },
    );
    response.fold(
      (l) {
        // _helperServices.goBack();
        _helperServices.showErrorMessage(l);
        print("failure");
      },
      (r) {
        // getAllSaraiInDeal();
        // _helperServices.goBack();
        print("done");
        // _helperServices.showMessage(
        //   const LocaleText('added'),
        //   Colors.green,
        //   const Icon(
        //     Icons.check,
        //     color: Pallete.whiteColor,
        //   ),
        // );

        clearAllControllers();
      },
    );
  }

  editSaraiInDeal(int saraiInDealId) async {
    print("sarai in deal  id");
    print(saraiInDealId);
    print("indate");
    print(inDateController.text);
    print("trDeal id =");
    print(transportDealIdController.text);
    print("sarai id ");
    print(saraiIdController.text);
    // _helperServices.showLoader();

    var response = await SaraiInDealApiServiceProvider().editSaraiInDeal(
      'update-sarai-in-deal?saraiindeal_id$saraiInDealId',
      {
        "saraiindeal_id": saraiInDealId,
        "indate": inDateController.text,
        "transportdeal_id": transportDealIdController.text,
        "saraifrom": null,
        "sarai_id": saraiIdController.text,
      },
    );
    response.fold(
      (l) {
        // _helperServices.goBack();
        _helperServices.showErrorMessage(l);
        print("in deal error");
      },
      (r) {
        // getAllSaraiInDeal();
        // _helperServices.goBack();
        print(" indeal  success");

       

        clearAllControllers();
      },
    );
  }

  // void deleteItemLocally(int id) {
  //   final index = allDraws!.indexWhere((element) => element.drawId == id);
  //   if (index != -1) {
  //     allDraws!.removeAt(index);

  //     final searchIndex =
  //         searchDraws!.indexWhere((element) => element.drawId == id);
  //     if (searchIndex != -1) {
  //       searchDraws!.removeAt(searchIndex);
  //     }

  //     notifyListeners();
  //   }
  // }

  // deleteDraw(id, index) async {
  //   _helperServices.showLoader();
  //   var response =
  //       await DrawApiServiceProvider().deleteDraw('delete-draw?draw_id=$id');
  //   _helperServices.goBack();
  //   response.fold(
  //     (l) => {
  //       _helperServices.goBack(),
  //       _helperServices.showErrorMessage(l),
  //     },
  //     (r) => {
  //       if (r == 200)
  //         {
  //           _helperServices.showMessage(
  //             const LocaleText('deleted'),
  //             Colors.red,
  //             const Icon(
  //               Icons.close,
  //               color: Pallete.whiteColor,
  //             ),
  //           ),
  //           deleteItemLocally(id),
  //         }
  //       else if (r == 500)
  //         {
  //           _helperServices.showMessage(
  //             const LocaleText('parent'),
  //             Colors.deepOrange,
  //             const Icon(
  //               Icons.warning,
  //               color: Pallete.whiteColor,
  //             ),
  //           ),
  //         }
  //     },
  //   );
  // }

  getAllSaraiInDeal(int? transportDealId) async {
    _helperServices.showLoader();
    final response =
        await SaraiInDealApiServiceProvider().getSaraiInDeal('getSaraiInDeal');
    response.fold(
      (l) => {
        _helperServices.goBack(),
        _helperServices.showErrorMessage(l),
        print(l),
      },
      (r) {
        allSaraiInDeal = r;
        print(allSaraiInDeal!.length);
        // goBack pops the current stack
        // _helperServices.goBack();
        allSaraiInDeal = r
            .where(
                (saraiInDeal) => saraiInDeal.transportdealId == transportDealId)
            .toList();
        searchSaraiInDeal?.clear();
        searchSaraiInDeal?.addAll(allSaraiInDeal!);
        // this methods assign the recent data to the search List
        // updateForexData();
        notifyListeners();
      },
    );
  }

  searchSaraiInDealMethod(String name) {
    searchText = name;
    updateSaraiInDealData();
  }

  updateSaraiInDealData() {
    searchSaraiInDeal?.clear();
    if (searchText.isEmpty) {
      searchSaraiInDeal?.addAll(allSaraiInDeal!);
    } else {
      searchSaraiInDeal?.addAll(
        allSaraiInDeal!
            .where(
                (element) => element.indate!.toLowerCase().contains(searchText))
            .toList(),
      );
    }
    notifyListeners();
  }

  void clearAllControllers() {
    inDateController.clear();
    transportDealIdController.clear();
    saraiFrom.clear();
    saraiIdController.clear();
  }
}
