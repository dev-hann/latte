import 'package:latte/model/dashboard.dart';
import 'package:latte/service/dashboard_service.dart';

class DashboardUseCase {
  final service = DashboardService();

  Future<Dashboard> requestDashboard() {
    return service.requestDashboard();
  }
}
