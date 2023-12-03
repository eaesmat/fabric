import 'package:fabricproject/models/forex_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:fabricproject/models/internal_companies_model.dart';
// import 'package:fabricproject/models/forex_model.dart'; // Make sure to import your models

class SaraiScreen extends StatefulWidget {
  const SaraiScreen({Key? key}) : super(key: key);

  @override
  _SaraiScreenState createState() => _SaraiScreenState();
}

class _SaraiScreenState extends State<SaraiScreen> {
  List<Data>? forexData;
  bool _addingNewItem = false;
  bool _updated = false;
  bool _added = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> updateItem(int index, String newFullName, String newDescription,
      String newPhone, String newShoNo, String newLocation) async {
    setState(() {
      _addingNewItem = true;
    });

    try {
      final response = await http.put(
        Uri.parse(
            'http://10.0.2.2:8000/api/update-sarfi?sarfi_id=${forexData![index].sarafiId}'),
        body: json.encode({
          'sarafi_id': forexData![index].sarafiId,
          'fullname': newFullName,
          'description': newDescription,
          'phone': newPhone,
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
          showSuccessMessage(context, 'Updated!', Colors.green);
        }
      });
    }
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:8000/api/getSarafi'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final forex = Forex.fromJson(jsonResponse);

        setState(() {
          forexData = forex.data;
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
        'http://10.0.2.2:8000/api/delete-sarafi?sarafi_id=${forexData![index].sarafiId}'));

    if (response.statusCode == 500) {
      setState(() {
        showSuccessMessage(context, 'Has children!', Colors.red);
      });
    } else if (response.statusCode == 200) {
      setState(() {
        forexData!.removeAt(index);
        showSuccessMessage(context, 'Deleted!', Colors.green);
      });
    } else {
      throw Exception('Failed to delete item');
    }
  }

  Future<void> addNewItem(String fullname, String phone, String description,
      String shopno, String location) async {
    setState(() {
      _addingNewItem = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/add-sarafi'),
        body: json.encode({
          'companyId': 0,
          'fullname': fullname,
          'description': description,
          'phone': phone,
          'shopno': shopno,
          'location': location
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
          showSuccessMessage(context, 'Added!', Colors.green);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App Title'),
      ),
      body: forexData == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Pallete.blueColor,
              ),
            )
          : ListView.builder(
              itemCount: forexData!.length,
              itemBuilder: (context, index) {
                final data = forexData![index];

                return ListTileWidget(
                  lead: CircleAvatar(
                    backgroundColor: Pallete.blueColor,
                    child: Text(
                      data.location.toString(),
                      style: const TextStyle(color: Pallete.whiteColor),
                    ),
                  ),
                  tileTitle: Row(
                    children: [
                      Text(
                        data.fullname.toString(),
                      ),
                      const Spacer(),
                      Text(
                        data.phone.toString(),
                      ),
                    ],
                  ),
                  tileSubTitle: Row(
                    children: [
                      Text(
                        data.description.toString(),
                      ),
                      const Spacer(),
                      Text(
                        data.shopno.toString(),
                      ),
                    ],
                  ),
                  onLongPress: () {
                    showLongPressDialog(
                      index,
                      data.fullname.toString(),
                      data.description.toString(),
                      data.phone.toString(),
                      data.shopno.toString(),
                      data.location.toString(),
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
      String currentFullName,
      String currentPhone,
      String currentDescription,
      String currentShopno,
      String currentLocation) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.pop(context);
                  showEditDialog(index, currentFullName, currentPhone,
                      currentDescription, currentShopno, currentLocation);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  Navigator.pop(context);
                  deleteItem(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> addItem() async {
    String newFullName = '';
    String newDescription = '';
    String newPhone = '';
    String newShopno = '';
    String newLocation = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) => newFullName = value,
                  decoration: InputDecoration(labelText: 'Full Name'),
                ),
                TextField(
                  onChanged: (value) => newDescription = value,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  onChanged: (value) => newPhone = value,
                  decoration: InputDecoration(labelText: 'Phone'),
                ),
                TextField(
                  onChanged: (value) => newShopno = value,
                  decoration: InputDecoration(labelText: 'Shop No'),
                ),
                TextField(
                  onChanged: (value) => newLocation = value,
                  decoration: InputDecoration(labelText: 'Location'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Perform the add operation with the entered data
                    addNewItem(newFullName, newPhone, newDescription, newShopno,
                        newLocation);
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
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
      String currentFullName,
      String currentPhone,
      String currentDescription,
      String currentShopno,
      String currentLocation) async {
    String newFullName = currentFullName;
    String newPhone = currentPhone;
    String newDescription = currentDescription;
    String newShopno = currentShopno;
    String newLocation = currentLocation;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => newFullName = value,
                decoration: InputDecoration(labelText: 'Name'),
                controller: TextEditingController(text: currentFullName),
              ),
              TextField(
                onChanged: (value) => newPhone = value,
                decoration: InputDecoration(labelText: 'Marka'),
                controller: TextEditingController(text: currentPhone),
              ),
              TextField(
                onChanged: (value) => newDescription = value,
                decoration: InputDecoration(labelText: 'Description'),
                controller: TextEditingController(text: currentDescription),
              ),
              TextField(
                onChanged: (value) => newShopno = value,
                decoration: InputDecoration(labelText: 'Shop No'),
                controller: TextEditingController(text: currentShopno),
              ),
              TextField(
                onChanged: (value) => newLocation = value,
                decoration: InputDecoration(labelText: 'Location'),
                controller: TextEditingController(text: currentLocation),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Perform the update operation with the entered data
                  updateItem(index, newFullName, newPhone, newDescription,
                      newShopno, newLocation);
                  Navigator.pop(context);
                },
                child: Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }
}

void showSuccessMessage(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // Adjust the duration as needed
      backgroundColor: color, // You can customize the color
    ),
  );
}
