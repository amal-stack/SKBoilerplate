import 'package:boilerplate/src/features/orders/domain/entities/order.dart';
import 'package:boilerplate/src/features/orders/presentations/cubits/order_history_cubit.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_field.dart';
import 'package:boilerplate/src/shared/widgets/view_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    lazy: false,
    create: (context) => OrderHistoryCubit(context.read())..fetchOrderHistory(),
    child: Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
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
          ],
        ),
        title: RegularText(
          textAlign: TextAlign.start,
          textSize: 20.sp,
          maxLines: 1,
          fontWeight: FontWeight.w600,
          textColor: AppColors.black,
          textOverflow: TextOverflow.ellipsis,
          text: "Order history",
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(116.h),
          child: Column(
            children: [
              Container(
                color: AppColors.dividerColor, // grey divider line
                height: 1,
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: InputTextField(
                  label: "Search by order number",
                  hintMessage: "Search by order number",
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/search.png",
                        width: 20.w,
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              TabBar(
                controller: _tabController,
                labelColor: const Color(0xFF7B6FFF),
                // purple color
                unselectedLabelColor: const Color(0xFF3D3A4E),
                // grey text
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
                indicatorColor: const Color(0xFF7B6FFF),
                // purple underline
                indicatorWeight: 3,
                indicatorPadding: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                labelPadding: EdgeInsets.all(0),
                tabs: [
                  Tab(text: 'Pending pickups', iconMargin: EdgeInsets.all(0)),
                  Tab(text: 'Ongoing', iconMargin: EdgeInsets.all(0)),
                  Tab(text: 'Completed', iconMargin: EdgeInsets.all(0)),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ViewBlocBuilder<OrderHistoryCubit, OrderHistoryState>(
            builder: (context, state) =>
                OrdersTabView(tabController: _tabController, orders: state),
          ),
        ),
      ),
    ),
  );
}

class OrdersTabView extends StatefulWidget {
  const OrdersTabView({
    super.key,
    required TabController tabController,
    required this.orders,
  }) : _tabController = tabController;

  final TabController _tabController;

  final OrderHistoryState orders;

  @override
  State<OrdersTabView> createState() => _OrdersTabViewState();
}

class _OrdersTabViewState extends State<OrdersTabView> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget._tabController,
      children: [
        PendingOrdersView(orders: widget.orders.pendingOrders),
        OngoingOrdersView(orders: widget.orders.ongoingOrders),
        CompletedOrdersView(orders: widget.orders.completedOrders),
      ],
    );
  }
}

class CompletedOrdersView extends StatelessWidget {
  const CompletedOrdersView({super.key, required this.orders});

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 30.h),
          RegularText(
            textAlign: TextAlign.start,
            textSize: 14.sp,
            maxLines: 1,
            fontWeight: FontWeight.w600,
            textColor: AppColors.borderBlack,
            textOverflow: TextOverflow.ellipsis,
            text: "${orders.length} orders has been completed successfully",
          ),
          SizedBox(height: 10.h),
          if (orders.isEmpty)
            Center(
              child: RegularText(
                textAlign: TextAlign.center,
                textSize: 14.sp,
                maxLines: 1,
                fontWeight: FontWeight.w500,
                textColor: AppColors.lightBlack,
                textOverflow: TextOverflow.ellipsis,
                text: "No completed orders found.",
              ),
            )
          else
            ListView.builder(
              itemCount: orders.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              // or NeverScrollableScrollPhysics()
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: OrderHistoryWidget(order: orders[index]),
                );
              },
            ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class OngoingOrdersView extends StatelessWidget {
  const OngoingOrdersView({super.key, required this.orders});

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          RegularText(
            textAlign: TextAlign.start,
            textSize: 14.sp,
            maxLines: 1,
            fontWeight: FontWeight.w600,
            textColor: AppColors.borderBlack,
            textOverflow: TextOverflow.ellipsis,
            text: "${orders.length} Ongoing orders",
          ),
          SizedBox(height: 10.h),
          if (orders.isEmpty)
            Center(
              child: RegularText(
                textAlign: TextAlign.center,
                textSize: 14.sp,
                maxLines: 1,
                fontWeight: FontWeight.w500,
                textColor: AppColors.lightBlack,
                textOverflow: TextOverflow.ellipsis,
                text: "No ongoing orders found.",
              ),
            )
          else
            ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              // or NeverScrollableScrollPhysics()
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: OrderHistoryWidget(order: orders[index]),
                );
              },
            ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class PendingOrdersView extends StatelessWidget {
  const PendingOrdersView({super.key, required this.orders});

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/warning.png",
                width: 17.w,
                height: 16.h,
              ),
              SizedBox(width: 4.w),
              RegularText(
                textAlign: TextAlign.start,
                textSize: 14.sp,
                maxLines: 1,
                fontWeight: FontWeight.w600,
                textColor: AppColors.titleRedColor,
                textOverflow: TextOverflow.ellipsis,
                text: "${orders.length} orders are pending for pick up ",
              ),
            ],
          ),
          SizedBox(height: 10.h),
          if (orders.isEmpty)
            Center(
              child: RegularText(
                textAlign: TextAlign.center,
                textSize: 14.sp,
                maxLines: 1,
                fontWeight: FontWeight.w500,
                textColor: AppColors.lightBlack,
                textOverflow: TextOverflow.ellipsis,
                text: "No pending orders found.",
              ),
            )
          else
            ListView.builder(
              itemCount: orders.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              // or NeverScrollableScrollPhysics()
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: OrderHistoryWidget(order: orders[index]),
              ),
            ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

// class PendingOrderHistoryWidget extends StatelessWidget {
//   const PendingOrderHistoryWidget({super.key, required this.order});

//   final Order order;

//   @override
//   Widget build(BuildContext context) => Container(
//     padding: EdgeInsets.all(12.w),
//     decoration: BoxDecoration(
//       color: AppColors.white,
//       borderRadius: BorderRadius.circular(8.w),
//       border: Border.all(
//         color: AppColors.borderBlack.withValues(alpha: 0.1),
//         width: 1.w,
//       ),
//     ),
//     child: Column(
//       children: [
//         RegularText(
//           textAlign: TextAlign.start,
//           textSize: 12.sp,
//           maxLines: 1,
//           fontWeight: FontWeight.w500,
//           textColor: AppColors.black,
//           textOverflow: TextOverflow.ellipsis,
//           text:
//               "${order.oId} | ${DateFormat('hh:mm a, dd-MM-yyyy').format(order.createdAt)}",
//         ),
//         SizedBox(height: 20.h),
//         Row(
//           children: [
//             CircleAvatar(
//               radius: 24.r,
//               backgroundColor: AppColors.greyBorderColor,
//             ),
//             SizedBox(width: 16.w),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 RegularText(
//                   textAlign: TextAlign.start,
//                   textSize: 12.sp,
//                   maxLines: 1,
//                   fontWeight: FontWeight.w700,
//                   textColor: AppColors.black,
//                   textOverflow: TextOverflow.ellipsis,
//                   text: order.kycName ?? '[No Name]',
//                 ),
//                 SizedBox(height: 3.h),
//                 RegularText(
//                   textAlign: TextAlign.start,
//                   textSize: 12.sp,
//                   maxLines: 1,
//                   fontWeight: FontWeight.w500,
//                   textColor: AppColors.black,
//                   textOverflow: TextOverflow.ellipsis,
//                   text: order.kycNumber,
//                 ),
//               ],
//             ),
//           ],
//         ),
//         SizedBox(height: 20.h),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 24.r,
//                     backgroundColor: AppColors.greyBorderColor,
//                   ),
//                   SizedBox(width: 16.w),
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         RegularText(
//                           textAlign: TextAlign.start,
//                           textSize: 12.sp,
//                           maxLines: 1,
//                           fontWeight: FontWeight.w700,
//                           textColor: AppColors.black,
//                           textOverflow: TextOverflow.ellipsis,
//                           text: order.deviceModel,
//                         ),
//                         SizedBox(height: 8.h),
//                         RegularText(
//                           textAlign: TextAlign.start,
//                           textSize: 12.sp,
//                           maxLines: 1,
//                           fontWeight: FontWeight.w500,
//                           textColor: AppColors.black,
//                           textOverflow: TextOverflow.ellipsis,
//                           text: "Variant :  ${order.deviceVariant}",
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 RegularText(
//                   textAlign: TextAlign.start,
//                   textSize: 10.sp,
//                   maxLines: 1,
//                   fontWeight: FontWeight.w500,
//                   textColor: AppColors.black,
//                   textOverflow: TextOverflow.ellipsis,
//                   text: "Purchase price",
//                 ),
//                 SizedBox(height: 8.h),
//                 RegularText(
//                   textAlign: TextAlign.start,
//                   textSize: 14.sp,
//                   maxLines: 1,
//                   fontWeight: FontWeight.w700,
//                   textColor: AppColors.darkGreenColor,
//                   textOverflow: TextOverflow.ellipsis,
//                   text: "${order.devicePrice}/-",
//                 ),
//               ],
//             ),
//           ],
//         ),
//         SizedBox(height: 8.h),
//         GestureDetector(
//           onTap: () {
//             context.push('/completed-order-details-screen');
//           },
//           child: Align(
//             alignment: Alignment.topRight,
//             child: RegularText(
//               textAlign: TextAlign.end,
//               textSize: 12.sp,
//               maxLines: 1,
//               fontWeight: FontWeight.w700,
//               textColor: AppColors.baseColor,
//               textOverflow: TextOverflow.ellipsis,
//               text: "View Details",
//             ),
//           ),
//         ),
//         SizedBox(height: 8.h),
//         PickupDetails(order: order),
//       ],
//     ),
//   );
// }

class PickupDetails extends StatelessWidget {
  const PickupDetails({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    if (order.status != OrderStatus.pending) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: RegularText(
            textAlign: TextAlign.end,
            textSize: 14.sp,
            maxLines: 1,
            fontWeight: FontWeight.w700,
            textColor: AppColors.black,
            textOverflow: TextOverflow.ellipsis,
            text: "Pickup Details",
          ),
        ),
        SizedBox(height: 20.h),
        Align(
          alignment: Alignment.topLeft,
          child: Column(
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
                text: "Logistics Name",
              ),
              SizedBox(height: 3.h),
              RegularText(
                textAlign: TextAlign.start,
                textSize: 12.sp,
                maxLines: 1,
                fontWeight: FontWeight.w500,
                textColor: AppColors.black,
                textOverflow: TextOverflow.ellipsis,
                text: "Contact number :  ${order.kycNumber}",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OrderHistoryWidget extends StatelessWidget {
  const OrderHistoryWidget({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) => Container(
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
              fontWeight: FontWeight.w500,
              textColor: AppColors.black,
              textOverflow: TextOverflow.ellipsis,
              text:
                  "${order.oId} | ${DateFormat('hh:mm a, dd-MM-yyyy').format(order.createdAt)}",
            ),
            order.status == OrderStatus.completed
                ? Container()
                : SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: Lottie.asset('assets/gifs/Success.json'),
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
                  text: order.kycName ?? '[No Name]',
                ),
                SizedBox(height: 3.h),
                RegularText(
                  textAlign: TextAlign.start,
                  textSize: 12.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black,
                  textOverflow: TextOverflow.ellipsis,
                  text: order.kycNumber,
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
                    backgroundColor: AppColors.greyBorderColor,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
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
                          text: "Apple iPhone 16 Plus",
                        ),
                        SizedBox(height: 8.h),
                        RegularText(
                          textAlign: TextAlign.start,
                          textSize: 12.sp,
                          maxLines: 1,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.black,
                          textOverflow: TextOverflow.ellipsis,
                          text: "Variant :  ${order.deviceVariant}",
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
                  text: "₹${order.devicePrice}/-",
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () {
            context.push('/completed-order-details-screen', extra: order);
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
              text: order.status == OrderStatus.completed
                  ? "View Details"
                  : "View Details  |  Download Invoice",
            ),
          ),
        ),
        const SizedBox(height: 8),
        PickupDetails(order: order),
      ],
    ),
  );
}
