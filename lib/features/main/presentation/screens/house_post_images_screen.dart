import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/utils/bottom_sheets/bottom_sheets.dart';
import '../../../../app_core/utils/bottom_sheets/fav_conditions_body.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../../../app_core/widgets/error_flash_bar.dart';
import '../../../../app_core/widgets/loading_widget.dart';
import '../../core/entity/house_post_entity.dart';
import '../cubit/upload_photos/upload_photos_cubit.dart';
import 'house_post_screen.dart';

class HousePostImagesScreen extends StatefulWidget {
  final HousePostEntity postEntity;

  const HousePostImagesScreen({super.key, required this.postEntity});

  @override
  State<HousePostImagesScreen> createState() => _HousePostImagesScreenState();
}

class _HousePostImagesScreenState extends State<HousePostImagesScreen> {
  final List<File> selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  _HousePostImagesScreenState();

  Future<void> pickImagesFromGallery() async {
    final images = await _picker.pickMultiImage(imageQuality: 50);
    if (images != null) {
      setState(() {
        selectedImages.addAll(images.map((image) => File(image.path)));
      });
    }
  }

  Future<void> takePhotoWithCamera() async {
    final image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      setState(() {
        selectedImages.add(File(image.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("addPhotos").tr()),
      body: BlocConsumer<UploadPhotosCubit, UploadPhotosState>(
        listener: (context, state) {
          if (state is UploadPhotosSuccess) {
            final entity = widget.postEntity.copyWith(images: state.result);
            AnimatedNavigation.push(
                context: context, page: HousePostScreen(entity: entity));
          }

          if (state is UploadPhotosError) {
            ErrorFlushBar(state.messsage).show(context);
          }
        },
        builder: (context, state) {
          if (state is UploadPhotosLoading) {
            return const Center(child: LoadingWidget());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        title: "pick".tr(),
                        onTap: pickImagesFromGallery,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ButtonWidget(
                        title: "takePhoto",
                        onTap: takePhotoWithCamera,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: selectedImages.isEmpty
                      ? const Center(child: Text("No image selected"))
                      : ListView.builder(
                          itemCount: selectedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Image.file(selectedImages[index],
                                    fit: BoxFit.cover),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => setState(
                                        () => selectedImages.removeAt(index)),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
                ButtonWidget(
                  title: "next".tr(),
                  onTap: () {
                    if (selectedImages.isNotEmpty) {
                      context.read<UploadPhotosCubit>().upload(selectedImages);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select images")),
                      );
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
