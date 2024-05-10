// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:EvNav/Screens/CarSelection/detailsScreen.dart';
import 'package:flutter/material.dart';

class EvPortSelectionScreen extends StatefulWidget {
  final String selectedManufacturer;
  final String selectedModel;

  const EvPortSelectionScreen(
      {required this.selectedManufacturer, required this.selectedModel});

  //get selectedPortType => null;

  @override
  _EvPortSelectionScreenState createState() => _EvPortSelectionScreenState();
}

class _EvPortSelectionScreenState extends State<EvPortSelectionScreen> {
  List<String> evPortTypes = [
    'Type 1',
    'Type 2',
    'CHAdeMO',
    'CCS',
    'Tesla Supercharger',
  ];

  String selectedPortType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120.0, // Adjust the height as needed
        title: const Text(
          'Select EV Port Type',
          style: TextStyle(color: Colors.blueAccent, fontSize: 26),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            // Image portion at the top
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/charging-station_5396703.png'), // Add your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Chip portion
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select EV Port Type:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: evPortTypes.map((portType) {
                        return ChoiceChip(
                          label: Text(
                            portType,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.black,
                          selected: selectedPortType == portType,
                          onSelected: (selected) {
                            setState(() {
                              selectedPortType = selected ? portType : '';
                            });
                          },
                          selectedColor: Colors.blue,
                          labelStyle: const TextStyle(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Selected Port Type: ',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        Text(
                          selectedPortType.isEmpty ? 'None' : selectedPortType,
                          style: TextStyle(
                              fontSize: 16,
                              color: selectedPortType.isNotEmpty
                                  ? Colors.blue
                                  : Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add your logic when the "Select" button is pressed
                            if (selectedPortType.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    selectedManufacturer:
                                        widget.selectedManufacturer,
                                    selectedModel: widget.selectedModel,
                                    selectedPortType: selectedPortType,
                                  ),
                                ),
                              );
                              // Handle the selection
                            } else {
                              // No port type selected, show a message or perform an action
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: selectedPortType.isNotEmpty
                                ? MaterialStateProperty.all(Colors.blue)
                                : MaterialStateProperty.all(Colors.grey),
                            overlayColor:
                                MaterialStateProperty.all(Colors.blue),
                            side: MaterialStateProperty.all(
                                const BorderSide(color: Colors.blue, width: 2)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('Select',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                                SizedBox(
                                    width:
                                        5.0), // Add space between text and icon
                                Icon(Icons.arrow_forward, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
