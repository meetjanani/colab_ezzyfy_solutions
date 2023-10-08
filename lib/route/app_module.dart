import 'package:colab_ezzyfy_solutions/binding/Auth/login_bindiing.dart';
import 'package:colab_ezzyfy_solutions/binding/Auth/register_binding.dart';
import 'package:colab_ezzyfy_solutions/binding/add_user_binding.dart';
import 'package:colab_ezzyfy_solutions/binding/create_project_binding.dart';
import 'package:colab_ezzyfy_solutions/binding/splash_binding.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/Auth/login_page.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/Auth/register_page.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/coming_soon_page.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/project/add_user_page.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/project/full_screen_image_page.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/project/project_attachment_list_page.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/project/project_list_page.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/project/project_site_visit_list_page.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/splashpage.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/bottom_navigation_bar.dart';
import 'package:get/route_manager.dart';


import '../binding/home_dashboard_bindiing.dart';
import '../binding/project_details_binding.dart';
import '../binding/project_list_binding.dart';
import '../binding/project_site_visit_list_binding.dart';
import '../ui/pages/project/create_project_page.dart';
import '../ui/pages/project/project_details_page.dart';
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
        page: () => BottomNavigationPage(currentIndex: 0),
        binding: HomeDashboardBinding()),

    // Home
    GetPage(
        name: AppRoute.createProject,
        page: () => const CreateProjectPage(),
        binding: CreateProjectBinding()),

    GetPage(
        name: AppRoute.projectList,
        page: () => const ProjectListPage(),
        binding: ProjectListBinding()),

    GetPage(
        name: AppRoute.projectAttachmentList,
        page: () => const ProjectAttachmentListPage(),
        binding: ProjectDetailsBinding()),

    GetPage(
        name: AppRoute.projectSiteVisitList,
        page: () => const ProjectSiteVisitListPage(),
        binding: ProjectSiteVisitListBinding()),

    GetPage(
        name: AppRoute.projectFullScreenAttachment,
        page: () => const FullScreenImagePage(),
        binding: ProjectDetailsBinding()),

    GetPage(
      name: AppRoute.projectDetails,
      page: () => const ProjectDetailsPage(),
      binding: ProjectDetailsBinding(),),

    GetPage(
        name: AppRoute.addUser,
        page: () => const AddUserPage(),
        binding: AddUserBinding()),

    // Have to add binding
    GetPage(
        name: AppRoute.comingSoonPage,
        page: () => const ComingSoonPage(),),
  ];
}
