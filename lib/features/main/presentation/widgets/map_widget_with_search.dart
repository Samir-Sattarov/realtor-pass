import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../app_core/app_core_library.dart';
import 'google_map_widget.dart';
import 'search_widget.dart';

class MapWidgetWithSearch extends StatefulWidget {
  final List<LocationEntity> houseLocations;
  final Function(LocationEntity location) onChanged;
  const MapWidgetWithSearch({super.key, required this.onChanged, required this.houseLocations});

  @override
  State<MapWidgetWithSearch> createState() => _MapWidgetWithSearchState();
}

class _MapWidgetWithSearchState extends State<MapWidgetWithSearch> {
  final TextEditingController controllerSearch = TextEditingController();
  final GlobalKey<GoogleMapWidgetState> _mapKey =
      GlobalKey<GoogleMapWidgetState>();
  final places = GoogleMapsPlaces(apiKey: ApiConstants.googleMapsKey);

  late UseDebounce debounce;
  LocationEntity locationEntity = LocationEntity.empty();
  late List<Prediction> locations;
  @override
  void initState() {
    locations = [];
    debounce = UseDebounce(milliseconds: 250);
    super.initState();
  }

  Future<void> _handleTap(
    LocationEntity entity) async {
    try {
        locationEntity = entity;

        widget.onChanged.call(locationEntity);
      LatLng newPosition = LatLng(locationEntity.lat, locationEntity.lon);

      _mapKey.currentState!.moveCamera(newPosition);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('errorOccurredWhileSearching'.tr()),
        ),
      );
    }
  }

  Future<List<LocationEntity>> suggestionsCallback(String pattern) async {
    try {
      if (pattern.isEmpty) return [];

      final response = await places.autocomplete(pattern);
      final predictions = response.predictions;

      final List<LocationEntity> results = [];
      for (var prediction in predictions) {
        final entity = await getLocationDetails(prediction.placeId!);
        results.add(entity);
      }

      return results;
    } catch (e) {
      log("Error in suggestionsCallback: $e");
      return [];
    }
  }

  Future<LocationEntity> getLocationDetails(String placeId) async {
    try {
      final details = await places.getDetailsByPlaceId(placeId);
      final geometry = details.result.geometry;

      if (geometry != null) {
        final location = geometry.location;
        final viewport = geometry.viewport!;

        return LocationEntity(
          lat: location.lat,
          lon: location.lng,
          north: viewport.northeast.lat,
          south: viewport.southwest.lat,
          east: viewport.northeast.lng,
          west: viewport.southwest.lng,
          address: details.result.formattedAddress ?? '',
        );
      } else {
        throw Exception('Geometry data is missing');
      }
    } catch (e) {
      log('Error getting location details: $e');
      return LocationEntity.empty();
    }
  }

  Future<void> _handleSearch(String value) async {
    if (value.isEmpty) {
      return;
    }
    debounce.run(
      () async {
        if (value.isNotEmpty) {
          try {
            final response = await places.autocomplete(value);

            locations =
                response.predictions.map((prediction) => prediction).toList();
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('errorOccurredWhileSearching'.tr()),
              ),
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchWidget<LocationEntity>(
          controller: controllerSearch,
          hintText: "enterLocation".tr(),
          onSearch: _handleSearch,
          onSelect: _handleTap,
          suggestionsCallback: suggestionsCallback,
          itemBuilder: (BuildContext context, LocationEntity location) {
            return Container(
              padding: EdgeInsets.all(8.r),
              child: Text(location.address),
            );
          },
        ),
        SizedBox(height: 15.h),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: GoogleMapWidget(

              locations: widget.houseLocations,
              key: _mapKey,
              onAddressSelected: _handleTap,
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
