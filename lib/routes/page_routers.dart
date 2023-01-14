import 'package:flutter/cupertino.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/presentation/screens/add_member_screen.dart';
import 'package:gym/presentation/screens/create_package_screen.dart';
import 'package:gym/presentation/screens/fee_payment_screen.dart';
import 'package:gym/presentation/screens/home_screen.dart';
import 'package:gym/presentation/screens/landing_screen.dart';
import 'package:gym/presentation/screens/login_screen.dart';
import 'package:gym/presentation/screens/member_screen.dart';
import 'package:gym/presentation/screens/package_screen.dart';
import 'package:gym/presentation/screens/pending_fee_screen.dart';
import 'package:gym/presentation/screens/settings_screen.dart';
import 'package:gym/presentation/screens/sms_share_screen.dart';
import 'package:gym/presentation/screens/splash_screen.dart';
import 'package:gym/presentation/screens/view_members_screen.dart';
import 'package:gym/service/model/members_model.dart';
import 'package:gym/service/model/sms_model.dart';

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
    } else if (settings.name == PageResources.smsScreen) {
      final pendingMembersList = settings.arguments as List<SmsModel>;
      return CupertinoPageRoute(
        builder: (context) =>
            SmsShareScreen(pendingMembersList: pendingMembersList),
      );
    } else if (settings.name == PageResources.settingsScreen) {
      return CupertinoPageRoute(
        builder: (context) => const SettingsScreen(),
      );
    } else if (settings.name == PageResources.feePaymentScreen) {
      return CupertinoPageRoute(
        builder: (context) => const FeePaymentScreen(),
      );
    } else if (settings.name == PageResources.createPackageScreen) {
      return CupertinoPageRoute(
        builder: (context) => const CreatePackageScreen(),
      );
    } else if (settings.name == PageResources.packagePage) {
      return CupertinoPageRoute(
        builder: (context) => const PackageScreen(),
      );
    } else if (settings.name == PageResources.pendingFeeScreen) {
      return CupertinoPageRoute(
        builder: (context) => const PendingFeeScreen(),
      );
    } else if (settings.name == PageResources.memberScreen) {
      return CupertinoPageRoute(
        builder: (context) => const MemberScreen(),
      );
    } else if (settings.name == PageResources.viewMembersScreen) {
      final args = settings.arguments as MembersModel;
      return CupertinoPageRoute(
        builder: (context) => ViewMembersScreen(membersModel: args),
      );
    } else {
      return CupertinoPageRoute(
        builder: (context) => const LandingScreen(),
      );
    }
  }
}
