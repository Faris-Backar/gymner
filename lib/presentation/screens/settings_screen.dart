import 'package:flutter/material.dart';
import 'package:gym/core/resources/asset_resources.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/presentation/widgets/default_back_button.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const DefaultBackButton(),
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(PageResources.packagePage),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 5.h,
                          // child: Image.asset(AssetResources.rupee),
                        ),
                        Text(
                          'Control Packages',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
