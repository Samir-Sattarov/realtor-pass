import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart'; // Добавляем пакет geocoding
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../../../app_core/widgets/text_form_field_widget.dart';
import '../../core/entity/house_post_entity.dart';
import '../widgets/google_map_widget.dart';

class HousePostLocationScreen extends StatefulWidget {
  final HousePostEntity entity;
  const HousePostLocationScreen({super.key, required this.entity});

  @override
  State<HousePostLocationScreen> createState() =>
      _HousePostLocationScreenState();
}

class _HousePostLocationScreenState extends State<HousePostLocationScreen> {
  final TextEditingController controllerSearch = TextEditingController();
  final GlobalKey<GoogleMapWidgetState> _mapKey =
      GlobalKey<GoogleMapWidgetState>();
  String? selectedAddress;

  final UseDebounce debounce = UseDebounce(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "locationChoose".tr(),
                style: TextStyle(
                  fontSize: 21.sp,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "onlyGuestCanSeeLocation".tr(),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 10.h),
              TextFormFieldWidget(
                hintText: "search".tr(),
                controller: controllerSearch,
                prefixIcon: const Icon(Icons.search_rounded),
                onChanged: _handleSearch,
              ),
              SizedBox(
                height: 20.h,
              ),
              if (selectedAddress != null)
                Text(
                  selectedAddress!,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              SizedBox(height: 10.h),
              Expanded(
                flex: 10,
                child: GoogleMapWidget(
                  key: _mapKey,
                  onAddressSelected: (address) {
                    setState(() {
                      selectedAddress = address;
                    });
                  },
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_outlined),
                  ),
                  SizedBox(
                    width: 100.w,
                    child: ButtonWidget(
                      title: "next".tr(),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSearch(String value) async {
    debounce.run(
      ()async  {
        if (value.isNotEmpty) {
          try {
            // Получаем координаты из адреса
            List<Location> locations = await locationFromAddress(value);
            print(locations);
            if (locations.isNotEmpty) {
              Location location = locations.first;
              LatLng newPosition =
                  LatLng(location.latitude, location.longitude);

              // Перемещаем карту к новой позиции
              _mapKey.currentState?.moveCamera(newPosition);
            } else {
              // Обработка ситуации, когда адрес не найден
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Address not found')),
              );
            }
          } catch (e) {
            // Обработка ошибок геокодирования
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Error occurred while searching for address')),
            );
          }
        }
      },
    );
  }
}
