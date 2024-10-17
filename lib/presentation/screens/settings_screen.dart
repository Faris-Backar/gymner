import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:gym/core/resources/page_resources.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu_rounded),
        ),
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSettingsOption(
              context: context,
              label: 'Packages',
              icon: Icons.arrow_forward_ios_rounded,
              onTap: () =>
                  Navigator.of(context).pushNamed(PageResources.packagePage),
            ),
            _buildSettingsOption(
              context: context,
              label: 'Fees payment',
              icon: Icons.arrow_forward_ios_rounded,
              onTap: () => Navigator.of(context)
                  .pushNamed(PageResources.feePaymentScreen),
            ),
            _buildSettingsOption(
              context: context,
              label: 'Expenses',
              icon: Icons.arrow_forward_ios_rounded,
              onTap: () =>
                  Navigator.of(context).pushNamed(PageResources.expensesScreen),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable method to build each setting option
  Widget _buildSettingsOption({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 5.h,
                  // Uncomment this when you add your icon assets
                  // child: Image.asset(AssetResources.rupee),
                ),
                SizedBox(
                    width: 3.w), // Add some spacing between the icon and label
                Text(
                  label,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}
