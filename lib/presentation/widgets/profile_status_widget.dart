import 'package:flutter/material.dart';

class PackageStatusWidget extends StatelessWidget {
  final DateTime packageEndDate;

  const PackageStatusWidget({super.key, required this.packageEndDate});

  bool isPackageOver(DateTime packageEndDate) {
    DateTime currentDate = DateTime.now();
    return currentDate.isAfter(packageEndDate);
  }

  @override
  Widget build(BuildContext context) {
    bool isExpired = isPackageOver(packageEndDate);

    return Text(
      isExpired ? 'Expired' : 'Active',
      style: TextStyle(
        color: isExpired ? Colors.red : Colors.green,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
