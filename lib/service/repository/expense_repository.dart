import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/core/resources/firebase_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/service/model/fees_payment_model.dart';
import 'package:uuid/uuid.dart';

class ExpenseRepository {
  final FirebaseFirestore firebaseDb;
  ExpenseRepository({
    required this.firebaseDb,
  });

  // Add new expense
  Future<void> addExpense({required FeesPaymentModel expenseModel}) {
    final uid = getIt<Uuid>();
    return firebaseDb
        .collection(FirebaseResources.payment)
        .doc(uid.v4())
        .set(expenseModel.toMap())
        .then((value) {
      log("Expense added successfully");
    }).catchError((error) {
      log("Failed to add expense: $error");
    });
  }

  // Fetch expenses based on a date range
  Future<List<FeesPaymentModel>> getExpensesByDateRange({
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    log("Fetching expenses from ${fromDate.millisecondsSinceEpoch} to ${toDate.millisecondsSinceEpoch}");
    var result = await firebaseDb
        .collection(FirebaseResources.expense)
        .where('expenseDate',
            isGreaterThanOrEqualTo: fromDate.millisecondsSinceEpoch)
        .where('expenseDate',
            isLessThanOrEqualTo: toDate.millisecondsSinceEpoch)
        .get();
    if (result.docs.isEmpty) {
      log('No expenses found in the given date range.');
    } else {
      log('Expenses found: ${result.docs.length}');
    }
    return result.docs.map((e) => FeesPaymentModel.fromMap(e.data())).toList();
  }

  // Fetch expense details by expense ID
  Future<FeesPaymentModel?> getExpenseById({required String expenseId}) async {
    var doc = await firebaseDb
        .collection(FirebaseResources.expense)
        .doc(expenseId)
        .get();
    if (doc.exists) {
      return FeesPaymentModel.fromMap(doc.data()!);
    } else {
      log("Expense not found for id: $expenseId");
      return null;
    }
  }

  // Fetch all expenses
  Future<List<FeesPaymentModel>> getAllExpenses() async {
    var result = await firebaseDb.collection(FirebaseResources.expense).get();
    if (result.docs.isEmpty) {
      log('No expenses found.');
    } else {
      log('Total expenses found: ${result.docs.length}');
    }
    return result.docs.map((e) => FeesPaymentModel.fromMap(e.data())).toList();
  }

  // Fetch recent expenses (similar to transactions in the fee payment repository)
  Future<List<FeesPaymentModel>> getRecentExpenses({
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    log("Fetching recent expenses from ${fromDate.millisecondsSinceEpoch} to ${toDate.millisecondsSinceEpoch}");
    var result = await firebaseDb
        .collection(FirebaseResources.expense)
        .where('expenseDate',
            isGreaterThanOrEqualTo: fromDate.millisecondsSinceEpoch)
        .where('expenseDate',
            isLessThanOrEqualTo: toDate.millisecondsSinceEpoch)
        .get();
    if (result.docs.isEmpty) {
      log('No recent expenses found.');
    } else {
      log('Recent expenses found: ${result.docs.length}');
    }
    return result.docs.map((e) => FeesPaymentModel.fromMap(e.data())).toList();
  }
}
