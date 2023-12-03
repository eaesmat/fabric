import 'package:fabricproject/models/customer.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
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
            'http://10.0.2.2:8000/api/update-customer?customer_id=${customerData![index].customerId}'),
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
          showSuccessMessage(context, 'Updated!', Colors.green);
        }
      });
    }
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:8000/api/getCustomer'));

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
        'http://10.0.2.2:8000/api/delete-customer?customer_id=${customerData![index].customerId}'));

    if (response.statusCode == 500) {
      setState(() {
        showSuccessMessage(context, 'Has children!', Colors.red);
      });
    } else if (response.statusCode == 200) {
      setState(() {
        customerData!.removeAt(index);
        showSuccessMessage(context, 'Deleted!', Colors.green);
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
        Uri.parse('http://10.0.2.2:8000/api/add-customer'),
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
                      data.photo.toString(),
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
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.pop(context);
                  showEditDialog(index, currentFirstName, currentLastName,
                      currentPhoto, currentAddress);
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
                TextField(
                  onChanged: (value) => newFirstName = value,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                TextField(
                  onChanged: (value) => newLastName = value,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
                TextField(
                  onChanged: (value) => newPhoto = value,
                  decoration: InputDecoration(labelText: 'Photo'),
                ),
                TextField(
                  onChanged: (value) => newAddress = value,
                  decoration: InputDecoration(labelText: 'Address'),
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
                    addNewItem(newFirstName, newLastName, newPhoto, newAddress);
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => newFirstName = value,
                decoration: InputDecoration(labelText: 'First Name'),
                controller: TextEditingController(text: currentFirstName),
              ),
              TextField(
                onChanged: (value) => newLastName = value,
                decoration: InputDecoration(labelText: 'Last Name'),
                controller: TextEditingController(text: currentLastName),
              ),
              TextField(
                onChanged: (value) => newPhoto = value,
                decoration: InputDecoration(labelText: 'Photo'),
                controller: TextEditingController(text: currentPhoto),
              ),
              TextField(
                onChanged: (value) => newAddress = value,
                decoration: InputDecoration(labelText: 'Address'),
                controller: TextEditingController(text: currentAddress),
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
                      index, newFirstName, newLastName, newPhoto, newAddress);
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
