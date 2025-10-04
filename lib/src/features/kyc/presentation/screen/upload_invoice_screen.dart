import 'dart:io';

import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadInvoiceScreen extends StatefulWidget {
  const UploadInvoiceScreen({super.key});

  @override
  State<UploadInvoiceScreen> createState() => _UploadInvoiceScreenState();
}

class _UploadInvoiceScreenState extends State<UploadInvoiceScreen> {
  File? frontImageFile;
  File? backImageFile;
  File? leftImageFile;
  File? rightImageFile;
  File? topImageFile;
  File? deviceBrokenFile;

  File? selectedInvoice;
  bool isSelected = false;

  final ImagePicker _picker = ImagePicker();

  XFile? pickedFileDoc;
  bool isLoading = false;

  // Request camera & gallery permission
  Future<bool> requestCameraAndGalleryPermissions() async {
    final cameraStatus = await Permission.camera.request();
    final galleryStatus = await Permission.photos.request();

    return cameraStatus.isGranted && galleryStatus.isGranted;
  }

  Future<void> pickImage(int index, int selectedIndex) async {
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
          if (selectedIndex == 1) {
            frontImageFile = File(pickedFileDoc!.path);
          } else if (selectedIndex == 2) {
            backImageFile = File(pickedFileDoc!.path);
          } else if (selectedIndex == 3) {
            leftImageFile = File(pickedFileDoc!.path);
          }
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void showPriceChangeDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // prevent dismiss by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RegularText(
                      textAlign: TextAlign.start,
                      textSize: 16.sp,
                      maxLines: 2,
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.black,
                      textOverflow: TextOverflow.ellipsis,
                      text: "Price change alert",
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                RegularText(
                  textAlign: TextAlign.start,
                  textSize: 12.sp,
                  maxLines: 4,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.borderBlack,
                  textOverflow: TextOverflow.ellipsis,
                  text:
                      "Final price was calculated considering the device under warranty. "
                      "However, unavailability of invoice resulted in a price change",
                ),
                SizedBox(height: 20.h),
                RegularText(
                  textAlign: TextAlign.start,
                  textSize: 12.sp,
                  maxLines: 2,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black,
                  textOverflow: TextOverflow.ellipsis,
                  text: "Earlier proposed price",
                ),
                SizedBox(height: 16.h),
                RegularText(
                  textAlign: TextAlign.start,
                  textSize: 16.sp,
                  maxLines: 2,
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.lightBlackShade,
                  textOverflow: TextOverflow.ellipsis,
                  text: "₹ 48,000",
                ),
                // Text(
                //   "₹ 48,000",
                //   style: TextStyle(
                //     fontSize: 16.sp,
                //     fontWeight: FontWeight.w700,
                //     color: Colors.black,
                //   ),
                // ),
                SizedBox(height: 30.h),
                RegularText(
                  textAlign: TextAlign.start,
                  textSize: 12.sp,
                  maxLines: 2,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.black,
                  textOverflow: TextOverflow.ellipsis,
                  text: "New price",
                ),

                SizedBox(height: 14.h),
                RegularText(
                  textAlign: TextAlign.start,
                  textSize: 12.sp,
                  maxLines: 2,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.black,
                  textOverflow: TextOverflow.ellipsis,
                  text: "₹ 28,000",
                ),
                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    child: AnimatedButton(
                      isSmallButton: true,
                      label: "Continue",
                      onPressed: () {
                         context.push('/order-success-screen');

                      },
                    ),
                  ),
                ),

                // Continue button
                //   SizedBox(
                //
                //     width: 100.w
                //     child: AnimatedButton(
                //     isSmallButton: true,
                //     label: "Continue",
                //     onPressed: () {},
                //
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Image.asset(
                "assets/images/left_arrow.png",
                width: 24.w,
                height: 24.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: RegularText(
          textAlign: TextAlign.start,
          textSize: 20.sp,
          maxLines: 1,
          fontWeight: FontWeight.w700,
          textColor: AppColors.black,
          textOverflow: TextOverflow.ellipsis,
          text: "Pending Task",
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            color: AppColors.dividerColor, // grey divider line
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
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
                        text: "Upload KYC documents",
                      ),
                      SizedBox(height: 8.h),
                      RegularText(
                        textAlign: TextAlign.start,
                        textSize: 14.sp,
                        maxLines: 2,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.borderBlack,
                        textOverflow: TextOverflow.ellipsis,
                        text: "Upload Invoice",
                      ),
                      SizedBox(height: 24.h),
                      GestureDetector(
                        onTap:
                            () => showUploadBottomSheet(
                              context: context,
                              selectedImage: 1,
                            ),
                        child:
                            leftImageFile == null
                                ? documentWidget(
                                  title: "Address proof",
                                  image: "assets/images/question/scratch_1.png",
                                  isFile: false,
                                )
                                : documentWidget(
                                  title: "Address proof",
                                  image: leftImageFile!.path,
                                  isFile: true,
                                ),
                      ),
                      SizedBox(height: 8.h),
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
                        showPriceChangeDialog(context);
                        //  context.push('/order-success-screen');
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

  void showUploadBottomSheet({
    required BuildContext context,
    required int selectedImage,
  }) {
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
                    Navigator.pop(context);
                    await pickImage(0, selectedImage); // Camera
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
                      await pickImage(1, selectedImage); // Gallery
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
