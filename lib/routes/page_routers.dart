import 'package:flutter/cupertino.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/presentation/screens/add_member_screen.dart';
import 'package:gym/presentation/screens/create_package_screen.dart';
import 'package:gym/presentation/screens/home_screen.dart';
import 'package:gym/presentation/screens/landing_screen.dart';
import 'package:gym/presentation/screens/login_screen.dart';
import 'package:gym/presentation/screens/member_screen.dart';
import 'package:gym/presentation/screens/package_screen.dart';
import 'package:gym/presentation/screens/settings_screen.dart';
import 'package:gym/presentation/screens/splash_screen.dart';

class PageRouters {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == PageResources.splashScreen) {
      return CupertinoPageRoute(
        builder: (context) => const SplashScreen(),
      );
    } else if (settings.name == PageResources.loginScreen) {
      return CupertinoPageRoute(
        builder: (context) => const LoginScreen(),
      );
    } else if (settings.name == PageResources.homeScreen) {
      return CupertinoPageRoute(
        builder: (context) => const HomeScreen(),
      );
    } else if (settings.name == PageResources.addMemberScreen) {
      return CupertinoPageRoute(
        builder: (context) => const AddMemberScreen(),
      );
    } else if (settings.name == PageResources.settingsScreen) {
      return CupertinoPageRoute(
        builder: (context) => const SettingsScreen(),
      );
    } else if (settings.name == PageResources.createPackageScreen) {
      return CupertinoPageRoute(
        builder: (context) => const CreatePackageScreen(),
      );
    } else if (settings.name == PageResources.packagePage) {
      return CupertinoPageRoute(
        builder: (context) => const PackageScreen(),
      );
    } else if (settings.name == PageResources.memberScreen) {
      return CupertinoPageRoute(
        builder: (context) => const MemberScreen(),
      );
    } else {
      return CupertinoPageRoute(
        builder: (context) => const LandingScreen(),
      );
    }
  }
}
