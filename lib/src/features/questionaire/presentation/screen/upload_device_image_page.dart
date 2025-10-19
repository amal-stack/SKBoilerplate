
import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_images_upload_cubit.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/widgets/image_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
                ImageUploadCard(
                  title: "Front",
                  image: "assets/images/question/mobile_front.png",
                  selectedImage: state.front,
                  onSelected: (image) {
                    cubit.frontImageChanged(image);
                  },
                ),
                ImageUploadCard(
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
                ImageUploadCard(
                  title: "Left (from front)",
                  image: "assets/images/question/mobile_left.png",
                  selectedImage: state.left,
                  onSelected: (image) {
                    cubit.leftImageChanged(image);
                  },
                ),
                ImageUploadCard(
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
                ImageUploadCard(
                  title: "Top",
                  image: "assets/images/question/mobile_top.png",
                  selectedImage: state.top,
                  onSelected: (image) {
                    cubit.topImageChanged(image);
                  },
                ),
                ImageUploadCard(
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
