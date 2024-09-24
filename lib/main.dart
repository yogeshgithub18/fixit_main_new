import 'dart:io';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixit/pushNotification.dart';
import 'package:fixit/ui_screens/auth/controller/login_controller.dart';
import 'package:fixit/ui_screens/auth/controller/signup_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'Routes/Theme1AppPages.dart';
import 'change_language/LocalString.dart';
import 'change_language/choose_language_controller.dart';
import 'common/myTheme.dart';
import 'firebase_options.dart';

String deviceToken = '';
const String apiItemLimit = "10";

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService().setupInteractedMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final ThemeController themeController = ThemeController();
  await themeController.loadSavedThemeMode();
  await FirebaseAppCheck.instance.activate(
     androidProvider: AndroidProvider.playIntegrity,
     appleProvider: AppleProvider.deviceCheck,
  );
  Get.lazyPut(() => AuthController(), fenix: true);
  Get.lazyPut(() => LoginController(), fenix: true);
  Get.put(ChooseLanguageController());
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
  await Permission.notification.isDenied.then((bool value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white54,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1,alwaysUse24HourFormat: false),
              child: child!,
            );
          },
          title: 'FixIt',
          themeMode: brightness == Brightness.light
              ? ThemeMode.light
              : ThemeMode.dark,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
          initialRoute: Theme1AppPages.initial,
          getPages: Theme1AppPages.routes,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ar'),
            // Locale('ku'),
          ],
          locale:Locale(Get.find<ChooseLanguageController>().selectedLanguage.value),
          translations: LocaleString(),
          // theme: ThemeData(
          //   primarySwatch: MaterialColor(0xFF039759, getSwatch(const Color(0xFF039759))),
          //   fontFamily: 'Ariel',
          // ),
        );
      },
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}