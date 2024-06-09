import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latte/model/dashboard.dart';
import 'package:latte/use_case/dashboard_use_case.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<DashboardInited>(_onInited);
  }
  final useCase = DashboardUseCase();

  FutureOr<void> _onInited(
      DashboardInited event, Emitter<DashboardState> emit) async {
    final dashboard = await useCase.requestDashboard();
    emit(
      state.copyWith(
        dashboard: dashboard,
      ),
    );
  }
}
