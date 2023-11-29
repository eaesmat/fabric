import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fabricproject/models/internal_companies_model.dart';

class InternalCompanies extends StatefulWidget {
  const InternalCompanies({Key? key}) : super(key: key);

  @override
  _InternalCompaniesState createState() => _InternalCompaniesState();
}

class _InternalCompaniesState extends State<InternalCompanies> {
  List<Data>? companyData;
  bool _addingNewItem = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> updateItem(
      int index, String newName, String newMarka, String newDescription) async {
    setState(() {
      _addingNewItem = true;
    });

    try {
      final response = await http.put(
        Uri.parse(
            'http://10.0.2.2:8000/api/update-company?company_id=${companyData![index].companyId}'),
        body: json.encode({
          'companyId': companyData![index].companyId,
          'name': newName,
          'marka': newMarka,
          'description': newDescription,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        fetchData(); // Refresh the data after updating an item
      } else {
        throw Exception('Failed to update item');
      }
    } catch (e) {
      // Handle exceptions here if needed
    } finally {
      setState(() {
        _addingNewItem = false;
      });
    }
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/getCompany'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final internalCompany = InternalCompany.fromJson(jsonResponse);

      setState(() {
        companyData = internalCompany.data;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> deleteItem(int index) async {
    final response = await http.delete(Uri.parse(
        'http://10.0.2.2:8000/api/delete-company?company_id=${companyData![index].companyId}'));

    if (response.statusCode == 500) {
    } else if (response.statusCode == 200) {
      setState(() {
        companyData!.removeAt(index);
      });
    } else {
      throw Exception('Failed to delete item');
    }
  }

  Future<void> addNewItem(String name, String marka, String description) async {
    setState(() {
      _addingNewItem = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/add-company'),
        body: json.encode({
          'companyId': 0,
          'name': name,
          'marka': marka,
          'description': description,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        fetchData(); // Refresh the data after adding a new item
      } else {
        throw Exception('Failed to add item');
      }
    } catch (e) {
      // Handle exceptions here if needed
    } finally {
      setState(() {
        _addingNewItem = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App Title'),
      ),
      body: companyData == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: companyData!.length,
              itemBuilder: (context, index) {
                final data = companyData![index];

                return ListTileWidget(
                  lead: CircleAvatar(
                    child: Text(
                      data.marka.toString(),
                    ),
                  ),
                  tileTitle: Text(
                    data.name.toString(),
                  ),
                  tileSubTitle: Text(
                    data.description.toString(),
                  ),
                  trail: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => showEditDialog(
                            index,
                            data.name.toString(),
                            data.marka.toString(),
                            data.description.toString()),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteItem(index),
                      ),
                    ],
                  ),
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
              onPressed: addItem,
              tooltip: 'Add Item',
              child: const Icon(Icons.add),
            ),
    );
  }

  Future<void> addItem() async {
    String newName = '';
    String newMarka = '';
    String newDescription = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => newName = value,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                onChanged: (value) => newMarka = value,
                decoration: InputDecoration(labelText: 'Marka'),
              ),
              TextField(
                onChanged: (value) => newDescription = value,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform the add operation with the entered data
                addNewItem(newName, newMarka, newDescription);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showEditDialog(int index, String currentName,
      String currentMarka, String currentDescription) async {
    String newName = currentName;
    String newMarka = currentMarka;
    String newDescription = currentDescription;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => newName = value,
                decoration: InputDecoration(labelText: 'Name'),
                controller: TextEditingController(text: currentName),
              ),
              TextField(
                onChanged: (value) => newMarka = value,
                decoration: InputDecoration(labelText: 'Marka'),
                controller: TextEditingController(text: currentMarka),
              ),
              TextField(
                onChanged: (value) => newDescription = value,
                decoration: InputDecoration(labelText: 'Description'),
                controller: TextEditingController(text: currentDescription),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform the update operation with the entered data
                updateItem(index, newName, newMarka, newDescription);
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
