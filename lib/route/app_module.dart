import 'package:colab_ezzyfy_solutions/binding/Auth/login_bindiing.dart';
import 'package:colab_ezzyfy_solutions/binding/Auth/register_binding.dart';
import 'package:colab_ezzyfy_solutions/binding/splash_binding.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/Auth/login_page.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/Auth/register_page.dart';
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

    //Auth
    GetPage(
        name: AppRoute.login,
        page: () => const LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoute.register,
        page: () => const RegisterPage(),
        binding: RegisterBinding()),

  ];
}
