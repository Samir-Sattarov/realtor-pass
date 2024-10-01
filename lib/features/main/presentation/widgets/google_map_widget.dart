import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:realtor_pass/app_core/app_core_library.dart';

class LocationEntity {
  final double lat;
  final double lon;
  final double east;
  final double west;
  final double north;
  final double south;
  final String address;

  LocationEntity({
    required this.lat,
    required this.lon,
    required this.east,
    required this.west,
    required this.north,
    required this.south,
    required this.address,
  });
}

class GoogleMapWidget extends StatefulWidget {
  final Function(LocationEntity entity)? onAddressSelected;
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
  void initState() {
    moveToUseLocation();

    super.initState();
  }

  moveToUseLocation() async {
    final location = await _getCurrentUserLocation();
    await mapController!.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 20,
          target: LatLng(
            location.latitude,
            location.longitude,
          ),
        ),
      ),
    );
  }

  Future<Position> _getCurrentUserLocation() async {
    PermissionStatus permission = await _requestLocation();

    while (permission == PermissionStatus.denied) {
      permission = await _requestLocation();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error permission to get current location not allowed'),
        ),
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<PermissionStatus> _requestLocation() async {
    final PermissionStatus status = await Permission.location.request();

    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
            setState(() {});
          },
          onTap: _handleTap,
          markers: selectedMarker != null ? {selectedMarker!} : {},
        ),
        if (mapController != null)
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _button(
                Icons.location_on_outlined,
                () async {
                  await moveToUseLocation();
                },
              ),
            ),
          ),
        if (mapController != null)
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _button(
                    Icons.add,
                    () {
                      mapController?.animateCamera(
                        CameraUpdate.zoomIn(),
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                  _button(
                    Icons.remove,
                    () {
                      mapController?.animateCamera(
                        CameraUpdate.zoomOut(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  _button(IconData icon, Function() onTap) {
    final borderRadius = BorderRadius.circular(14.r);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.shade300,
        borderRadius: borderRadius,
        onTap: onTap,
        child: Ink(
          height: 45.r,
          width: 40.r,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
          ),
          child: Center(
              child: Icon(
            icon,
            color: AppStyle.dark,
          )),
        ),
      ),
    );
  }

  Future<void> _handleTap(LatLng position) async {
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placeMarks.isNotEmpty) {
      Placemark placeMark = placeMarks.first;
      String formattedAddress =
          "${placeMark.name}, ${placeMark.locality}, ${placeMark.country}";

      LatLngBounds visibleRegion = await mapController!.getVisibleRegion();

      setState(() {
        address = formattedAddress;
        selectedMarker = Marker(
          markerId: const MarkerId('selected_location'),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          ),
        );
      });

      if (widget.onAddressSelected != null) {
        LatLngBounds bounds = visibleRegion;
        double north = bounds.northeast.latitude;
        double south = bounds.southwest.latitude;
        double west = bounds.southwest.longitude;
        double east = bounds.northeast.longitude;
        final entity = LocationEntity(
            lat: position.latitude,
            lon: position.longitude,
            east: east,
            west: west,
            north: north,
            south: south,
            address: address ?? "");
        widget.onAddressSelected!(entity);
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
