import 'dart:async' show Timer;

import 'package:flutter_bloc/flutter_bloc.dart';

sealed class ViewState<T> {
  const ViewState();

  const factory ViewState.initial() = ViewInitial<T>;

  const factory ViewState.success(T data) = ViewSuccess<T>;

  const factory ViewState.error(String message) = ViewError<T>;

  ViewState<U> map<U>(U Function(T data) selector) => switch (this) {
    ViewInitial<T>() => ViewInitial<U>(),
    ViewSuccess<T>(data: final data) => ViewSuccess<U>(selector(data)),
    ViewError<T>(message: final message) => ViewError<U>(message),
  };
}

final class ViewInitial<T> extends ViewState<T> {
  const ViewInitial();
}

final class ViewSuccess<T> extends ViewState<T> {
  const ViewSuccess(this.data);

  final T data;
}

final class ViewError<T> extends ViewState<T> {
  const ViewError(this.message);

  final String message;
}

mixin DebounceCubitMixin<T> on Cubit<T> {
  Timer? _debounce;

  void withDebouncing(Duration duration, void Function() action) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(duration, action);
  }

  @override
  Future<void> close() {
    _debounce?.cancel();

    return super.close();
  }
}


mixin RetryCubitMixin<T> on Cubit<T> {
  void Function()? _onRetry;

  set onRetry(void Function()? callback) {
    _onRetry = callback;
  }

  void retry() {
    if (_onRetry != null) {
      _onRetry!();
    }
  }

  void withRetry(void Function() action) {
    try {
      action();
      _onRetry = null;
    } catch (_) {
      _onRetry = action;
      rethrow;
    }
  }
}