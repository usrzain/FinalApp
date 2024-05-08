// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, empty_catches

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'carModelSelection.dart';

class CarSelection extends StatefulWidget {
  @override
  _CarSelectionState createState() => _CarSelectionState();
}

class _CarSelectionState extends State<CarSelection> {
  late TextEditingController searchController;
  List<String> vehicleData = ['BMW', 'Honda', 'Tesla'];
  String _selectedManufacturer = "";

// Map car brands to their corresponding logo asset paths
  final Map<String, String> brandLogoPaths = {
    'BMW': 'assets/bmw.png',
    'Honda': 'assets/honda.png',
    'Tesla': 'assets/tesla.png',
  };

  @override
  void initState() {
    // fetchManufacturers();
    super.initState();
    searchController = TextEditingController();
  }

  void fetchManufacturers() async {
    try {
      QuerySnapshot manufacturersSnapshot =
          await FirebaseFirestore.instance.collection('manufacturer').get();
      List<String> tempManufacturers = manufacturersSnapshot.docs
          .map((doc) => doc['brand'].toString())
          .toList();

      setState(() {
        vehicleData = tempManufacturers;
      });
    } catch (e) {}
  }

  void searchManufacturer(String query) async {
    try {
      QuerySnapshot manufacturersSnapshot = await FirebaseFirestore.instance
          .collection('manufacturer')
          .where('brand', isGreaterThanOrEqualTo: query)
          .get();

      List<String> tempManufacturers = manufacturersSnapshot.docs
          .map((doc) => doc['brand'].toString())
          .toList();

      setState(() {
        vehicleData = tempManufacturers;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.0, // Adjust the height as needed
        title: const Text(
          'Select Manufacturers',
          style: TextStyle(color: Colors.blueAccent, fontSize: 26),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: vehicleData.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  indent: 12,
                  endIndent: 12,
                  thickness: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final brand = vehicleData[index];
                  final logoPath = brandLogoPaths[brand]; // Get logo path

                  return ListTile(
                    title: Row(
                      children: [
                        // Display logo if available
                        if (logoPath != null)
                          Image.asset(
                            logoPath,
                            width: 30,
                            height: 30,
                            //color: white,
                            fit: BoxFit.contain, // Adjust size as needed
                          ),
                        const SizedBox(
                            width: 10), // Add spacing between logo and text
                        Text(
                          brand,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Spacer(),
                        if (_selectedManufacturer == vehicleData[index])
                          const Icon(Icons.check, color: Colors.green),
                      ],
                    ),
                    selected: _selectedManufacturer == vehicleData[index],
                    selectedTileColor: Colors.blueAccent,
                    onTap: () {
                      setState(() {
                        _selectedManufacturer = vehicleData[index];
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(width: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_selectedManufacturer == "") {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.error,
                        text: "Please choose Vehicle brand",
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarModelSelection(
                            selectedManufacturer: _selectedManufacturer,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0), // Add padding to button
                  ),
                  child: const Row(
                    // Wrap content in a Row
                    mainAxisSize: MainAxisSize.min, // Minimize row size
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(width: 5.0), // Add space between text and icon
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
                //Spacer(), // Add spacer for some space before buttons
                const SizedBox(height: 120.0), // Adjust the height as needed
              ],
            ),
          ],
        ),
      ),
    );
  }
}
