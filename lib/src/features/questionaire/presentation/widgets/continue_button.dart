import 'package:boilerplate/src/features/questionaire/domain/entities/step.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_assessment_cubit.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_images_upload_cubit.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_invoice_upload_cubit.dart';
import 'package:boilerplate/src/features/questionaire/presentation/models/flow_state.dart';
import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key, required this.quoteId});

  final String quoteId;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      DeviceAssessmentCubit,
      DeviceAssessmentState,
      DeviceAssessmentStep
    >(
      selector: (state) => state.step,
      builder: (context, step) =>
          BlocBuilder<DeviceImagesUploadCubit, DeviceImagesUploadState>(
            builder: (context, imageUploadState) =>
                BlocBuilder<DeviceInvoiceUploadCubit, DeviceInvoiceState>(
                  builder: (context, invoiceUploadState) => Column(
                    children: [
                      SizedBox(
                        height: 45.h,
                        width: double.infinity,
                        child: AnimatedButton(
                          disableButton: switch (step) {
                            DeviceAssessmentStep.imageUpload =>
                              !imageUploadState.isComplete,
                            DeviceAssessmentStep.warranty =>
                              !invoiceUploadState.isComplete,
                            _ => false,
                          },
                          isLoading: imageUploadState.viewState is ViewLoading,
                          onPressed: () {
                            final cubit = context.read<DeviceAssessmentCubit>();
                            if (cubit.step ==
                                DeviceAssessmentStep.imageUpload) {
                              if (imageUploadState.viewState is ViewSuccess) {
                                debugPrint(
                                  "Calculating grade for quoteId: $quoteId",
                                );
                                cubit.calculateGrade(quoteId: quoteId);
                                return;
                              }
                              context
                                  .read<DeviceImagesUploadCubit>()
                                  .uploadImages(quoteId);

                              return;
                            }

                            // if (cubit.step == DeviceAssessmentStep.warranty && 
                            //     invoiceUploadState.viewState is! ViewSuccess) {
                            //       debugPrint(
                            //       "Uploading invoice for quoteId: $quoteId");
                            //   context
                            //       .read<DeviceInvoiceUploadCubit>()
                            //       .uploadInvoice(quoteId);
                            //   return;
                            // }

                            cubit.nextStep();
                          },
                          label: switch (step) {
                            DeviceAssessmentStep.imageUpload =>
                              switch (imageUploadState.viewState) {
                                ViewError() => 'Retry Upload',
                                ViewLoading() => 'Uploading...',
                                ViewSuccess() => AppTexts.continueTitle,
                                _ => 'Upload',
                              },
                            DeviceAssessmentStep.warranty =>
                              switch (invoiceUploadState.viewState) {
                                ViewError() => 'Retry Upload',
                                ViewLoading() => 'Uploading...',
                                ViewSuccess() => AppTexts.continueTitle,
                                _ => 'Upload',
                              },
                            _ => AppTexts.continueTitle,
                          },
                          fontSize: 12.sp,
                          isSmallButton: false,
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
          ),
    );
  }
}
