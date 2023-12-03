import 'package:fabricproject/models/fabric_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FabricScreen extends StatefulWidget {
  const FabricScreen({Key? key}) : super(key: key);

  @override
  _FabricScreenState createState() => _FabricScreenState();
}

class _FabricScreenState extends State<FabricScreen> {
  List<Data>? fabricData;
  bool _addingNewItem = false;
  bool _updated = false;
  bool _added = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> updateItem(
      int index, String newName, String newAbr, String newDescription) async {
    setState(() {
      _addingNewItem = true;
    });

    try {
      final response = await http.put(
        Uri.parse(
            'http://10.0.2.2:8000/api/update-fabric?fabric_id=${fabricData![index].fabricId}'),
        body: json.encode({
          'fabric_Id': fabricData![index].fabricId,
          'name': newName,
          'abr': newAbr,
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
        await http.get(Uri.parse('http://10.0.2.2:8000/api/getFabric'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final fabric = Fabric.fromJson(jsonResponse);

      setState(() {
        fabricData = fabric.data;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> deleteItem(int index) async {
    final response = await http.delete(Uri.parse(
        'http://10.0.2.2:8000/api/delete-fabric?fabric_id=${fabricData![index].fabricId}'));

    if (response.statusCode == 500) {
      setState(() {
        showSuccessMessage(context, 'Has children!', Colors.red);
      });
    } else if (response.statusCode == 200) {
      setState(() {
        fabricData!.removeAt(index);
        showSuccessMessage(context, 'Deleted!', Colors.green);
      });
    } else {
      throw Exception('Failed to delete item');
    }
  }

  Future<void> addNewItem(String name, String abr, String description) async {
    setState(() {
      _addingNewItem = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/add-fabric'),
        body: json.encode({
          'companyId': 0,
          'name': name,
          'abr': abr,
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
      body: fabricData == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Pallete.blueColor,
              ),
            )
          : ListView.builder(
              itemCount: fabricData!.length,
              itemBuilder: (context, index) {
                final data = fabricData![index];

                return ListTileWidget(
                  lead: CircleAvatar(
                    backgroundColor: Pallete.blueColor,
                    child: Text(
                      data.abr.toString(),
                      style: const TextStyle(color: Pallete.whiteColor),
                    ),
                  ),
                  tileTitle: Text(
                    data.name.toString(),
                  ),
                  tileSubTitle: Text(
                    data.description.toString(),
                  ),
                  onLongPress: () {
                    showLongPressDialog(
                      index,
                      data.name.toString(),
                      data.abr.toString(),
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
      String currentAbr, String currentDescription) async {
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
                      index, currentName, currentAbr, currentDescription);
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
    String newAbr = '';
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
                onChanged: (value) => newAbr = value,
                decoration: InputDecoration(labelText: 'Abr'),
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
                  addNewItem(newName, newAbr, newDescription);
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
      String currentAbr, String currentDescription) async {
    String newName = currentName;
    String newAbr = currentAbr;
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
                onChanged: (value) => newAbr = value,
                decoration: InputDecoration(labelText: 'Abr'),
                controller: TextEditingController(text: newAbr),
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
                  updateItem(index, newName, newAbr, newDescription);
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
