import 'package:flutter/cupertino.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/presentation/screens/landing_screen.dart';
import 'package:gym/presentation/screens/login_screen.dart';
import 'package:gym/presentation/screens/splash_screen.dart';

class PageRouters {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == PageResources.splashScreen) {
      return CupertinoPageRoute(
        builder: (context) => const SplashScreen(),
      );
    }
    if (settings.name == PageResources.loginScreen) {
      return CupertinoPageRoute(
        builder: (context) => const LoginScreen(),
      );
    } else {
      return CupertinoPageRoute(
        builder: (context) => const LandingScreen(),
      );
    }
  }
}
