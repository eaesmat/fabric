import 'package:fabricproject/models/transport_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TransportScreen extends StatefulWidget {
  const TransportScreen({Key? key}) : super(key: key);

  @override
  _TransportScreenState createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  List<Data>? transportData;
  bool _addingNewItem = false;
  bool _updated = false;
  bool _added = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> updateItem(
      int index, String newName, String newPhone, String newDescription) async {
    setState(() {
      _addingNewItem = true;
    });

    try {
      final response = await http.put(
        Uri.parse(
            'http://10.0.2.2:8000/api/update-transport?transport_id=${transportData![index].transportId}'),
        body: json.encode({
          'transport_id': transportData![index].transportId,
          'name': newName,
          'phone': newPhone,
          'description': newDescription,
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
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/getTransport'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final transport = Transport.fromJson(jsonResponse);

      setState(() {
        transportData = transport.data;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> deleteItem(int index) async {
    final response = await http.delete(Uri.parse(
        'http://10.0.2.2:8000/api/delete-transport?transport_id=${transportData![index].transportId}'));

    if (response.statusCode == 500) {
      setState(() {
        showSuccessMessage(context, 'Has children!', Colors.red);
      });
    } else if (response.statusCode == 200) {
      setState(() {
        transportData!.removeAt(index);
        showSuccessMessage(context, 'Deleted!', Colors.green);
      });
    } else {
      throw Exception('Failed to delete item');
    }
  }

  Future<void> addNewItem(String name, String phone, String description) async {
    setState(() {
      _addingNewItem = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/add-transport'),
        body: json.encode({
          'transport_Id': 0,
          'name': name,
          'phone': phone,
          'description': description,
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
      body: transportData == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Pallete.blueColor,
              ),
            )
          : ListView.builder(
              itemCount: transportData!.length,
              itemBuilder: (context, index) {
                final data = transportData![index];

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
                  tileSubTitle: Text(
                    data.description.toString(),
                  ),
                  onLongPress: () {
                    showLongPressDialog(
                      index,
                      data.name.toString(),
                      data.phone.toString(),
                      data.description.toString(),
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

  Future<void> showLongPressDialog(int index, String currentName,
      String currentPhone, String currentDescription) async {
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
                  showEditDialog(
                      index, currentName, currentPhone, currentDescription);
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
    String newPhone = '';
    String newDescription = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          // title: Text('Add New Item'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => newName = value,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                onChanged: (value) => newPhone = value,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                onChanged: (value) => newDescription = value,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Perform the add operation with the entered data
                  addNewItem(newName, newPhone, newDescription);
                  Navigator.pop(context);
                },
                child: Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showEditDialog(int index, String currentName,
      String currentPhone, String currentDescription) async {
    String newName = currentName;
    String newPhone = currentPhone;
    String newDescription = currentDescription;

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
                decoration: InputDecoration(labelText: 'Phone'),
                controller: TextEditingController(text: currentPhone),
              ),
              TextField(
                onChanged: (value) => newDescription = value,
                decoration: InputDecoration(labelText: 'Description'),
                controller: TextEditingController(text: currentDescription),
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
                  updateItem(index, newName, newPhone, newDescription);
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