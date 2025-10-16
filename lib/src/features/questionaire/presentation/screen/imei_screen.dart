import 'package:boilerplate/src/features/dashboard/presentation/screens/faq_screen.dart';
import 'package:boilerplate/src/features/products/domain/product_variant.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/quotes_cubit.dart';
import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:boilerplate/src/shared/models/faq.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_assets.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/animated_button.dart';

class ImeiScreen extends StatelessWidget {
  const ImeiScreen({
    super.key,
    required this.deviceId,
    required this.deviceCategory,
  });

  final String deviceId;

  final DeviceCategory deviceCategory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          QuotesCubit(context.read())..deviceIdChanged(deviceId),
      child: BlocListener<QuotesCubit, QuotesState>(
        listener: (context, state) {
          switch (state.viewState) {
            case ViewSuccess(:final data):
              (String quoteId) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'IMEI submitted successfully.',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                );
                context.push(
                  '/questionnaire/$quoteId?deviceCategory=${deviceCategory.name}',
                );
              }(data.id);
            case ViewError(:final message):
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            default:
            // No action needed for other states
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0.0,
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
              text: "Enter IMEI number",
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Container(
                color: AppColors.dividerColor, // grey divider line
                height: 1,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    ImeiForm(),
                    SizedBox(height: 30.h),
                    ImeiUserHint(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImeiForm extends StatefulWidget {
  const ImeiForm({super.key});

  @override
  State<ImeiForm> createState() => _ImeiFormState();
}

class _ImeiFormState extends State<ImeiForm> {
  final _formKey = GlobalKey<FormState>();

  void submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    context.read<QuotesCubit>().submitImei();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          RegularText(
            textAlign: TextAlign.start,
            textSize: 12.sp,
            maxLines: 2,
            fontWeight: FontWeight.w600,
            textColor: AppColors.borderBlack,
            textOverflow: TextOverflow.ellipsis,
            text: "Please enter the IMEI number to fetch the accurate price",
          ),
          SizedBox(height: 40.h),
          Align(
            alignment: Alignment.center,
            child: Image.asset(AppAssets.imei, width: 234.w, height: 120.h),
          ),

          SizedBox(height: 24.h),
          ImeiInputField(),
          SizedBox(height: 22.h),
          CreateQuoteButton(onPressed: submit),
        ],
      ),
    );
  }
}

class CreateQuoteButton extends StatelessWidget {
  const CreateQuoteButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 45.h,
    width: double.infinity,
    child: AnimatedButton(
      disableButton: false,
      isLoading: context.watch<QuotesCubit>().state.viewState is ViewLoading
          ? true
          : false,
      onPressed: onPressed,
      label: AppTexts.continueTitle,
      fontSize: 12.sp,
      isSmallButton: false,
    ),
  );
}

class ImeiUserHint extends StatelessWidget {
  const ImeiUserHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RegularText(
          textAlign: TextAlign.start,
          textSize: 14.sp,
          maxLines: 1,
          fontWeight: FontWeight.w700,
          textColor: AppColors.black,
          textOverflow: TextOverflow.ellipsis,
          text: "Where can I find the IMEI number?",
        ),
        SizedBox(height: 20.h),
        FaqList([
          Faq(
            id: 1,
            question: "Method 1 : From the phone box",
            answer: AppTexts.answer,
          ),
          Faq(
            id: 2,
            question: "Method 2 : Dial *#06#",
            answer: AppTexts.answer,
          ),
        ]),
      ],
    );
  }
}

class ImeiInputField extends StatelessWidget {
  const ImeiInputField({super.key});

  @override
  Widget build(BuildContext context) => InputTextField(
    onChanged: (value) => context.read<QuotesCubit>().imeiChanged(value),
    label: "Enter IMEI number",
    hintMessage: "Enter IMEI number",
    textInputType: TextInputType.number,
    maxLength: 16,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(16),
    ],
  );
}
