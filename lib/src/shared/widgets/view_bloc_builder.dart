import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<B, ViewState<S>>(
      builder: (context, state) => switch (state) {
        ViewInitial<S>() => buildInitial(context),
        ViewSuccess<S>(data: final data) => buildSuccess(context, data),
        ViewError<S>(message: final message) => buildError(context, message),
      },
    );
  }

  Widget buildInitial(BuildContext context) {
    return initialBuilder?.call(context) ??
        Center(child: CircularProgressIndicator());
  }

  Widget buildSuccess(BuildContext context, S data) {
    return builder(context, data);
  }

  Widget buildError(BuildContext context, String message) {
    return errorBuilder?.call(context, message) ??
        Center(
          child: RegularText(text: message, textColor: AppColors.errorColor),
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
          ViewSuccess<T>(data: final data) => buildSuccess(context, data),
          ViewError<T>(message: final message) => buildError(context, message),
        },
      );

  Widget buildInitial(BuildContext context) {
    return initialBuilder?.call(context) ??
        Center(child: CircularProgressIndicator());
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
