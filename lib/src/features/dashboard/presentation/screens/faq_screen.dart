import 'package:boilerplate/src/features/dashboard/domain/entities/faq.dart';
import 'package:boilerplate/src/features/dashboard/presentation/cubits/faq_cubit.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_assets.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_field.dart';
import 'package:boilerplate/src/shared/widgets/qa_widget.dart';
import 'package:boilerplate/src/shared/widgets/view_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => FaqCubit(context.read())..fetchFaqs(),
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
            fontWeight: FontWeight.w700,
            textColor: AppColors.black,
            textOverflow: TextOverflow.ellipsis,
            text: "All FAQs",
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Container(
              color: AppColors.dividerColor, // grey divider line
              height: 1,
            ),
          ),
        ),
        body: ViewBlocBuilder<FaqCubit, List<Faq>>(
          builder: (context, faqs) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: FaqList(faqs),
          ),
        ),
      ),
    );
  }
}

class FaqList extends StatefulWidget {
  const FaqList(this.faqs, {super.key});

  final List<Faq> faqs;

  @override
  State<FaqList> createState() => _FaqListState();
}

class _FaqListState extends State<FaqList> {
  List<Faq> get faqs => widget.faqs;

  int? _expandedIndex;

  void _toggleExpansion(int index) {
    setState(() {
      if (_expandedIndex == index) {
        _expandedIndex = null; // collapse
      } else {
        _expandedIndex = index; // expand selected
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: faqs.length,
      itemBuilder: (context, index) => FaqItem(
        question: faqs[index].question,
        answer: faqs[index].answer,
        index: index,
        expandedIndex: _expandedIndex,
        onTap: _toggleExpansion,
      ),
      separatorBuilder: (context, index) => SizedBox(height: 8.h),
    );
  }
}
