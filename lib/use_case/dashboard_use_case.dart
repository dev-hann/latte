import 'package:latte/model/dashboard.dart';
import 'package:latte/service/dashboard_service.dart';

class DashboardUseCase {
  final service = DashboardService();

  Future<Dashboard> requestDashboard() async {
    return Dashboard(
      top100List: await service.requestTop100(),
      hot100List: await service.requestHot100(),
      new50List: await service.requestNew50(),
      djList: await service.requestDjChart(),
    );
  }
}
