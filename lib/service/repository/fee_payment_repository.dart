import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/core/resources/firebase_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/service/model/fees_payment_model.dart';
import 'package:gym/service/model/members_model.dart';
import 'package:uuid/uuid.dart';

class FeesPaymentRepsoitory {
  final FirebaseFirestore firebaseDb;
  FeesPaymentRepsoitory({
    required this.firebaseDb,
  });

  newFeePayment({required FeesPaymentModel feesPaymentModel}) {
    final uid = getIt<Uuid>();
    return firebaseDb
        .collection(FirebaseResources.payment)
        .doc(uid.v4())
        .set(feesPaymentModel.toMap())
        .then((value) {
      final packageExpiryDate =
          DateTime.now().add(Duration(days: feesPaymentModel.totalDuration!));
      firebaseDb.collection('members').doc(feesPaymentModel.memberuid).update({
        'packageDuration': feesPaymentModel.totalDuration,
        'lastFeesPaid': DateTime.now().millisecondsSinceEpoch,
        'packageEndDate': packageExpiryDate.millisecondsSinceEpoch
      });
    });
  }

  newExpense({required FeesPaymentModel feesPaymentModel}) {
    final uid = getIt<Uuid>();
    return firebaseDb
        .collection(FirebaseResources.payment)
        .doc(uid.v4())
        .set(feesPaymentModel.toMap());
  }

  Future<List<FeesPaymentModel>> getFeePaymentByDate(
      {required DateTime dateTime}) {
    return firebaseDb
        .collection(FirebaseResources.payment)
        .where('feesDate', isEqualTo: dateTime)
        .get()
        .then((value) =>
            value.docs.map((e) => FeesPaymentModel.fromMap(e.data())).toList());
  }

  Future<List<MembersModel>> getPendingFeePaymentsByDate(
      {required DateTime dateTime}) {
    return firebaseDb
        .collection(FirebaseResources.members)
        .where('packageEndDate',
            isLessThanOrEqualTo: dateTime.millisecondsSinceEpoch)
        .get()
        .then((value) =>
            value.docs.map((e) => MembersModel.fromMap(e.data())).toList());
  }

  Future<List<FeesPaymentModel>> getFeePaymentsDetailsByUserId(
      {required String memberUid}) {
    return firebaseDb
        .collection(FirebaseResources.payment)
        .where('memberuid', isEqualTo: memberUid)
        .get()
        .then((value) =>
            value.docs.map((e) => FeesPaymentModel.fromMap(e.data())).toList());
  }

  Future<List<FeesPaymentModel>> getRecentTransactions({
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    log("formDate => ${fromDate.millisecondsSinceEpoch}, toDate => ${toDate.millisecondsSinceEpoch}");
    var result = await firebaseDb
        .collection(FirebaseResources.payment)
        .where('paymentDate',
            isGreaterThanOrEqualTo: fromDate.millisecondsSinceEpoch)
        .where('paymentDate',
            isLessThanOrEqualTo: toDate.millisecondsSinceEpoch)
        .get();
    if (result.docs.isEmpty) {
      log('No transactions found in the given date range.');
    } else {
      log('Transactions found: ${result.docs.length}');
    }
    return result.docs.map((e) => FeesPaymentModel.fromMap(e.data())).toList();
  }
}
