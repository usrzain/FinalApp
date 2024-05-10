// ignore_for_file: unnecessary_import, use_key_in_widget_constructors, library_private_types_in_public_api, non_constant_identifier_names, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:EvNav/Auth/HomePage.dart';
import 'package:EvNav/Providers/chData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final String selectedManufacturer;
  final String selectedModel;
  final String selectedPortType;

  const DetailsScreen({
    required this.selectedManufacturer,
    required this.selectedModel,
    required this.selectedPortType,
  });

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late String additionalDetails = '';

  get selectedPortType => null;

  @override
  void initState() {
    super.initState();
    // Fetch details if needed
    // fetchDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120.0, // Adjust the height as needed
        title: const Text(
          'Selected EV',
          style: TextStyle(color: Colors.blueAccent, fontSize: 26),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.blue, width: 0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' Brand: ${widget.selectedManufacturer}',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    ' Model: ${widget.selectedModel}',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    ' Port: ${widget.selectedPortType}',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 200),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.0), // Add padding to button
                    ),
                    child: const Row(
                      // Wrap content in a Row
                      mainAxisSize: MainAxisSize.min, // Minimize row size
                      children: [
                        Icon(Icons.arrow_back, color: Colors.white),
                        SizedBox(width: 5.0),
                        Text(
                          'Back',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        // Add space between text and icon
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      successAlertAndNavigate();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.0), // Add padding to button
                    ),
                    child: const Row(
                      // Wrap content in a Row
                      mainAxisSize: MainAxisSize.min, // Minimize row size
                      children: [
                        Text(
                          'Select',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(width: 5.0), // Add space between text and icon
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void successAlertAndNavigate() async {
    Provider.of<chDataProvider>(context, listen: false).defaultBrand =
        widget.selectedManufacturer;
    Provider.of<chDataProvider>(context, listen: false).defaultModel =
        widget.selectedModel;

    String Email =
        Provider.of<chDataProvider>(context, listen: false).userEmail!;

    // Setting the choosen data to user's DB in Firebase

    addUserDefaults(Email, widget.selectedManufacturer, widget.selectedModel);
    // Navigate to the next screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  // Function to add defaultBrand and defaultModel to a user document
  Future<void> addUserDefaults(
      String userEmail, String defaultBrand, String defaultModel) async {
    // Get a reference to the Firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      // Query for the document with the specified email
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: userEmail).get();

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document per email, get the reference to that document
        DocumentReference userDocRef = querySnapshot.docs.first.reference;

        // Update the document with defaultBrand and defaultModel fields
        await userDocRef.update({
          'defaultBrand': defaultBrand,
          'defaultModel': defaultModel,
        });
      } else {}
    } catch (e) {}
  }
}
