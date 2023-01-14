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
