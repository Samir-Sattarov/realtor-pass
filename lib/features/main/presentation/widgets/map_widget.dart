import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:collection/collection.dart';

import '../../core/entity/house_entity.dart';
import 'card_description_widget.dart';

class MapWidget extends StatefulWidget {
  final bool fullScreen;
  final List<HouseEntity> houses;

  const MapWidget({
    super.key,
    this.fullScreen = false,
    required this.houses,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final List<Marker> _markers = [];

  late MapOptions options;
  late MapController mapController;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() {
    mapController = MapController();
    options = const MapOptions(
      initialZoom: 10,
      initialCenter: LatLng(39.65, 66.97),
      keepAlive: true,
    );

    _setMarkers();
  }

  _setMarkers() {
    for (var house in widget.houses) {
      final lat = extractLat(house.houseLocation);
      final lon = extractLon(house.houseLocation);
      _markers.add(
        Marker(
          point: LatLng(lat, lon),
          width: 18.r,
          height: 18.r,
          child: Container(
            width: 18.r,
            height: 18.r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff0066FF),
            ),

            child: Center(
              child: Container(
                margin: EdgeInsets.all(3.5.r),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff0054D3),
                ),
              ),
            ),
          ),
        ),
      );
    }
    // _markers.add(
    //   Marker(
    //     point: const LatLng(39.65, 66.97),
    //     width: 18.r,
    //     height: 18.r,
    //     child: Container(
    //       width: 18.r,
    //       height: 18.r,
    //       decoration: const BoxDecoration(
    //         shape: BoxShape.circle,
    //         color: Color(0xff0066FF),
    //       ),
    //       child: Center(
    //         child: Container(
    //           margin: EdgeInsets.all(3.5.r),
    //           decoration: const BoxDecoration(
    //             shape: BoxShape.circle,
    //             color: Color(0xff0054D3),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  double extractLat(String coordinates) {
    List<String> parts = coordinates.split(';');

    if (parts.length == 2) {
      double lat = double.tryParse(parts[0].trim()) ?? 0.0;
      return lat;
    } else {
      return 0.0;
    }
  }

  double extractLon(String coordinates) {
    List<String> parts = coordinates.split(';');

    if (parts.length == 2) {
      double lon = double.tryParse(parts[1].trim()) ?? 0.0;
      return lon;
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.fullScreen ? 1.sh : 243.h,
      width: widget.fullScreen ? 1.sw : 350.w,
      child: Center(
        child: FlutterMap(
          options: options,
          mapController: mapController,
          children: [
            TileLayer(
              retinaMode: true,
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            PopupMarkerLayer(
              options: PopupMarkerLayerOptions(
                markers: _markers,
                popupDisplayOptions: PopupDisplayOptions(
                  builder: (BuildContext context, Marker marker) {

                    final house = widget.houses.firstWhereOrNull((element) {
                      final lat = extractLat(element.houseLocation);
                      final lon = extractLon(element.houseLocation);

                      return (marker.point.latitude == lat &&
                          marker.point.longitude == lon);
                    });



                    if(house == null) return const SizedBox();

                    return CardDescriptionWidget(marker: marker, house: house);
                  },
                ),
              ),
            ),
            MarkerLayer(
              markers: _markers,
            ),
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // _button(
                  //   child: Icon(Icons.add),
                  //   onTap: () {},
                  // ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _button(
                        child: const Icon(Icons.add),
                        onTap: () {
                          mapController.move(
                            mapController.center,
                            mapController.zoom + 1,
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      _button(
                        child: const Icon(Icons.remove),
                        onTap: () {
                          mapController.move(
                            mapController.center,
                            mapController.zoom - 1,
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _button({required Widget child, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.r,
        width: 40.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
