import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/presentation/bloc/auth/auth_bloc.dart';
import 'package:gym/presentation/bloc/fee_package/package_cubit.dart';
import 'package:gym/presentation/bloc/fee_payment/fee_payment_bloc.dart';
import 'package:gym/presentation/bloc/members/members_bloc.dart';
import 'package:gym/presentation/bloc/fee_pending/fee_pending_bloc.dart';
import 'package:gym/routes/page_routers.dart';
import 'package:sizer/sizer.dart';

class Gymner extends StatelessWidget {
  const Gymner({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<AuthBloc>()),
          BlocProvider.value(value: getIt<PackageCubit>()),
          BlocProvider.value(value: getIt<MembersBloc>()),
          BlocProvider.value(value: getIt<FeePaymentBloc>()),
          BlocProvider.value(value: getIt<FeePendingBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Montserrat',
            scaffoldBackgroundColor: StyleResources.accentColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: StyleResources.accentColor,
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0.0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          onGenerateRoute: PageRouters.generateRoute,
          initialRoute: PageResources.landingScreen,
        ),
      ),
    );
  }
}
