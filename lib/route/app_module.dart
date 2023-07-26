import 'package:colab_ezzyfy_solutions/binding/Auth/login_bindiing.dart';
import 'package:colab_ezzyfy_solutions/binding/Auth/register_binding.dart';
import 'package:colab_ezzyfy_solutions/binding/create_project_binding.dart';
import 'package:colab_ezzyfy_solutions/binding/splash_binding.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/Auth/login_page.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/Auth/register_page.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/home_dashboard/create_project_page.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/home_dashboard/home_dashboard_page.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/splashpage.dart';
import 'package:get/route_manager.dart';


import '../binding/home_dashboard_bindiing.dart';
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
    GetPage(
        name: AppRoute.home,
        page: () => const HomeDashboardPage(),
        binding: HomeDashboardBinding()),

    // Home
    GetPage(
        name: AppRoute.createProject,
        page: () => const CreateProjectPage(),
        binding: CreateProjectBinding()),

  ];
}
