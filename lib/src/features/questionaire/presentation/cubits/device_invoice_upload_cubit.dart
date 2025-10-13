import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/domain/repositories/quotes_repository.dart';
import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceInvoiceState {
  const DeviceInvoiceState({
    required this.viewState,
    this.invoice,
    required this.hasInvoice,
  });

  static const initial = DeviceInvoiceState(
    viewState: ViewState.initial(),
    hasInvoice: true,
  );

  final DeviceInvoice? invoice;

  final bool hasInvoice;

  final ViewState<bool> viewState;

  bool get isComplete => !hasInvoice || invoice != null;

  DeviceInvoiceState copyWith({
    ViewState<bool>? viewState,
    DeviceInvoice? invoice,
    bool? hasInvoice,
  }) => DeviceInvoiceState(
    viewState: viewState ?? this.viewState,
    invoice: invoice ?? this.invoice,
    hasInvoice: hasInvoice ?? this.hasInvoice,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceInvoiceState &&
          runtimeType == other.runtimeType &&
          viewState == other.viewState &&
          invoice == other.invoice &&
          hasInvoice == other.hasInvoice;

  @override
  int get hashCode => Object.hash(viewState, invoice, hasInvoice);
}

class DeviceInvoiceUploadCubit extends Cubit<DeviceInvoiceState> {
  DeviceInvoiceUploadCubit(this.repository) : super(DeviceInvoiceState.initial);

  final QuotesRepository repository;

  void invoiceChanged(DeviceInvoice? invoice) {
    emit(state.copyWith(invoice: invoice));
  }

  void hasInvoiceChanged(bool hasInvoice) {
    emit(state.copyWith(hasInvoice: hasInvoice));
  }

  bool get isComplete => !state.hasInvoice || state.invoice != null;

  Future<void> uploadInvoice(String quoteId) async {
    if (!state.hasInvoice || state.invoice == null) {
      emit(state.copyWith(viewState: const ViewState.error('No invoice to upload')));
      return;
    }
    emit(state.copyWith(viewState: const ViewState.loading()));

    try {
      final result = await repository.saveDeviceInvoice(
        quoteId: quoteId,
        invoice: state.invoice!,
      );
      debugPrint('Device invoice uploaded for Quote ID: $quoteId');
      emit(state.copyWith(viewState: ViewState.success(result)));
    } catch (e, s) {
      debugPrint('Error uploading device invoice: $e');
      emit(state.copyWith(viewState: ViewState.error('$e\n$s')));
      debugPrintStack(stackTrace: s);
    }
  }
}
