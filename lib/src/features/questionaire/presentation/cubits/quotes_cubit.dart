import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/quote.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/step.dart';
import 'package:boilerplate/src/features/questionaire/domain/repositories/questionnaire_repository.dart';
import 'package:boilerplate/src/features/questionaire/domain/repositories/quotes_repository.dart';
import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuotesState {
  const QuotesState({
    required this.imei,
    required this.deviceId,
    required this.viewState,
  });

  static const initial = QuotesState(
    imei: Imei(''),
    deviceId: '',
    viewState: ViewState.initial(),
  );

  final Imei imei;

  final String deviceId;

  final ViewState<Quote> viewState;

  QuotesState copyWith({
    Imei? imei,
    String? deviceId,
    ViewState<Quote>? viewState,
  }) {
    return QuotesState(
      imei: imei ?? this.imei,
      deviceId: deviceId ?? this.deviceId,
      viewState: viewState ?? this.viewState,
    );
  }
}

class QuotesCubit extends Cubit<QuotesState> {
  QuotesCubit(this.repository) : super(QuotesState.initial);

  final QuotesRepository repository;

  void imeiChanged(String imei) {
    emit(state.copyWith(imei: Imei(imei)));
  }

  void deviceIdChanged(String deviceId) {
    emit(state.copyWith(deviceId: deviceId));
  }

  Future<void> submitImei() async {
    if (state.imei.value.isEmpty) {
      emit(
        state.copyWith(
          viewState: const ViewState.error('IMEI cannot be empty'),
        ),
      );
      return;
    }

    emit(state.copyWith(viewState: const ViewState.loading()));

    try {
      final quote = await repository.createQuote(
        CreateQuoteInput(deviceId: state.deviceId, imei: state.imei.value),
      );
      debugPrint('Quote created with ID: ${quote.id}');
      emit(state.copyWith(viewState: ViewState.success(quote)));
    } catch (e) {
      debugPrint('Error creating quote: $e');
      emit(state.copyWith(viewState: ViewState.error(e.toString())));
    }
  }
}
