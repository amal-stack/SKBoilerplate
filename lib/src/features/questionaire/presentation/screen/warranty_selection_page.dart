import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_assessment_cubit.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_invoice_upload_cubit.dart';
import 'package:boilerplate/src/features/questionaire/presentation/models/flow_state.dart';
import 'package:boilerplate/src/shared/widgets/app_check_box.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/widgets/image_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WarrantySelectionPage extends StatelessWidget {
  const WarrantySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          const WarrantySection(),
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
          ImageUploadCard(
            image: "assets/images/invoice.png",
            title: "Invoice",
            selectedImage: context.select<DeviceInvoiceUploadCubit, String?>(
              (state) => state.state.invoice?.path,
            ),
            onSelected: (image) {
              context.read<DeviceInvoiceUploadCubit>().invoiceChanged(
                DeviceInvoice(path: image),
              );
            },
            disabled: context.select<DeviceInvoiceUploadCubit, bool>(
              (state) => !state.state.hasInvoice,
            ),
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}

class WarrantySection extends StatelessWidget {
  const WarrantySection({super.key});

  static const Map<WarrantyPeriod, String> warrantyOptions = {
    WarrantyPeriod.below3Months: "Below 3 months",
    WarrantyPeriod.from3to6: "Between 3 - 6 months",
    WarrantyPeriod.from6to11: "Between 6 - 11 months",
    WarrantyPeriod.above11: "Above 11 months",
    WarrantyPeriod.outOfWarranty: "Out of warranty",
  };

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      DeviceAssessmentCubit,
      DeviceAssessmentState,
      WarrantyPeriod?
    >(
      selector: (state) => state.input.warrantyPeriod,
      builder: (context, warrantyPeriod) => Column(
        children: [
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
            children: [
              for (final entry in warrantyOptions.entries) ...[
                WarrantyOption(
                  title: entry.value,
                  isSelected: warrantyPeriod == entry.key,
                  onTap: () {
                    context.read<DeviceAssessmentCubit>().warrantyPeriodChanged(
                      entry.key,
                    );
                  },
                ),
                SizedBox(height: 12.h),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class NoInvoiceCheckbox extends StatelessWidget {
  const NoInvoiceCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DeviceInvoiceUploadCubit, DeviceInvoiceState, bool>(
      selector: (state) => !state.hasInvoice,
      builder: (context, isSelected) => AppCheckBox(
        isSelected: isSelected,
        onTap: () {
          final cubit = context.read<DeviceInvoiceUploadCubit>();
          cubit.hasInvoiceChanged(!cubit.state.hasInvoice);
        },
      ),
    );
  }
}

class WarrantyOption extends StatelessWidget {
  const WarrantyOption({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;

  final bool isSelected;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
