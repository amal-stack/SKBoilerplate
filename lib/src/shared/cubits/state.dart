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
