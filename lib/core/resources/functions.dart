import 'package:flutter/material.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:intl/intl.dart';

getSnackBar(BuildContext context, {required String title, Color? bgcolor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        title,
        style: const TextStyle(color: StyleResources.accentColor),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: bgcolor ?? StyleResources.primaryColor,
    ),
  );
}

String dateFormate({required DateTime date, String? formate}) {
  return DateFormat(formate ?? 'dd-MMM-yyyy').format(date);
}

String calculateDaysAfterExpiration(DateTime expirationDate) {
  DateTime currentDate = DateTime.now();

  // Calculate the difference between the current date and expiration date
  int differenceInDays = currentDate.difference(expirationDate).inDays;

  // If the difference is negative (expiration date is in the future), return 0
  return differenceInDays > 0 ? "$differenceInDays days" : "0";
}

String calculatePackageDays(DateTime expirationDate) {
  DateTime currentDate = DateTime.now();

  // Calculate the difference in days between current date and expiration date
  int differenceInDays = expirationDate.difference(currentDate).inDays;

  // If the expiration date is in the future, return pending days
  if (differenceInDays > 0) {
    return "$differenceInDays days left";
  }
  // If the expiration date is in the past, return expired days
  else {
    return "${-differenceInDays} days after expiration";
  }
}
