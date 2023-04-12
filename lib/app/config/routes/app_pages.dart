import '../../features/dashboard/views/screens/dashboard_screen.dart';
import 'package:get/get.dart';

import '../../login/screens/home.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened, this page will be the first to be shown
  static const initial = Routes.dashboard;
  static const initialHome = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.home,
      page: () =>  Home(),
       binding: DashboardBinding(),
    ),
  ];
}
