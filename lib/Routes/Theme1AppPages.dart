import 'package:fixit/ui_screens/auth/signup.dart';
import 'package:fixit/ui_screens/auth/welcomeScreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../ui_screens/auth/login.dart';
import '../ui_screens/home/home.dart';
import '../ui_screens/locations/add_location.dart';
import '../ui_screens/locations/set_locations_screen.dart';
import '../ui_screens/splash/splash_view.dart';
import 'app_routes.dart';

class Theme1AppPages{
  static const initial = Routes.splash;
  static final routes = [
  GetPage(name: Routes.splash, page: () => const SplashView()),
  GetPage(name: Routes.welcome, page: () => const WelcomeScreen()),
  GetPage(name: Routes.loginScreen, page: () => const LoginScreen()),
  GetPage(name: Routes.signUpScreen, page: () => const SignUpScreen()),
  GetPage(name: Routes.setLocation, page: () => const SetLocation()),
  GetPage(name: Routes.addLocation, page: () => AddLocation()),
  GetPage(name: Routes.home, page: () => const Home()),
  ];
}