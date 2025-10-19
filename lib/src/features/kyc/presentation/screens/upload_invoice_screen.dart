import 'package:boilerplate/src/core/questionnaire_price_store.dart';
import 'package:boilerplate/src/features/kyc/presentation/cubits/create_order_cubit.dart';
import 'package:boilerplate/src/features/kyc/presentation/cubits/kyc_upload_documents_cubit.dart';
import 'package:boilerplate/src/features/orders/domain/entities/order.dart';
import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/animated_button.dart';
import 'package:boilerplate/src/shared/widgets/app_check_box.dart';
import 'package:boilerplate/src/shared/widgets/image_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UploadInvoiceScreen extends StatefulWidget {
  const UploadInvoiceScreen({super.key, required this.quoteId});

  final String quoteId;

  @override
  State<UploadInvoiceScreen> createState() => _UploadInvoiceScreenState();
}

class _UploadInvoiceScreenState extends State<UploadInvoiceScreen> {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) =>
            KycUploadInvoiceCubit(context.read(), quoteId: widget.quoteId),
      ),
      BlocProvider(
        create: (_) =>
            CreateOrderCubit(context.read(), quoteId: widget.quoteId),
      ),
    ],
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
          child: UploadInvoiceForm(),
          ),
        ),
      ),
    );
}

class UploadInvoiceForm extends StatelessWidget {
  const UploadInvoiceForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<KycUploadInvoiceCubit, KycUploadInvoiceState>(
          listener: (context, state) async {
            if (state is KycUploadInvoiceSubmitted) {
              final result = await showPriceChangeDialog(context) ?? false;
              if (result && context.mounted) {
                context.read<CreateOrderCubit>().createOrder();
              }
            }
          },
        ),
        BlocListener<CreateOrderCubit, ViewState<Order>>(
          listener: (context, state) {
            switch (state) {
              case ViewSuccess<Order>(data: final order):
                context.push('/order-success-screen', extra: order);
              case ViewError():
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Failed to create order. Please try again.',
                    ),
                  ),
                );
              default:
                // Do nothing for other states
                break;
            }
    
          },
        ),
      ],
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
                    ImageUploadCard(
                      title: "Invoice",
                      image: "assets/images/question/scratch_1.png",
                      selectedImage: context
                          .select<KycUploadInvoiceCubit, String?>(
                            (state) => state.state.invoicePath,
                          ),
                      onSelected: (image) {
                        context
                            .read<KycUploadInvoiceCubit>()
                            .invoiceUploaded(image);
                      },
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
                    BlocSelector<
                      KycUploadInvoiceCubit,
                      KycUploadInvoiceState,
                      bool
                    >(
                      selector: (state) => !state.hasInvoice,
                      builder: (context, isSelected) => AppCheckBox(
                        isSelected: isSelected,
                        onTap: () {
                          context
                              .read<KycUploadInvoiceCubit>()
                              .toggleHasInvoice();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ContinueButton(),
                SizedBox(height: 20.h),
              ],
            ),
          ],
        ),
      );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      width: double.infinity,
      child: BlocBuilder<KycUploadInvoiceCubit, KycUploadInvoiceState>(
        builder: (context, state) => switch (state) {
          KycUploadInvoiceInput() => AnimatedButton(
            disableButton: false,
            isLoading: false,
            onPressed: () async {
              context.read<KycUploadInvoiceCubit>().submitInvoice();
              //  context.push('/order-success-screen');
            },
            label: AppTexts.continueTitle,
            fontSize: 12.sp,
            isSmallButton: false,
          ),
          KycUploadInvoiceSubmitting() => AnimatedButton(
            disableButton: true,
            isLoading: true,
            label: 'Submitting...',
            fontSize: 12.sp,
            isSmallButton: false,
            onPressed: () {},
          ),
          KycUploadInvoiceSubmitted() => AnimatedButton(
            disableButton: false,
            isLoading: false,
            onPressed: () async {
              //context.read<CreateOrderCubit>().createOrder();
            },
            label: 'Place Order',
            fontSize: 12.sp,
          ),
        },
      ),
    );
  }
}

Future<bool?> showPriceChangeDialog(BuildContext context) => showDialog<bool>(
  context: context,
  barrierDismissible: false, // prevent dismiss by tapping outside
  builder: (BuildContext context) => Dialog(
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
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
                onTap: () => Navigator.of(context).pop(false),
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
            text: "₹ ${QuestionnairePriceStore.instance.maximumDevicePrice('')}",
          ),
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
            text: "₹ ${QuestionnairePriceStore.instance.calculatedDevicePrice('')}",
          ),
          SizedBox(height: 24.h),
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              child: AnimatedButton(
                isSmallButton: true,
                label: "Continue",
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);
