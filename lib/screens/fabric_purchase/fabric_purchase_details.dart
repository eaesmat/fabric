// import 'package:fabricproject/controller/fabric_design_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:fabricproject/theme/pallete.dart';
// import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
// import 'package:fabricproject/widgets/list_tile_widget.dart';
// import 'package:fabricproject/widgets/locale_text_widget.dart';
// import 'package:flutter_locales/flutter_locales.dart';
// import 'package:provider/provider.dart';

// class CompanyListScreen extends StatefulWidget {
//   const CompanyListScreen({Key? key}) : super(key: key);

//   @override
//   State<CompanyListScreen> createState() => _CompanyListScreenState();
// }

// class _CompanyListScreenState extends State<CompanyListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final fabricDesignController = Provider.of<FabricDesignController>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const LocaleTexts(localeText: 'companies'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [ 
//           Consumer<FabricDesignController>(
//             builder: (context, fabricDesignController, child) {
//               return Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: CustomTextFieldWithController(
//                   lblText: const LocaleText('search'),
//                   onChanged: (value) {
//                     fabricDesignController.searchFabricDesignMethod(value);
//                   },
//                 ),
//               );
//             },
//           ),
//           Expanded(
//             child: Consumer<FabricDesignController>(
//               builder: (context, fabricDesignController, child) {
//                 return ListView.builder(
//                   itemCount: fabricDesignController.searchFabricDesigns?.length ?? 0,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     final data = fabricDesignController.searchFabricDesigns![index];
//                     return ListTileWidget(
//                       lead: CircleAvatar(
//                         backgroundColor: Pallete.blueColor,
//                         child: Text(
//                           data.name!.toString(),
//                           style: const TextStyle(color: Pallete.whiteColor),
//                         ),
//                       ),
//                       tileTitle: Text(
//                         data.name.toString(),
//                       ),
//                       tileSubTitle: Text(data.bundle.toString()),
//                       trail: PopupMenuButton(
//                         color: Pallete.whiteColor,
//                         child: const Icon(Icons.more_vert_sharp),
//                         itemBuilder: (context) => <PopupMenuEntry<String>>[
//                           const PopupMenuItem(
//                               value: "delete",
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.delete),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   LocaleText('delete'),
//                                 ],
//                               )),
//                           const PopupMenuItem(
//                             value: "edit",
//                             child: Row(
//                               children: [
//                                 Icon(Icons.edit),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 LocaleText('update')
//                               ],
//                             ),
//                           ),
//                         ],
//                         onSelected: (String value) {
//                           if (value == "edit") {
//                             fabricDesignController.navigateToFabricDesignEdit(
//                                 data, data.fabricdesignId!.toInt());
//                           }
//                           if (value == "delete") {
//                             fabricDesignController.deleteFabricDesign(
//                                 data.fabricdesignId, index);
//                           }
//                         },
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Pallete.blueColor,
//         onPressed: () {
//           fabricDesignController.navigateToFabricDesignCreate();
//         },
//         child: const Icon(
//           Icons.add,
//           color: Pallete.whiteColor,
//         ),
//       ),
//     );
//   }
// }
