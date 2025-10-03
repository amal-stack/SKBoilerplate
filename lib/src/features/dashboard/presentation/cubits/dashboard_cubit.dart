import 'package:boilerplate/src/features/dashboard/domain/entities/dashboard.dart';
import 'package:boilerplate/src/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef DashboardState = ViewState<Dashboard>;

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this.repository) : super(const DashboardState.initial());

  final DashboardRepository repository;

  Future<void> fetchDashboardData() async {
    try {
      final dashboard = await repository.dashboardData();
      emit(DashboardState.success(dashboard));
    } catch (e) {
      emit(DashboardState.error(e.toString()));
    }
  }
}
