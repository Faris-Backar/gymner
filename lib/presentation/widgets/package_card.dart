import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/resources/style_resources.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    super.key,
    required this.title,
    required this.price,
  });
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 20.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        gradient: const LinearGradient(
            colors: [Color(0xff9bafd9), Color(0xff103783)]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: StyleResources.accentColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '\u{20B9} $price',
            style: TextStyle(
              color: StyleResources.accentColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
