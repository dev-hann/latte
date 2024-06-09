// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  const DashboardState({
    this.dashboard,
  });
  final Dashboard? dashboard;

  @override
  List<Object?> get props => [
        dashboard,
      ];

  DashboardState copyWith({
    Dashboard? dashboard,
  }) {
    return DashboardState(
      dashboard: dashboard ?? this.dashboard,
    );
  }
}
