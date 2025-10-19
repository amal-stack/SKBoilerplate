import 'package:boilerplate/src/features/orders/domain/entities/order.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/widgets/animated_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key, required this.order});

  final Order order;

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
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
        text: "Order created successfully",
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
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 80.h),
                    SizedBox(
                      width: 150.w,
                      height: 115.h,
                      child: Image.asset('assets/images/order_success.png'),
                    ),
                    SizedBox(height: 8.h),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: RegularText(
                          textAlign: TextAlign.start,
                          textSize: 14.sp,
                          maxLines: 2,
                          fontWeight: FontWeight.w700,
                          textColor: AppColors.darkGreenColor,
                          textOverflow: TextOverflow.ellipsis,
                          text: "Congratulations",
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: RegularText(
                          textAlign: TextAlign.start,
                          textSize: 14.sp,
                          maxLines: 2,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.darkGreenColor,
                          textOverflow: TextOverflow.ellipsis,
                          text: "Your order has been created successfully",
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8.w),
                        border: Border.all(
                          color: AppColors.borderBlack.withValues(alpha: 0.1),
                          width: 1.w,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RegularText(
                                textAlign: TextAlign.start,
                                textSize: 12.sp,
                                maxLines: 1,
                                fontWeight: FontWeight.w700,
                                textColor: AppColors.black,
                                textOverflow: TextOverflow.ellipsis,
                                text: widget.order.oId,
                              ),
                              RegularText(
                                textAlign: TextAlign.start,
                                textSize: 12.sp,
                                maxLines: 1,
                                fontWeight: FontWeight.w400,
                                textColor: AppColors.black,
                                textOverflow: TextOverflow.ellipsis,
                                text: DateFormat(
                                  'hh:mm a, dd-MM-yyyy',
                                ).format(widget.order.createdAt),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24.r,
                                backgroundColor: AppColors.greyBorderColor,
                              ),
                              SizedBox(width: 16.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RegularText(
                                    textAlign: TextAlign.start,
                                    textSize: 12.sp,
                                    maxLines: 1,
                                    fontWeight: FontWeight.w700,
                                    textColor: AppColors.black,
                                    textOverflow: TextOverflow.ellipsis,
                                    text: widget.order.kycName ?? '[No Name]',
                                  ),
                                  SizedBox(height: 3.h),
                                  RegularText(
                                    textAlign: TextAlign.start,
                                    textSize: 12.sp,
                                    maxLines: 1,
                                    fontWeight: FontWeight.w500,
                                    textColor: AppColors.black,
                                    textOverflow: TextOverflow.ellipsis,
                                    text: widget.order.kycNumber,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 24.r,
                                      backgroundColor:
                                          AppColors.greyBorderColor,
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RegularText(
                                            textAlign: TextAlign.start,
                                            textSize: 12.sp,
                                            maxLines: 1,
                                            fontWeight: FontWeight.w700,
                                            textColor: AppColors.black,
                                            textOverflow: TextOverflow.ellipsis,
                                            text: widget.order.deviceModel,
                                          ),
                                          SizedBox(height: 8.h),
                                          RegularText(
                                            textAlign: TextAlign.start,
                                            textSize: 12.sp,
                                            maxLines: 1,
                                            fontWeight: FontWeight.w500,
                                            textColor: AppColors.black,
                                            textOverflow: TextOverflow.ellipsis,
                                            text:
                                                "Variant: ${widget.order.deviceVariant}",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  RegularText(
                                    textAlign: TextAlign.start,
                                    textSize: 10.sp,
                                    maxLines: 1,
                                    fontWeight: FontWeight.w500,
                                    textColor: AppColors.black,
                                    textOverflow: TextOverflow.ellipsis,
                                    text: "Purchase price",
                                  ),
                                  SizedBox(height: 8.h),
                                  RegularText(
                                    textAlign: TextAlign.start,
                                    textSize: 14.sp,
                                    maxLines: 1,
                                    fontWeight: FontWeight.w700,
                                    textColor: AppColors.darkGreenColor,
                                    textOverflow: TextOverflow.ellipsis,
                                    text: '₹${widget.order.devicePrice}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          GestureDetector(
                            onTap: () {
                              context.push(
                                '/completed-order-details-screen',
                                extra: widget.order,
                              );
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: RegularText(
                                textAlign: TextAlign.end,
                                textSize: 12.sp,
                                maxLines: 1,
                                fontWeight: FontWeight.w700,
                                textColor: AppColors.baseColor,
                                textOverflow: TextOverflow.ellipsis,
                                text: "View Details",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    isLoading: false,
                    onPressed: () => context.go('/dashboard'),
                    label: "Back to Home",
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
