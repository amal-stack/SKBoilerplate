import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewBlocBuilder<B extends BlocBase<ViewState<S>>, S>
    extends StatelessWidget {
  const ViewBlocBuilder({
    super.key,
    required this.builder,
    this.bloc,
    this.initialBuilder,
    this.errorBuilder,
  });

  final B? bloc;

  final Widget Function(BuildContext context, S data) builder;

  final Widget Function(BuildContext context)? initialBuilder;

  final Widget Function(BuildContext context, String message)? errorBuilder;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.long4,
      child: BlocBuilder<B, ViewState<S>>(
        builder: (context, state) => switch (state) {
          ViewInitial<S>() => buildInitial(context),
          ViewLoading<S>() => buildLoading(context),
          ViewSuccess<S>(data: final data) => buildSuccess(context, data),
          ViewError<S>(message: final message) => buildError(context, message),
        },
      ),
    );
  }

  Widget buildInitial(BuildContext context) {
    return initialBuilder?.call(context) ??
        Center(child: CircularProgressIndicator());
  }

  Widget buildLoading(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }

  Widget buildSuccess(BuildContext context, S data) {
    return builder(context, data);
  }

  Widget buildError(BuildContext context, String message) {
    return errorBuilder?.call(context, message) ??
        _ErrorBox(bloc: bloc, message: message);
  }
}

class _ErrorBox<B extends BlocBase<ViewState<S>>, S> extends StatelessWidget {
  const _ErrorBox({super.key, required this.bloc, required this.message});

  final B? bloc;

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.errorColor.withValues(alpha: 0.3),
            width: 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.errorColor.withValues(alpha: 0.1),
              blurRadius: 12.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.errorColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                color: AppColors.errorColor,
                size: 32.sp,
              ),
            ),
            SizedBox(height: 16.h),
            RegularText(
              text: 'Oops! Something went wrong',
              textColor: Colors.black87,
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: RegularText(
                text: kDebugMode
                    ? message
                    : 'Please try again later if the issue persists.',
                maxLines: 5,
                textAlign: TextAlign.center,
                textColor: Colors.grey.shade600,
                textSize: 14.sp,
              ),
            ),
            if ((bloc ?? context.read<B>()) case RetryCubitMixin cubit) ...[
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: cubit.retry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: RegularText(
                  text: 'Retry',
                  textColor: Colors.white,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ViewBlocSelector<B extends BlocBase<ViewState<S>>, S, T>
    extends StatelessWidget {
  const ViewBlocSelector({
    super.key,
    required this.selector,
    required this.builder,
    this.bloc,
    this.initialBuilder,
    this.errorBuilder,
  });

  final B? bloc;

  final T Function(S state) selector;

  final Widget Function(BuildContext context, T data) builder;

  final Widget Function(BuildContext context)? initialBuilder;

  final Widget Function(BuildContext context, String message)? errorBuilder;

  @override
  Widget build(BuildContext context) =>
      BlocSelector<B, ViewState<S>, ViewState<T>>(
        selector: (state) => state.map(selector),
        builder: (context, state) => switch (state) {
          ViewInitial<T>() => buildInitial(context),
          ViewLoading<T>() => buildLoading(context),
          ViewSuccess<T>(data: final data) => buildSuccess(context, data),
          ViewError<T>(message: final message) => buildError(context, message),
        },
      );

  Widget buildInitial(BuildContext context) {
    return initialBuilder?.call(context) ??
        Center(child: CircularProgressIndicator());
  }

  Widget buildLoading(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }

  Widget buildSuccess(BuildContext context, T data) {
    return builder(context, data);
  }

  Widget buildError(BuildContext context, String message) {
    return errorBuilder?.call(context, message) ??
        Center(
          child: RegularText(text: message, textColor: AppColors.errorColor),
        );
  }
}
