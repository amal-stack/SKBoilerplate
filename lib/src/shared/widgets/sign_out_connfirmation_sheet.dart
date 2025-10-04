import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/widgets/animated_button.dart';
import 'package:boilerplate/src/shared/widgets/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';


class SignOutConfirmationSheet extends StatelessWidget {
  const SignOutConfirmationSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      shouldClose: () => false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('assets/gifs/log-out.json', height: 150.h),
          const RegularText(
            textAlign: TextAlign.center,
            text: 'Are you sure, you want to log out from \n the Application?',
            textColor: AppColors.lightGreyColor,
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _yesButton(context),
              SizedBox(width: 8.w),
              _noButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _yesButton(BuildContext context) => SizedBox(
    width: 150.w,
    child: AnimatedButton(
      isSmallButton: true,
      onPressed: () {
        context.go('/auth');
        var box = Hive.box('prefs');
        box.put('isLoggedIn', false);

      },
      buttonColor: AppColors.baseColor.withOpacity(0.8),
      label: 'Yes',
      labelColor: AppColors.white,
    ),
  );

  Widget _noButton(BuildContext context) => SizedBox(
    width: 150.w,
    child: AnimatedButton(
      isSmallButton: true,
      onPressed: () {},
      buttonColor: AppColors.greyColor,
      label: 'No',
    ),
  );
}
