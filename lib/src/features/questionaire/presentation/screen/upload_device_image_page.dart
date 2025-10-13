import 'dart:io';

import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_images_upload_cubit.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../shared/widgets/animated_button.dart';

class UploadDeviceImagePage extends StatelessWidget {
  const UploadDeviceImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DeviceImagesUploadCubit>();
    return SingleChildScrollView(
      child: BlocBuilder<DeviceImagesUploadCubit, DeviceImagesUploadState>(
        builder: (context, state) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            RegularText(
              textAlign: TextAlign.start,
              textSize: 16.sp,
              maxLines: 2,
              fontWeight: FontWeight.w600,
              textColor: AppColors.black,
              textOverflow: TextOverflow.ellipsis,
              text: "Upload device images",
            ),
            SizedBox(height: 8.h),
            RegularText(
              textAlign: TextAlign.start,
              textSize: 12.sp,
              maxLines: 2,
              fontWeight: FontWeight.w500,
              textColor: AppColors.borderBlack,
              textOverflow: TextOverflow.ellipsis,
              text: "Select the direction you wish to click image for",
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DeviceImageCard(
                  title: "Front",
                  image: "assets/images/question/mobile_front.png",
                  selectedImage: state.front,
                  onSelected: (image) {
                    cubit.frontImageChanged(image);
                  },
                ),
                DeviceImageCard(
                  title: "Back",
                  image: "assets/images/question/mobile_back.png",
                  selectedImage: state.back,
                  onSelected: (image) {
                    cubit.backImageChanged(image);
                  },
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DeviceImageCard(
                  title: "Left (from front)",
                  image: "assets/images/question/mobile_left.png",
                  selectedImage: state.left,
                  onSelected: (image) {
                    cubit.leftImageChanged(image);
                  },
                ),
                DeviceImageCard(
                  title: "Right (from front)",
                  image: "assets/images/question/mobile_right.png",
                  selectedImage: state.right,
                  onSelected: (image) {
                    cubit.rightImageChanged(image);
                  },
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DeviceImageCard(
                  title: "Top",
                  image: "assets/images/question/mobile_top.png",
                  selectedImage: state.top,
                  onSelected: (image) {
                    cubit.topImageChanged(image);
                  },
                ),
                DeviceImageCard(
                  title: "Bottom",
                  image: "assets/images/question/mobile_bottom.png",
                  selectedImage: state.bottom,
                  onSelected: (image) {
                    cubit.bottomImageChanged(image);
                  },
                ),
              ],
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}

class DeviceImageCard extends StatelessWidget {
  const DeviceImageCard({
    super.key,
    required this.image,
    this.selectedImage,
    required this.title,
    this.onSelected,
    this.disabled,
  });

  final String image;

  final String? selectedImage;

  final String title;

  final ValueChanged<String>? onSelected;

  final bool? disabled;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: disabled == true
        ? null
        : () async {
            final image = await showUploadBottomSheet(context: context);

            if (image != null && onSelected != null) {
              onSelected!(image);
            }
          },
    child: Container(
      width: 155.w,
      height: 207.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D2D2E39),
            offset: const Offset(2, 4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        border: Border.all(
          width: 1.w,
          color: selectedImage != null
              ? AppColors.introSliderCircleColor
              : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.file(
                        File(selectedImage!),
                        width: 118.w,
                        height: 118.h,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      image,
                      width: 118.w,
                      height: 118.h,
                      fit: BoxFit.contain,
                    ),
              SizedBox(height: 16.h),
              SizedBox(
                width: 134.w,
                child: RegularText(
                  textAlign: TextAlign.center,
                  textSize: 12.sp,
                  maxLines: 4,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.borderColor,
                  textOverflow: TextOverflow.ellipsis,
                  text: title,
                ),
              ),
            ],
          ),
          selectedImage != null
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 6.h,
                    width: 155.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8.r),
                        bottomLeft: Radius.circular(8.r),
                      ),
                      color: AppColors.introSliderCircleColor,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    ),
  );
}

class AppImagePicker {
  final ImagePicker _picker = ImagePicker();

  Future<String?> pickImageFromCamera() async {
    return _pickImage(ImageSource.camera);
  }

  Future<String?> pickImageFromGallery() async {
    return _pickImage(ImageSource.gallery);
  }

  Future<bool> requestCameraPermission() =>
      Permission.camera.request().isGranted;

  Future<bool> requestGalleryPermission() =>
      Permission.photos.request().isGranted;

  Future<bool> requestPermissions() => (
    requestCameraPermission(),
    requestGalleryPermission(),
  ).wait.then((results) => results.$1 && results.$2);

  Future<String?> _pickImage(ImageSource source) {
    return _picker
        .pickImage(source: source)
        .then((pickedFile) => pickedFile?.path);
  }
}

Future<String?> showUploadBottomSheet({required BuildContext context}) {
  final AppImagePicker imagePicker = AppImagePicker();
  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (BuildContext context) => Container(
      padding: EdgeInsets.all(16.r),
      height: 300.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10.h),
          RegularText(
            textAlign: TextAlign.center,
            textSize: 14.sp,
            maxLines: 2,
            fontWeight: FontWeight.w700,
            textColor: AppColors.black,
            textOverflow: TextOverflow.ellipsis,
            text: "Upload Image",
          ),
          SizedBox(height: 40.h),
          SizedBox(
            height: 45.h,
            width: double.infinity,
            child: AnimatedButton(
              disableButton: false,
              isLoading: false,
              onPressed: () async {
                final isPermissionGranted = await imagePicker
                    .requestCameraPermission();

                if (!context.mounted) return;

                if (isPermissionGranted) {
                  final value = await imagePicker.pickImageFromCamera();
                  if (!context.mounted) return;
                  Navigator.pop(context, value);
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Camera permission denied')),
                );
                Navigator.pop(context);
              },
              label: "Capture photo",
              fontSize: 12.sp,
              isSmallButton: false,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 45.h,
            width: double.infinity,
            child: AnimatedButton(
              disableButton: false,
              isLoading: false,
              buttonColor: AppColors.white,
              borderColor: AppColors.greyBorderColor,
              labelColor: AppColors.borderBlack,
              onPressed: () async {
                final isPermissionGranted = await imagePicker
                    .requestGalleryPermission();

                if (!context.mounted) return;

                if (isPermissionGranted) {
                  final value = await imagePicker.pickImageFromGallery();
                  if (!context.mounted) return;
                  Navigator.pop(context, value);
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gallery permission denied')),
                );
                Navigator.pop(context);
              },
              label: "Choose from gallery",
              fontSize: 12.sp,
              isSmallButton: false,
            ),
          ),
          SizedBox(height: 30.h),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: RegularText(
              textAlign: TextAlign.center,
              textSize: 14.sp,
              maxLines: 2,
              fontWeight: FontWeight.w700,
              textColor: AppColors.baseColor,
              textOverflow: TextOverflow.ellipsis,
              text: "Cancel",
            ),
          ),
        ],
      ),
    ),
  );
}
