import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../core/resources/style_resources.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.ontap,
    this.child,
  });
  final String label;
  final Function()? ontap;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: 6.h,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: StyleResources.black),
          alignment: Alignment.center,
          child: child ??
              Text(
                label,
                style: TextStyle(
                  color: StyleResources.accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
              ),
        ),
      ),
    );
  }
}
