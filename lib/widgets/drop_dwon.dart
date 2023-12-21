// import 'package:fabricproject/theme/pallete.dart';
// import 'package:fabricproject/widgets/custom_drop_down_button.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class BottomSheetWidget extends StatefulWidget {
//   const BottomSheetWidget({super.key});

//   @override
//   _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
// }

// class _BottomSheetWidgetState extends State<BottomSheetWidget> {
//   late String buttonText;

//   @override
//   void initState() {
//     super.initState();
//     buttonText = 'Company';
//   }

//   void updateButtonText(String value) {
//     setState(() {
//       buttonText = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CustomDropDownButton(
//           bgColor: Pallete.blueColor,
//           btnWidth: 1,
//           btnIcon: const FaIcon(FontAwesomeIcons.buildingWheat,
//               size: 18, color: Pallete.whiteColor),
//           onTap: () {
//             showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               builder: (BuildContext context) {
//                 return MyBottomSheet(updateButtonText: updateButtonText);
//               },
//             );
//           },
//           btnText: Text(buttonText,
//               style: const TextStyle(color: Pallete.whiteColor)),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }
// }

// class MyBottomSheet extends StatelessWidget {
//   final Function(String) updateButtonText;

//   MyBottomSheet({required this.updateButtonText});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.8,
//       padding: EdgeInsets.all(16.0),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Text(
//               'This is a Bottom Sheet Taking 80% of the Screen Height',
//               style: TextStyle(fontSize: 20.0),
//             ),
//             SizedBox(height: 20.0),
//             // Add your scrollable content here
//             // Example: A list of items
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: 20,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text('Item $index'),
//                   onTap: () {
//                     String selectedItem = 'Item $index';
//                     updateButtonText(selectedItem);
//                     Navigator.pop(context); // Close the bottom sheet
//                   },
//                 );
//               },
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Close Bottom Sheet'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
