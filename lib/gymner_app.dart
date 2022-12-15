import 'package:flutter/material.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/presentation/screens/splash_screen.dart';
import 'package:gym/routes/page_routers.dart';
import 'package:sizer/sizer.dart';

class Gymner extends StatelessWidget {
  const Gymner({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Montserrat'),
        onGenerateRoute: PageRouters.generateRoute,
        initialRoute: PageResources.landingScreen,
      ),
    );
  }
}
