import 'package:boilerplate/src/shared/models/faq.dart';
import 'package:boilerplate/src/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaqCubit extends Cubit<ViewState<List<Faq>>> {
  FaqCubit(this.repository) : super(const ViewState.initial());

  final DashboardRepository repository;

  Future<void> fetchFaqs() async {
    try {

      final faqs = await repository.faqs();
      emit(ViewState.success(faqs));
    } catch (e) {
      emit(ViewState.error(e.toString()));
    }
  }
}