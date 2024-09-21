import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../core/entity/house_post_entity.dart';
import '../screens/house_post_location_screen.dart';

class ImagePickerExample extends StatefulWidget {
  final HousePostEntity postEntity;
  final Function(List<File>)? onImageSelected;

  const ImagePickerExample(
      {super.key, required this.postEntity, this.onImageSelected});

  @override
  State<ImagePickerExample> createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  final List<File> selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImagesFromGallery() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: 50,
      );

      if (images.isNotEmpty) {
        setState(() {
          selectedImages.addAll(images.map((image) => File(image.path)));
        });
        widget.onImageSelected?.call(selectedImages);
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Future<void> takePhotoWithCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );

      if (image != null) {
        setState(() {
          selectedImages.add(File(image.path));
        });
        widget.onImageSelected?.call(selectedImages);
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Widget buildImageList() {
    if (selectedImages.isEmpty) {
      return Center(
        child: Text('pleaseSelectPhotos'.tr()),
      );
    } else {
      return ListView.builder(
        itemCount: selectedImages.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            height: 200.h,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.file(
                    selectedImages[index],
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedImages.removeAt(index);
                      });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

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
                "addSomePhoto".tr(),
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
                "youNeed5Photos".tr(),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonWidget(
                      onTap: pickImagesFromGallery, title: 'gallery'.tr()),
                  SizedBox(
                    height: 10.h,
                  ),
                  ButtonWidget(
                      onTap: takePhotoWithCamera, title: 'camera'.tr()),
                ],
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: buildImageList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_outlined)),
                  SizedBox(
                    width: 100.w,
                    child: ButtonWidget(
                      title: "next".tr(),
                      onTap: () {
                        final updatedPostEntity =
                            widget.postEntity.copyWith(images: selectedImages);
                        if (selectedImages.length != 5) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("error".tr()),
                                content: Text("Please select at least 5 photos".tr()),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      "OK",
                                      style: TextStyle(color: Colors.black, fontSize: 12.sp),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Dismiss the dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          AnimatedNavigation.push(
                            context: context,
                            page: HousePostLocationScreen(
                              entity: updatedPostEntity,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
