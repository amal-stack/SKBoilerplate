import 'package:boilerplate/src/features/kyc/presentation/cubits/kyc_upload_documents_cubit.dart';
import 'package:boilerplate/src/shared/themes/text.dart' as custom;

import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/animated_button.dart';
import 'package:boilerplate/src/shared/widgets/image_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({super.key, required this.quoteId});

  final String quoteId;

  @override
  State<UploadDocumentScreen> createState() => _UploadDocumentScreenState();
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> {
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) =>
        KycUploadDocumentsCubit(context.read(), quoteId: widget.quoteId),
    child: Scaffold(
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
          text: "Upload Documents",
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
          child: KycUploadDocumentsForm(quoteId: widget.quoteId),
        ),
      ),
    ),
  );
}

class KycUploadDocumentsForm extends StatelessWidget {
  const KycUploadDocumentsForm({super.key, required this.quoteId});

  final String quoteId;

  @override
  Widget build(
    BuildContext context,
  ) => BlocListener<KycUploadDocumentsCubit, KycUploadDocumentsState>(
    listener: (context, state) {
      switch (state) {
        case KycUploadDocumentsSubmitted():
          context.push('/upload-invoice-screen/$quoteId');
        case KycUploadDocumentsError(:final message):
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        case KycUploadDocumentsInput() || KycUploadDocumentsSubmitting():
          // Do nothing
          break;
      }
    },
    child: BlocBuilder<KycUploadDocumentsCubit, KycUploadDocumentsState>(
      builder: (context, state) => Column(
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
                    text: "Aadhaar card",
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageUploadCard(
                        title: "Aadhaar Card (from front)",
                        image: "assets/images/question/scratch_1.png",
                        selectedImage: state.documents.aadhaarFrontPath,
                        onSelected: (image) {
                          context
                              .read<KycUploadDocumentsCubit>()
                              .documentUploaded(
                                state.documents.copyWith(
                                  aadhaarFrontPath: image,
                                ),
                              );
                        },
                      ),
                      ImageUploadCard(
                        title: "Aadhaar Card (from back)",
                        image: "assets/images/question/scratch_1.png",
                        selectedImage: state.documents.aadhaarBackPath,
                        onSelected: (image) {
                          context
                              .read<KycUploadDocumentsCubit>()
                              .documentUploaded(
                                state.documents.copyWith(
                                  aadhaarBackPath: image,
                                ),
                              );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  Container(
                    alignment: Alignment.topLeft,
                    child: custom.RichText(
                      texts: [
                        TextModel(
                          "Address Proof ",
                          size: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.borderBlack,
                        ),
                        TextModel(
                          " (Voter ID, Driving License)",
                          size: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.borderBlack,
                        ),
                      ],
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  ImageUploadCard(
                    title: "Address Proof",
                    image: "assets/images/question/scratch_1.png",
                    selectedImage: state.documents.addressProofPath,
                    onSelected: (image) {
                      context.read<KycUploadDocumentsCubit>().documentUploaded(
                        state.documents.copyWith(addressProofPath: image),
                      );
                    },
                  ),

                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 45.h,
                width: double.infinity,
                child: AnimatedButton(
                  disableButton: false,
                  isLoading: state is KycUploadDocumentsSubmitting,
                  onPressed: () async {
                    await context
                        .read<KycUploadDocumentsCubit>()
                        .submitDocuments();
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
  );
}
