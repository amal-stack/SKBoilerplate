import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/quote.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/step.dart';
import 'package:boilerplate/src/features/questionaire/domain/repositories/quotes_repository.dart';
import 'package:boilerplate/src/features/questionaire/presentation/models/input.dart';
import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceImagesUploadState {
  const DeviceImagesUploadState({
    required this.viewState,
    this.front,
    this.back,
    this.left,
    this.right,
    this.top,
    this.bottom,
  });

  static const initial = DeviceImagesUploadState(
    viewState: ViewState.initial(),
  );

  final String? front;

  final String? back;

  final String? left;

  final String? right;

  final String? top;

  final String? bottom;

  bool get isComplete =>
      _isNotNullOrEmpty(front) &&
      _isNotNullOrEmpty(back) &&
      _isNotNullOrEmpty(left) &&
      _isNotNullOrEmpty(right) &&
      _isNotNullOrEmpty(top) &&
      _isNotNullOrEmpty(bottom);

  bool _isNotNullOrEmpty(String? value) => value != null && value.isNotEmpty;

  final ViewState<QuoteDeviceImages> viewState;

  DeviceImagesUploadState copyWith({
    ViewState<QuoteDeviceImages>? viewState,
    String? front,
    String? back,
    String? left,
    String? right,
    String? top,
    String? bottom,
  }) => DeviceImagesUploadState(
    viewState: viewState ?? this.viewState,
    front: front ?? this.front,
    back: back ?? this.back,
    left: left ?? this.left,
    right: right ?? this.right,
    top: top ?? this.top,
    bottom: bottom ?? this.bottom,
  );

  DeviceImages toDeviceImages() => DeviceImages(
    front: _checkNotNullOrEmpty(front, 'front image'),
    back: _checkNotNullOrEmpty(back, 'back image'),
    left: _checkNotNullOrEmpty(left, 'left image'),
    right: _checkNotNullOrEmpty(right, 'right image'),
    top: _checkNotNullOrEmpty(top, 'top image'),
    bottom: _checkNotNullOrEmpty(bottom, 'bottom image'),
  );

  String _checkNotNullOrEmpty(String? value, String name) {
    if (value == null || value.isEmpty) {
      throw DeviceAssessmentInputException.missingField(
        name,
        DeviceAssessmentStep.imageUpload.name,
      );
    }
    return value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceImagesUploadState &&
          runtimeType == other.runtimeType &&
          front == other.front &&
          back == other.back &&
          left == other.left &&
          right == other.right &&
          top == other.top &&
          bottom == other.bottom &&
          viewState == other.viewState;

  @override
  int get hashCode =>
      Object.hash(front, back, left, right, top, bottom, viewState);
}



class DeviceImagesUploadCubit extends Cubit<DeviceImagesUploadState> {
  DeviceImagesUploadCubit(this.repository)
    : super(DeviceImagesUploadState.initial);

  final QuotesRepository repository;

  void frontImageChanged(String? path) {
    emit(state.copyWith(front: path));
  }

  void backImageChanged(String? path) {
    emit(state.copyWith(back: path));
  }

  void leftImageChanged(String? path) {
    emit(state.copyWith(left: path));
  }

  void rightImageChanged(String? path) {
    emit(state.copyWith(right: path));
  }

  void topImageChanged(String? path) {
    emit(state.copyWith(top: path));
  }

  void bottomImageChanged(String? path) {
    emit(state.copyWith(bottom: path));
  }

  Future<void> uploadImages(String quoteId) async {
    emit(state.copyWith(viewState: const ViewState.loading()));

    try {
      final images = state.toDeviceImages();
      final result = await repository.saveDeviceImages(
        quoteId: quoteId,
        images: images,
      );
      debugPrint('Device images uploaded for Quote ID: $quoteId');
      emit(state.copyWith(viewState: ViewState.success(result)));
    } catch (e) {
      debugPrint('Error uploading device images: $e');
      emit(state.copyWith(viewState: ViewState.error(e.toString())));
    }
  }
}
