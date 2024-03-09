// import 'package:fabricproject/controller/transport_deal_controller.dart';
// import 'package:fabricproject/controller/transport_payment_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_locales/flutter_locales.dart';
// import 'package:provider/provider.dart';
// // this screen calculates transport 
// class TransportCalculation extends StatelessWidget {
//   const TransportCalculation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final transportDealController =
//         Provider.of<TransportDealController>(context);

//     final transportPaymentController =
//         Provider.of<TransportPaymentController>(context);

//     double totalCost = 0;
//     double totalPayment = 0;
//     double dueMoney = 0;
//     double dueBundles = 0;
//     double totalBundles = 0;

//     totalCost = transportDealController.sumOfTransportDealTotalCost;
//     totalPayment = transportPaymentController.sumOfTotalTransportPaymentAmount;
//     dueMoney = totalCost - totalPayment;
//     dueBundles = transportDealController.sumOfTransportDealTotalDueBundle;
//     totalBundles = transportDealController.sumOfTransportDealTotalBundle;

//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         return SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: SingleChildScrollView(
//             child: Center(
//               child: DataTable(
//                 columnSpacing: constraints.maxWidth * 0.4, // Adjust as needed
//                 columns: const [
//                   DataColumn(
//                     label: LocaleText(
//                       'attribute',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   DataColumn(
//                     label: LocaleText(
//                       'value',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//                 rows: [
//                   buildDataRow('due_money', dueMoney.toStringAsFixed(2),
//                       color: Colors.black),
//                   buildDataRow('due_bundle', dueBundles.toStringAsFixed(2),
//                       color: Colors.red),
//                   buildDataRow('total_payment', totalPayment.toStringAsFixed(2),
//                       color: Colors.green.shade500),
//                   buildDataRow('total_cost', totalCost.toStringAsFixed(2),
//                       color: Colors.black),
//                   buildDataRow('total_bundles', totalBundles.toStringAsFixed(2),
//                       color: Colors.black),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   DataRow buildDataRow(String attribute, String value, {required Color color}) {
//     return DataRow(
//       cells: [
//         DataCell(
//           LocaleText(attribute, style: TextStyle(color: color)),
//           placeholder: true,
//           showEditIcon: false,
//         ),
//         DataCell(
//           Text(value, style: TextStyle(color: color)),
//           placeholder: true,
//           showEditIcon: false,
//         ),
//       ],
//     );
//   }
// }
