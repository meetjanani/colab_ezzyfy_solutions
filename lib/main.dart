import 'package:colab_ezzyfy_solutions/dependency_injection.dart';
import 'package:colab_ezzyfy_solutions/notification_services.dart';
import 'package:colab_ezzyfy_solutions/route/app_module.dart';
import 'package:colab_ezzyfy_solutions/route/route.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/splashpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



void main() async {
  await Get.putAsync(() => GetStorage.init());
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  //await FirebaseApi().initNotification();
  DependencyInjection.init();
  runApp(const MyApp(


  ));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //final NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    /*notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken().then((value) {

    });*/
  }

  @override
  Widget build(BuildContext context) => SimpleBuilder(



      builder: (_) => GetMaterialApp(
          key: UniqueKey(),
          debugShowCheckedModeBanner: false,
          enableLog: true,
          // supportedLocales: flc.supportedLocales.map((e) => Locale(e)),
          // localizationsDelegates: const [
          //   flc.CountryLocalizations.delegate,
          // ],
          initialRoute: AppRoute.splash,
          routes:  {
            AppRoute.notification: (context) =>  SplashPage()
          },
          getPages: AppPage.routes)

  );
}


