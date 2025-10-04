import 'dart:io';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../shared/widgets/animated_button.dart';

class WarrantySelectionScreen extends StatefulWidget {
  const WarrantySelectionScreen({super.key});

  @override
  State<WarrantySelectionScreen> createState() =>
      _WarrantySelectionScreenState();
}

class _WarrantySelectionScreenState extends State<WarrantySelectionScreen> {
  bool isSelected = false;
  int selectedIndex = -1;
  File? selectedInvoice;

  final ImagePicker _picker = ImagePicker();

  XFile? pickedFileDoc;

  final List<String> warrantyOptions = [
    "Below 3 months",
    "Below 3 - 6 months",
    "Between 6 - 11 months",
    "Above 11 months",
    "Out of warranty",
  ];

  // Request camera & gallery permission
  Future<bool> requestCameraAndGalleryPermissions() async {
    final cameraStatus = await Permission.camera.request();
    final galleryStatus = await Permission.photos.request();

    return cameraStatus.isGranted && galleryStatus.isGranted;
  }

  Future<void> pickImage(int index) async {
    try {
      XFile? pickedFile;

      if (index == 0) {
        // Camera
        if (await Permission.camera.request().isDenied) {
          print("Camera permission denied");
          return;
        }
        pickedFile = await _picker.pickImage(source: ImageSource.camera);
      } else {
        // Gallery
        if (!await requestCameraAndGalleryPermissions()) {
          print("Gallery permission denied");
          return;
        }
        pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      }

      if (pickedFile != null) {
        setState(() {
          pickedFileDoc = pickedFile;
          selectedInvoice = File(pickedFileDoc!.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Image.asset(
              "assets/images/left_arrow.png",
              width: 24.w,
              height: 24.h,
              fit: BoxFit.contain,
            ),
          ),
          onPressed: () => context.pop(),
        ),
        title: RegularText(
          textAlign: TextAlign.start,
          textSize: 20.sp,
          maxLines: 1,
          fontWeight: FontWeight.w700,
          textColor: AppColors.black,
          textOverflow: TextOverflow.ellipsis,
          text: "Verify product condition",
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            color: AppColors.dividerColor,
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      RegularText(
                        textAlign: TextAlign.start,
                        textSize: 14.sp,
                        maxLines: 2,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                        textOverflow: TextOverflow.ellipsis,
                        text: "Is your device under warranty?",
                      ),
                      SizedBox(height: 20.h),
                      Column(
                        children: List.generate(
                          warrantyOptions.length,
                              (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: warrantySelectionWidget(
                              title: warrantyOptions[index],
                              isSelected: selectedIndex == index,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      RegularText(
                        textAlign: TextAlign.start,
                        textSize: 14.sp,
                        maxLines: 2,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                        textOverflow: TextOverflow.ellipsis,
                        text: "Upload Invoice",
                      ),
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: () => showUploadBottomSheet(context),
                        child: pickedFileDoc == null
                            ? documentWidget(
                          title: "Invoice",
                          image: "assets/images/invoice.png",
                          isFile: false,
                        )
                            : documentWidget(
                          title: "Invoice",
                          image: selectedInvoice!.path,
                          isFile: true,
                        ),
                      ),
                      SizedBox(height: 50.h),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = !isSelected;
                          });
                        },
                        child: Image.asset(
                          isSelected
                              ? "assets/images/selected_checkbox.png"
                              : "assets/images/question/unchecked_checkbox.png",
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      RegularText(
                        textAlign: TextAlign.start,
                        textSize: 12.sp,
                        maxLines: 2,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.borderBlack,
                        textOverflow: TextOverflow.ellipsis,
                        text: "Do not have invoice",
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 45.h,
                    width: double.infinity,
                    child: AnimatedButton(
                      disableButton: false,
                      isLoading: false,
                      onPressed: () {
                        context.push('/upload-device-image-screen');
                      },
                      label: AppTexts.continueTitle,
                      fontSize: 12.sp,
                      isSmallButton: false,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget warrantySelectionWidget({
    required String title,
    required bool isSelected,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      height: 45.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.introSliderCircleColor : Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D2D2E39),
            offset: const Offset(2, 4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Center(
          child: RegularText(
            textAlign: TextAlign.start,
            textSize: 10.sp,
            maxLines: 2,
            fontWeight: FontWeight.w500,
            textColor: AppColors.black,
            textOverflow: TextOverflow.ellipsis,
            text: title,
          ),
        ),
      ),
    );
  }

  void showUploadBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (BuildContext context) {
        return Container(
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
                text: "Upload invoice Image",
              ),
              SizedBox(height: 40.h),
              SizedBox(
                height: 45.h,
                width: double.infinity,
                child: AnimatedButton(
                  disableButton: false,
                  isLoading: false,
                  onPressed: () async {
                    Navigator.pop(context);
                    await pickImage(0); // Camera
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
                    if (await requestCameraAndGalleryPermissions()) {
                      Navigator.pop(context);
                      await pickImage(1); // Gallery
                    } else {
                      print("Permission denied");
                    }
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
        );
      },
    );
  }

  Widget documentWidget({
    required String image,
    required String title,
    bool isFile = false,
  }) {
    return Container(
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
          color: isFile ? AppColors.introSliderCircleColor : Colors.transparent,
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
             isFile
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.file(
                  File(image),
                  width: 118.w,
                  height: 118.h,
                  fit: BoxFit.cover,
                ),
              )
                  : Image.asset(
                image,
                width: 46.w,
                height: 104.h,
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
          isFile
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
    );
  }
}
