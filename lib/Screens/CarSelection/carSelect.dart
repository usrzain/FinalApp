// ignore_for_file: library_private_types_in_public_api

import 'package:EvNav/Screens/CarSelection/carSelection.dart';
import 'package:flutter/material.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

class CarSelect extends StatefulWidget {
  const CarSelect({Key? key}) : super(key: key);

  @override
  _CarSelectState createState() => _CarSelectState();
}

class _CarSelectState extends State<CarSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          //preferredSize: Size.fromHeight(80), // Adjust the height as needed
          AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150.0, // Adjust the height as needed
        backgroundColor: Colors.black,

        title: const Text(
          'Select Your Car',
          style: TextStyle(fontSize: 30, color: Colors.blueAccent),
        ),
        centerTitle: false, // Align title text to the center
      ),

      backgroundColor: Colors.black, // Set background color to black
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 110,
                  child: Center(
                    child: DefaultTextStyle(
                      style: TextStyle(
                          color: Colors.yellow[700],
                          fontSize: 30,
                          fontWeight: FontWeight.w300),
                      child: AnimatedTextKit(
                        repeatForever: false,
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Personalize your \n'
                            'experience by adding \n'
                            'your vehicle',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/electric-carSelect.png',
              // Replace with your image asset path
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.black,
                  //padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle next screen navigation
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => CarSelection()));
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
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            SizedBox(
                                width: 5.0), // Add space between text and icon
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
