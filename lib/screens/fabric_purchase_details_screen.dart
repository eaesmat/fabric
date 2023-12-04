import 'dart:convert';
import 'package:fabricproject/common/api_endpoint.dart';
import 'package:fabricproject/models/fabric_purchase_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_button.dart';
import 'package:fabricproject/widgets/custom_text_field_with_no_controller.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/expansion_tile.dart';
import 'package:fabricproject/widgets/list_tile_item_widget.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:http/http.dart' as http;

class FabricPurchaseDetailsScreen extends StatefulWidget {
  final int externalCompanyId;
  final String externalCompanyName;

  const FabricPurchaseDetailsScreen({
    Key? key,
    required this.externalCompanyId,
    required this.externalCompanyName,
  }) : super(key: key);

  @override
  State<FabricPurchaseDetailsScreen> createState() =>
      _FabricPurchaseDetailsScreenState();
}

class _FabricPurchaseDetailsScreenState
    extends State<FabricPurchaseDetailsScreen> {
  List<Data> fabricPurchases = [];
  Map<int, String> fabricNames = {};
  bool _addingNewItem = false;

  @override
  void initState() {
    super.initState();
    // Fetch fabric data only once in initState
    fetchFabricPurchases();
  }

  Future<String> getFabric(int fabricId) async {
    if (fabricNames.containsKey(fabricId)) {
      // If fabric name is already fetched, return it from the map
      return fabricNames[fabricId]!;
    }

    try {
      final response = await http.put(
        Uri.parse('${baseURL}edit-fabric?fabric_id=$fabricId'),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final name = jsonResponse['data']['name'];

        // Save the fetched fabric name to the map
        fabricNames[fabricId] = name;

        // Check if the widget is still mounted before using setState
        if (mounted) {
          setState(() {});
        }

        return name;
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (e) {
      print('Error: $e');
      return '';
    }
  }

  Future<List<Data>> fetchFabricPurchases() async {
    try {
      final response = await http.get(
        Uri.parse('${baseURL}getFabricPurchase'),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final fabricPurchase = FabricPurchase.fromJson(jsonResponse);

        // Filter purchases where vendorcompanyId is equal to widget.externalCompanyId
        fabricPurchases = fabricPurchase.data
                ?.where((purchase) =>
                    purchase.vendorcompanyId == widget.externalCompanyId)
                .toList() ??
            [];

        // Fetch fabric data for each fabricId
        for (final data in fabricPurchases) {
          await getFabric(data.fabricId!.toInt());
        }

        return fabricPurchases;
      } else {
        throw Exception('Failed to load fabric purchases');
      }
    } catch (e) {
      // Handle exceptions
      print('Error fetching fabric purchases: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.externalCompanyName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Data>>(
                future: fetchFabricPurchases(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Pallete.blueColor,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  List<Data> filteredPurchases = snapshot.data ?? [];

                  return ListView.builder(
                    itemCount: filteredPurchases.length,
                    itemBuilder: (context, index) {
                      final data = filteredPurchases[index];

                      return ExpansionTileWidget(
                        lead: Image.asset(
                          'assets/images/fabricIcon.png',
                          height: 23,
                        ),
                        expansionTitle: Row(
                          children: [
                            FutureBuilder<String>(
                              future: getFabric(data.fabricId!.toInt()),
                              builder: (context, nameSnapshot) {
                                if (nameSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }

                                return Text(
                                  nameSnapshot.data ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  "${data.fabricpurchasecode}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: [
                          ExpansionTileItemWidget(
                            tileTitle: Column(
                              children: [
                                Row(
                                  children: [
                                    const LocaleText('company'),
                                    Text(
                                      ": ${widget.externalCompanyName}",
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const LocaleText('bundle'),
                                    Text(
                                      ": ${data.bundle}",
                                    ),
                                  ],
                                ),
                                Row(),
                                Row(
                                  children: [
                                    const LocaleText('meter'),
                                    Text(
                                      ": ${data.meter}",
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const LocaleText('war'),
                                    Text(
                                      ": ${data.war}",
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const LocaleText('yen_price'),
                                    Text(
                                      ": ${data.yenprice}",
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const LocaleText('total_yen_price'),
                                    Text(
                                      ": ${data.totalyenprice}",
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const LocaleText('dollar_price'),
                                    Text(
                                      ": ${data.dollerprice}",
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const LocaleText('total_dollar_price'),
                                    Text(
                                      ": ${data.totaldollerprice}",
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const LocaleText('tt_commission'),
                                    Text(
                                      ": ${data.ttcommission}",
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const LocaleText('tamam_shoda'),
                                    Text(
                                      ": ${data.dollerprice}",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _addingNewItem
          ? const FloatingActionButton(
              // If adding a new item, show a disabled button
              onPressed: null,
              child: CircularProgressIndicator(
                color: Pallete.blueColor,
              ),
            )
          : FloatingActionButton(
              backgroundColor: Pallete.blueColor,
              onPressed: () {
                addItem();
              },
              tooltip: 'Add Item',
              child: const Icon(
                Icons.add,
                color: Pallete.whiteColor,
              ),
            ),
    );
  }

  Future<void> showLongPressDialog(
      int index,
      String currentFirstName,
      String currentLastName,
      String currentPhoto,
      String currentAddress) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CustomButton(
                  btnIcon: const Icon(
                    Icons.edit_note,
                    color: Pallete.whiteColor,
                    size: 20,
                  ),
                  btnText: const LocaleText(
                    'update',
                    style: TextStyle(color: Pallete.whiteColor, fontSize: 12),
                  ),
                  bgColor: Pallete.blueColor,
                  btnWidth: 1,
                  callBack: () {
                    Navigator.pop(context);
                    showEditDialog(index, currentFirstName, currentLastName,
                        currentPhoto, currentAddress);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: CustomButton(
                  btnIcon: const Icon(
                    Icons.delete,
                    color: Pallete.whiteColor,
                    size: 20,
                  ),
                  btnText: const LocaleText(
                    'delete',
                    style: TextStyle(color: Pallete.whiteColor, fontSize: 12),
                  ),
                  bgColor: Pallete.redColor,
                  btnWidth: 1,
                  callBack: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const LocaleText('delete_confirmation'),
                          content: const LocaleText('are_you_sure_to_delete'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  // Navigator.pop(context);
                                  // deleteItem(index);
                                },
                                child: const LocaleText(
                                  "yes",
                                  style: TextStyle(color: Colors.green),
                                )),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const LocaleText(
                                "no",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> addItem() async {
    String newFirstName = '';
    String newLastName = '';
    String newPhoto = '';
    String newAddress = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: LocaleTexts(localeText: 'create_new_item'),
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('company'),
                  onChanged: (value) => newFirstName = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('fabric'),
                  onChanged: (value) => newLastName = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('bundle'),
                  onChanged: (value) => newPhoto = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('meter'),
                  onChanged: (value) => newAddress = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('war'),
                  onChanged: (value) => newAddress = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('yen_prce'),
                  onChanged: (value) => newAddress = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('total_yen_price'),
                  onChanged: (value) => newAddress = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('exchange_price'),
                  onChanged: (value) => newAddress = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('dollar_price'),
                  onChanged: (value) => newAddress = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('total_dollar_price'),
                  onChanged: (value) => newAddress = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('marka'),
                  onChanged: (value) => newAddress = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('tt_commission'),
                  onChanged: (value) => newAddress = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('date'),
                  onChanged: (value) => newAddress = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('code'),
                  onChanged: (value) => newAddress = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        btnIcon: const Icon(
                          Icons.check,
                          color: Pallete.whiteColor,
                        ),
                        btnText: const LocaleText(
                          'create',
                          style: TextStyle(color: Pallete.whiteColor),
                        ),
                        btnWidth: 0.01,
                        bgColor: Pallete.blueColor,
                        callBack: () {
                          // addNewItem(
                          //     newFirstName, newLastName, newPhoto, newAddress);
                          // Navigator.pop(context);
                        },
                      ),
                      CustomButton(
                        btnIcon: const Icon(
                          Icons.close,
                          color: Pallete.whiteColor,
                        ),
                        btnText: const LocaleText(
                          'cancel',
                          style: TextStyle(color: Pallete.whiteColor),
                        ),
                        btnWidth: 0.01,
                        bgColor: Pallete.redColor,
                        callBack: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showEditDialog(
      int index,
      String currentFirstName,
      String currentLastName,
      String currentPhoto,
      String currentAddress) async {
    String newFirstName = currentFirstName;
    String newLastName = currentLastName;
    String newPhoto = currentPhoto;
    String newAddress = currentAddress;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: LocaleTexts(localeText: 'update_customer'),
                ),
                CustomTextFieldWithController(
                  lblText: const LocaleText('first_name'),
                  onChanged: (value) => newFirstName = value,
                  controller: TextEditingController(text: currentFirstName),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithController(
                  lblText: const LocaleText('last_name'),
                  onChanged: (value) => newLastName = value,
                  controller: TextEditingController(text: currentLastName),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithController(
                  lblText: const LocaleText('photo'),
                  onChanged: (value) => newPhoto = value,
                  controller: TextEditingController(text: currentPhoto),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithController(
                  lblText: const LocaleText('address'),
                  onChanged: (value) => newAddress = value,
                  controller: TextEditingController(text: currentAddress),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      btnIcon: const Icon(
                        Icons.check,
                        color: Pallete.whiteColor,
                      ),
                      btnText: const LocaleText(
                        'update',
                        style: TextStyle(color: Pallete.whiteColor),
                      ),
                      btnWidth: 0.01,
                      bgColor: Pallete.blueColor,
                      callBack: () {
                        // updateItem(index, newFirstName, newLastName, newPhoto,
                        //     newAddress);
                        // Navigator.pop(context);
                      },
                    ),
                    CustomButton(
                      btnIcon: const Icon(
                        Icons.close,
                        color: Pallete.whiteColor,
                      ),
                      btnText: const LocaleText(
                        'cancel',
                        style: TextStyle(color: Pallete.whiteColor),
                      ),
                      btnWidth: 0.01,
                      bgColor: Pallete.redColor,
                      callBack: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void showSuccessMessage(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: LocaleText(message),
      duration: Duration(seconds: 2), // Adjust the duration as needed
      backgroundColor: color, // You can customize the color
    ),
  );
}
