import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  bool isPasswordVisible = true;
  bool checkboxSelectedValue = false;
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Login to your account",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10.h),
              TextInputFormField(
                controller: _usernameController,
                hint: 'Enter your email address',
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 2.h,
              ),
              TextInputFormField(
                hint: 'Enter your password',
                controller: _passwordController,
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => isPasswordVisible = !isPasswordVisible),
                  icon: isPasswordVisible
                      ? const Icon(Icons.visibility_off_rounded)
                      : const Icon(Icons.visibility_rounded),
                ),
                isPasswordVisible: isPasswordVisible,
                maxLines: 1,
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CheckboxMenuButton(
                      value: checkboxSelectedValue,
                      onChanged: (checkBoxValue) {
                        setState(() {
                          checkboxSelectedValue = checkBoxValue ?? false;
                        });
                      },
                      child: Text(
                        "Remeber Me",
                        style: TextStyle(fontSize: 10.sp),
                      )),
                  Text("Forget Password?",
                      style: TextStyle(fontSize: 10.sp, color: Colors.blue))
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  log(state.toString());

                  if (state is AuthError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                  if (state is AuthSucess) {
                    Navigator.of(context).pushNamed(PageResources.mainScreen);
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
              SizedBox(
                height: 4.h,
              ),
              Text(
                "Or Sign With",
                style: TextStyle(fontSize: 10.sp),
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(FontAwesomeIcons.facebookF,
                        color: Colors.blue),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 10.sp),
                  ),
                  InkWell(
                      onTap: () {},
                      child: Text(
                        "Signup",
                        style: TextStyle(fontSize: 10.sp, color: Colors.blue),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
