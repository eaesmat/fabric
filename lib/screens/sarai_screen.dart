import 'package:fabricproject/common/api_endpoint.dart';
import 'package:fabricproject/models/sarai_model.dart';
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
  List<Data>? saraiData;
  bool _addingNewItem = false;
  bool _updated = false;
  bool _added = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> updateItem(int index, String newName, String newDescription,
      String newPhone, String newLocation) async {
    setState(() {
      _addingNewItem = true;
    });

    try {
      final response = await http.put(
        Uri.parse(
            '${baseURL}update-sarai?sarai_id=${saraiData![index].saraiId}'),
        body: json.encode({
          'sarai_id': saraiData![index].saraiId,
          'name': newName,
          'location': newLocation,
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
          await http.get(Uri.parse('${baseURL}getSarai'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final sarai = Sarai.fromJson(jsonResponse);

        setState(() {
          saraiData = sarai.data;
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
        '${baseURL}delete-sarai?sarai_id=${saraiData![index].saraiId}'));

    if (response.statusCode == 500) {
      setState(() {
        showSuccessMessage(context, 'Has children!', Colors.red);
      });
    } else if (response.statusCode == 200) {
      setState(() {
        saraiData!.removeAt(index);
        showSuccessMessage(context, 'Deleted!', Colors.green);
      });
    } else {
      throw Exception('Failed to delete item');
    }
  }

  Future<void> addNewItem(
      String name, String phone, String description, String location) async {
    setState(() {
      _addingNewItem = true;
    });

    try {
      final response = await http.post(
        Uri.parse('${baseURL}add-sarai'),
        body: json.encode({
          'sarai_Id': 0,
          'name': name,
          'description': description,
          'phone': phone,
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
      body: saraiData == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Pallete.blueColor,
              ),
            )
          : ListView.builder(
              itemCount: saraiData!.length,
              itemBuilder: (context, index) {
                final data = saraiData![index];

                return ListTileWidget(
                  tileTitle: Row(
                    children: [
                      Text(
                        data.name.toString(),
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
                        data.location.toString(),
                      ),
                    ],
                  ),
                  onLongPress: () {
                    showLongPressDialog(
                      index,
                      data.name.toString(),
                      data.description.toString(),
                      data.phone.toString(),
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
      String currentName,
      String currentPhone,
      String currentDescription,
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
                  showEditDialog(index, currentName, currentPhone,
                      currentDescription, currentLocation);
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
    String newName = '';
    String newDescription = '';
    String newPhone = '';
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
                  onChanged: (value) => newName = value,
                  decoration: InputDecoration(labelText: 'Name'),
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
                    addNewItem(newName, newPhone, newDescription, newLocation);
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
      String currentName,
      String currentPhone,
      String currentDescription,
      String currentLocation) async {
    String newName = currentName;
    String newPhone = currentPhone;
    String newDescription = currentDescription;
    String newLocation = currentLocation;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => newName = value,
                decoration: InputDecoration(labelText: 'Name'),
                controller: TextEditingController(text: currentName),
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
                  updateItem(
                      index, newName, newPhone, newDescription, newLocation);
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
