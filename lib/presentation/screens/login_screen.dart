import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/presentation/bloc/auth/auth_bloc.dart';
import 'package:gym/presentation/widgets/primary_button.dart';
import 'package:gym/presentation/widgets/text_input_form_field.dart';
import 'package:gym/service/model/auth_model.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:gym/core/resources/asset_resources.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordVisible = false;
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 30.h,
                  width: 60.w,
                  child: Image.asset(AssetResources.logo),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 6.h,
                  child: TextInputFormField(
                    controller: _usernameController,
                    hint: 'Email',
                    prefixIcon: const Icon(Icons.alternate_email_rounded),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 6.h,
                  child: TextInputFormField(
                    hint: 'Password',
                    controller: _passwordController,
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: IconButton(
                      onPressed: () => setState(
                          () => isPasswordVisible = !isPasswordVisible),
                      icon: isPasswordVisible
                          ? const Icon(Icons.visibility_off_rounded)
                          : const Icon(Icons.visibility_rounded),
                    ),
                    isPasswordVisible: isPasswordVisible,
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    log(state.toString());

                    if (state is AuthError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                    if (state is AuthSucess) {
                      Navigator.of(context).pushNamed(PageResources.homeScreen);
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return PrimaryButton(
                        label: '',
                        child: LottieBuilder.asset(AssetResources.dumbleWhite),
                      );
                    }
                    return PrimaryButton(
                        label: 'Login',
                        ontap: () {
                          final credential = AuthModel(
                            email: _usernameController.text,
                            password: _passwordController.text,
                          );
                          _authBloc.add(
                            LoginEvent(credentials: credential),
                          );
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
