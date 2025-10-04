import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/themes/text.dart' as custom;
import '../../../../shared/themes/text.dart';
import '../../../../shared/utils/app_colors.dart';

class RememberPasswordLink extends StatelessWidget {
  const RememberPasswordLink({super.key});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: context.pop,
    child: Container(
      alignment: Alignment.center,
      child: custom.RichText(
        texts: [
          TextModel(
            'Remember password?',
            size: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.lightBlack,
          ),
          TextModel(
            ' Sign In',
            size: 15.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.baseColor.withValues(alpha: 0.8),
          ),
        ],
        maxLines: 3,
      ),
    ),
  );
}
