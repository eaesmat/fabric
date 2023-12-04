import 'package:fabricproject/common/api_endpoint.dart';
import 'package:fabricproject/models/customer_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_button.dart';
import 'package:fabricproject/widgets/custom_text_field_with_no_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  List<Data>? customerData;
  bool _addingNewItem = false;
  bool _updated = false;
  bool _added = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> updateItem(int index, String newFirstName, String newLastName,
      String newPhoto, String newAddress) async {
    setState(() {
      _addingNewItem = true;
    });

    try {
      final response = await http.put(
        Uri.parse(
            '${baseURL}update-customer?customer_id=${customerData![index].customerId}'),
        body: json.encode({
          'customer_id': customerData![index].customerId,
          'firstname': newFirstName,
          'lastname': newLastName,
          'photo': newPhoto,
          'address': newAddress,
          'user_id': customerData![index].userId
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        _updated = true;
        fetchData(); // Refresh the data after updating an item
      } else {
        throw Exception('Failed to update item');
      }
    } catch (e) {
      // Handle exceptions here if needed
    } finally {
      setState(() {
        _addingNewItem = false;
        if (_updated) {
          showSuccessMessage(context, 'successfully_updated', Colors.green);
        }
      });
    }
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('${baseURL}getCustomer'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final customer = Customer.fromJson(jsonResponse);

        setState(() {
          customerData = customer.data;
        });
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to load data');
    }
  }

  Future<void> deleteItem(int index) async {
    final response = await http.delete(Uri.parse(
        '${baseURL}delete-customer?customer_id=${customerData![index].customerId}'));

    if (response.statusCode == 500) {
      setState(() {
        showSuccessMessage(context, 'the_item_has_children!', Colors.red);
      });
    } else if (response.statusCode == 200) {
      setState(() {
        customerData!.removeAt(index);
        showSuccessMessage(context, 'item_successfully_deleted', Colors.green);
      });
    } else {
      throw Exception('Failed to delete item');
    }
  }

  Future<void> addNewItem(
    String firstname,
    String lastname,
    String photo,
    String address,
  ) async {
    setState(() {
      _addingNewItem = true;
    });

    try {
      final response = await http.post(
        Uri.parse('${baseURL}add-customer'),
        body: json.encode({
          'customer_id': 0,
          'firstname': firstname,
          'lastname': lastname,
          'photo': photo,
          'address': address,
          'user_id': 1,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        _added = true;
        fetchData(); // Refresh the data after adding a new item
      } else {
        throw Exception('Failed to add item');
      }
    } catch (e) {
      // Handle exceptions here if needed
    } finally {
      setState(() {
        _addingNewItem = false;
        if (_added) {
          showSuccessMessage(context, 'item_successfully_added', Colors.green);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'customers'),
      ),
      body: customerData == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Pallete.blueColor,
              ),
            )
          : ListView.builder(
              itemCount: customerData!.length,
              itemBuilder: (context, index) {
                final data = customerData![index];

                return ListTileWidget(
                  lead: CircleAvatar(
                    child: Text(
                      data.photo.toString().toUpperCase(),
                    ),
                  ),
                  tileTitle: Row(
                    children: [
                      Text(
                        data.firstname.toString() +
                            " " +
                            data.lastname.toString(),
                      ),
                    ],
                  ),
                  tileSubTitle: Row(
                    children: [
                      Text(
                        data.address.toString(),
                      ),
                    ],
                  ),
                  onLongPress: () {
                    showLongPressDialog(
                      index,
                      data.firstname.toString(),
                      data.lastname.toString(),
                      data.photo.toString(),
                      data.address.toString(),
                    );
                  },
                );
              },
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
                                  Navigator.pop(context);
                                  deleteItem(index);
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
                  child: LocaleTexts(localeText: 'create_customer'),
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('first_name'),
                  onChanged: (value) => newFirstName = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('last_name'),
                  onChanged: (value) => newLastName = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('photo'),
                  onChanged: (value) => newPhoto = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWithNoController(
                  lblText: const LocaleText('address'),
                  onChanged: (value) => newAddress = value,
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
                        'create',
                        style: TextStyle(color: Pallete.whiteColor),
                      ),
                      btnWidth: 0.01,
                      bgColor: Pallete.blueColor,
                      callBack: () {
                        addNewItem(
                            newFirstName, newLastName, newPhoto, newAddress);
                        Navigator.pop(context);
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
                        updateItem(index, newFirstName, newLastName, newPhoto,
                            newAddress);
                        Navigator.pop(context);
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
