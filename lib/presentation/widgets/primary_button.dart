import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../core/resources/style_resources.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.label,
    this.ontap,
    this.child,
  }) : super(key: key);
  final String label;
  final Function()? ontap;
  final Widget? child;
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
              color: StyleResources.secondaryColor),
          alignment: Alignment.center,
          child: child ??
              Text(
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
