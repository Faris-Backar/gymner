import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:gym/core/resources/asset_resources.dart';
import 'package:gym/core/resources/style_resources.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordVisible = false;
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
                TextInputFormField(
                  controller: _usernameController,
                  hint: 'Email',
                  prefixIcon: const Icon(Icons.alternate_email_rounded),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextInputFormField(
                  hint: 'Password',
                  controller: _passwordController,
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => isPasswordVisible = !isPasswordVisible),
                    icon: isPasswordVisible
                        ? const Icon(Icons.visibility_off_rounded)
                        : const Icon(Icons.visibility_rounded),
                  ),
                  isPasswordVisible: isPasswordVisible,
                ),
                SizedBox(
                  height: 6.h,
                ),
                const PrimaryButton(label: 'Login '),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.label,
    this.ontap,
  }) : super(key: key);
  final String label;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: 7.h,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: StyleResources.primaryColor),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class TextInputFormField extends StatelessWidget {
  const TextInputFormField({
    Key? key,
    this.hint,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.isPasswordVisible,
    this.textInputAction,
    this.textInputType,
  }) : super(key: key);
  final String? hint;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isPasswordVisible;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPasswordVisible ?? false,
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: StyleResources.primaryColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: StyleResources.errorColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: StyleResources.primaryColor),
        ),
        hintText: hint,
      ),
    );
  }
}
