import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  final bool fullScreen;
  const MapWidget({super.key, this.fullScreen = false});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
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
                        child: Icon(Icons.add),
                        onTap: () {
                          mapController.move(
                            mapController.center,
                            mapController.zoom + 1,
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      _button(
                        child: Icon(Icons.remove),
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
