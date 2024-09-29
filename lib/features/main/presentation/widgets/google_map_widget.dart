import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class GoogleMapWidget extends StatefulWidget {
  final Function(String address)? onAddressSelected;
  const GoogleMapWidget({super.key, this.onAddressSelected});

  @override
  State<GoogleMapWidget> createState() => GoogleMapWidgetState();
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  GoogleMapController? mapController;
  Marker? selectedMarker;
  String? address;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
      onTap: _handleTap,
      markers: selectedMarker != null ? {selectedMarker!} : {},
    );
  }

  Future<void> _handleTap(LatLng position) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      String formattedAddress =
          "${placemark.name}, ${placemark.locality}, ${placemark.country}";

      setState(() {
        address = formattedAddress;
        selectedMarker = Marker(
          markerId: const MarkerId('selected_location'),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue),
        );
      });

      if (widget.onAddressSelected != null) {
        widget.onAddressSelected!(formattedAddress);
      }
    }
  }

  void moveCamera(LatLng position) {
    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(position, 14.0),
    );
    _handleTap(position);
  }
}
