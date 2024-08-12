import 'package:flutter/material.dart';
import 'package:gym/core/resources/asset_resources.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/core/resources/pref_resources.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(PrefResources.IS_LOGGED_IN);
    if (isLoggedIn != null) {
      Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.of(context)
            .pushReplacementNamed(PageResources.mainScreen),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.of(context)
            .pushReplacementNamed(PageResources.loginScreen),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleResources.accentColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40.h,
            width: 50.h,
            child: LottieBuilder.asset(
              AssetResources.dumble1,
              repeat: false,
            ),
          ),
          Text(
            'GYMNER',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Made with 🧡',
              style: TextStyle(fontSize: 10.sp),
            ),
          )
        ],
      ),
    );
  }
}
