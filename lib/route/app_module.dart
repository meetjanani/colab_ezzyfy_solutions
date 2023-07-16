import 'package:colab_ezzyfy_solutions/binding/splash_binding.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/splashpage.dart';
import 'package:get/route_manager.dart';


import 'route.dart';

class AppPage {
  AppPage._();

  static final routes = [
    GetPage(
        name: AppRoute.splash,
        page: () => const SplashPage(),
        binding: SplashBinding()),

  ];
}
