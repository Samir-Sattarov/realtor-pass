import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../../../app_core/widgets/error_flash_bar.dart';
import '../../../../app_core/widgets/text_form_field_widget.dart';
import '../../core/entity/house_post_entity.dart';
import '../cubit/post_house/house_post_cubit.dart';
import '../widgets/google_map_widget.dart';
import 'house_post_selling_type_screen.dart';

class HousePostLocationScreen extends StatefulWidget {
  final HousePostEntity entity;
  final LocationEntity? locationEntity;

  const HousePostLocationScreen({
    super.key,
    required this.entity,
    this.locationEntity,
  });

  @override
  State<HousePostLocationScreen> createState() =>
      _HousePostLocationScreenState();
}

class _HousePostLocationScreenState extends State<HousePostLocationScreen> {
  final TextEditingController controllerSearch = TextEditingController();
  final UseDebounce debounce = UseDebounce(milliseconds: 300);
  final GlobalKey<GoogleMapWidgetState> _mapKey =
      GlobalKey<GoogleMapWidgetState>();
  String? selectedAddress;
  LocationEntity? selectedLocation;

  Future<void> _handleSearch(String value) async {
    debounce.run(
      () async {
        if (value.isNotEmpty) {
          try {
            final locations = await locationFromAddress(value);
            if (locations.isNotEmpty) {
              Location location = locations.first;
              LatLng newPosition =
                  LatLng(location.latitude, location.longitude);

              _mapKey.currentState!.moveCamera(newPosition);
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('addressNotFound'.tr())),
              );
            }
          } catch (e) {
            // ignore: use_build_context_synchronously
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
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<HousePostCubit, HousePostState>(
            listener: (context, state) {
              if (state is HousePostError) {
                ErrorFlushBar(state.message).show(context);
              }
              if (state is HousePostSuccessful) {
                AnimatedNavigation.push(
                  context: context,
                  page: HousePostSellingTypeScreen(
                    entity: widget.entity,
                  ),
                );
              }
            },
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
                  SizedBox(height: 5.h),
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
                  SizedBox(height: 10.h),
                  if (selectedAddress != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        selectedAddress!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  SizedBox(height: 15.h),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: GoogleMapWidget(
                        key: _mapKey,
                        onAddressSelected: (LocationEntity entity) {
                          setState(() {
                            selectedAddress = entity.address;
                            selectedLocation = entity;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
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
                          onTap: () {
                            if (selectedLocation != null) {
                              final updatedEntity = widget.entity.copyWith(
                                lat: selectedLocation!.lat,
                                lon: selectedLocation!.lon,
                                address: selectedLocation!.address,
                              );
                              AnimatedNavigation.push(
                                context: context,
                                page: HousePostSellingTypeScreen(
                                  entity: updatedEntity,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('pleaseSelectAddress'.tr()),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
