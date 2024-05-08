// ignore_for_file: prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChargingStationAssignmentWidget extends StatefulWidget {
  @override
  _ChargingStationAssignmentState createState() =>
      _ChargingStationAssignmentState();
}

class _ChargingStationAssignmentState
    extends State<ChargingStationAssignmentWidget> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  Set<Polyline> polylinesSet = {};

  @override
  Widget build(BuildContext context) {
    return ChargingStationAssignmentBody(_controller, markers, polylinesSet);
  }
}

class ChargingStationAssignmentBody extends StatelessWidget {
  final Completer<GoogleMapController> _controller;
  final Set<Marker> markers;
  final Set<Polyline> polylinesSet;

  const ChargingStationAssignmentBody(
      this._controller, this.markers, this.polylinesSet);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charging Station Assignment'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
        polylines: polylinesSet,
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 1,
        ),
      ),
    );
  }
}
