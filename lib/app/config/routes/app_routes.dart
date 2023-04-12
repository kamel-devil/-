part of 'app_pages.dart';

/// used to switch pages
class Routes {
  static const dashboard = _Paths.dashboard;
  static const home = _Paths.home;
}

/// contains a list of route names.
// made separately to make it easier to manage route naming
class _Paths {
   static const home = '/home';

  static const dashboard = '/dashboard';

  // Example :
  // static const index = '/';
  // static const product = '/product';
}
