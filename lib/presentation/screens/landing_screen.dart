import 'package:flutter/material.dart';
import 'package:gym/core/resources/page_resources.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    Future.delayed(
        const Duration(
          seconds: 1,
        ),
        () => Navigator.of(context)
            .pushReplacementNamed(PageResources.splashScreen));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
