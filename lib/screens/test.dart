  // expansionTitle: Text(data.fabric!.name.toString()),
  //                   children: [
  //                     ExpansionTileItemWidget(
  //                       tileTitle: Column(
  //                         children: [
  //                           Row(
  //                             children: [
  //                               const LocaleText('code'),
  //                               Text(
  //                                 ": ${data.fabricpurchasecode}",
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               const LocaleText('item'),
  //                               Text(
  //                                 ": ${data.fabric!.name}",
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               const LocaleText('marka'),
  //                               Text(
  //                                 ": ${data.company!.marka}",
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               const LocaleText('company'),
  //                               Text(
  //                                 ": ${widget.vendorCompanyName}",
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               const LocaleText('bundle'),
  //                               Text(
  //                                 ": ${data.bundle}",
  //                               ),
  //                             ],
  //                           ),
  //                           Row(),
  //                           Row(
  //                             children: [
  //                               const LocaleText('meter'),
  //                               Text(
  //                                 ": ${data.meter}",
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               const LocaleText('war'),
  //                               Text(
  //                                 ": ${data.war}",
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               const LocaleText('yen_price'),
  //                               Text(
  //                                 ": ${data.yenprice ?? 'v'}",
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               const LocaleText('total_yen_price'),
  //                               Text(
  //                                 ": ${data.totalyenprice}",
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               const LocaleText('dollar_price'),
  //                               Text(
  //                                 ": ${data.dollerprice}",
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               const LocaleText('total_dollar_price'),
  //                               Text(
  //                                 ": ${data.totaldollerprice}",
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               const LocaleText('tt_commission'),
  //                               Text(
  //                                 ": ${data.ttcommission}",
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               const LocaleText('tamam_shoda'),
  //                               Text(
  //                                 ": ${data.dollerprice}",
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               const LocaleText('exchnage'),
  //                               Text(
  //                                 ": ${data.yenexchange}",
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               const LocaleText('date'),
  //                               Text(
  //                                 ": ${data.date}",
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //   
  //
  //
  //                ),


  // Inside your DrawController class

// createDraw() async {
//   _helperServices.showLoader();

//   var response = await DrawApiServiceProvider().createDraw(
//     'add-draw',
//     {
//  "draw_id": 0,
//         "draw_date": dateController.text,
//         "doller": dollarPriceController.text,
//         "description": descriptionController.text,
//         "photo": bankPhotoController.text,
//         "sarafi_id": forexController.text,
//         "yen": yenPriceController.text,
//         "exchangerate": exchangeRateController.text,
//         "vendorcompany_id": vendorCompanyId,
//         "user_id": 1,    },
//   );
//   response.fold(
//     (l) {
//       _helperServices.goBack();
//       _helperServices.showErrorMessage(l);
//       print(l);
//     },
//     (r) {
//       // Instead of calling getAllDraws, you can update locally
//       Data newDraw = Data(/* Create a new Data object from the response */);
//       allDraws?.add(newDraw);
//       searchDraws?.add(newDraw);

//       _helperServices.goBack();
//       _helperServices.showMessage(
//         const LocaleText('added'),
//         Colors.green,
//         const Icon(
//           Icons.check,
//           color: Pallete.whiteColor,
//         ),
//       );

//       clearAllControllers();
//       notifyListeners();
//     },
//   );
// }

// editDraw(int drawId) async {
//   _helperServices.showLoader();

//   var response = await DrawApiServiceProvider().editDraw(
//     'update-draw?draw_id$drawId',
//     {
//    "draw_id": drawId,
//         "draw_date": dateController.text,
//         "doller": dollarPriceController.text,
//         "description": descriptionController.text,
//         "photo": bankPhotoController.text,
//         "sarafi_id": forexController.text,
//         "yen": yenPriceController.text,
//         "exchangerate": exchangeRateController.text,
//         "vendorcompany_id": vendorCompanyId,
//         "user_id": 1,    },
//   );
//   response.fold(
//     (l) {
//       _helperServices.goBack();
//       _helperServices.showErrorMessage(l);
//       print(l);
//     },
//     (r) {
//       // Instead of calling getAllDraws, you can update locally
//       Data updatedDraw = Data(/* Create a new Data object with updated values */);
//       int index = allDraws!.indexWhere((draw) => draw.drawId == drawId);
//       allDraws![index] = updatedDraw;

//       int searchIndex = searchDraws!.indexWhere((draw) => draw.drawId == drawId);
//       searchDraws![searchIndex] = updatedDraw;

//       _helperServices.goBack();
//       _helperServices.showMessage(
//         const LocaleText('updated'),
//         Colors.green,
//         const Icon(
//           Icons.check,
//           color: Pallete.whiteColor,
//         ),
//       );

//       clearAllControllers();
//       notifyListeners();
//     },
//   );
// }
