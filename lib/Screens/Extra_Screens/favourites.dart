// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:EvNav/Providers/chData.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black, // Black background for the body
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black, // Black background
                  child: const Text(
                    'Favourite Charging Stations', // Text "your cs" above the cards
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // Blue font color
                      fontSize: 26,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1, // Adjust thickness as needed
                  color: Colors.grey, // Set color
                  indent: 20.0, // Left padding
                  endIndent: 20.0, // Right padding
                ),
                Expanded(
                  child: Consumer<chDataProvider>(
                    builder: (context, dataProvider, child) {
                      if (dataProvider.favStations.entries.isEmpty) {
                        // If favourites list is empty, show image with text
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/charging-station_5396371.png', // Path to your image asset
                                height: 250,
                                width: 250,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "No Favs? Find Your Charge!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // If there are favourites, show the list
                        return Expanded(
                            child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: dataProvider.favStations.entries.length,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
                                child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.black, // Grey color for the card
                                border: Border.all(
                                    color: Colors.blue,
                                    width: 0.75), // Blue border
                                borderRadius:
                                    BorderRadius.circular(8), // Rounded corners
                              ),
                              child: Card(
                                elevation:
                                    0, // No elevation to avoid shadow overlap
                                color: Colors
                                    .transparent, // Transparent color for the card
                                child: ListTile(
                                  title: Text(
                                    dataProvider.favStations.entries
                                        .elementAt(index)
                                        .value['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white, // White text color
                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on,
                                              color:
                                                  Colors.red), // Location icon
                                          const SizedBox(width: 4),
                                          Flexible(
                                            child: Text(
                                              dataProvider.favStations.entries
                                                  .elementAt(index)
                                                  .value['address'],
                                              style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white70,
                                                fontSize: 14,
                                                // White text color
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.attach_money,
                                              color: Colors.green), // Cost icon
                                          const SizedBox(width: 4),
                                          Text(
                                            'Cost: \Rs ${dataProvider.favStations.entries.elementAt(index).value['cost'].toStringAsFixed(2)} /kwh',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                          },
                        ));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
