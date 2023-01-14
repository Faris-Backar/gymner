import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/core/resources/firebase_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/service/model/fees_payment_model.dart';
import 'package:gym/service/model/members_model.dart';
import 'package:gym/service/model/transaction_model.dart';
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
          DateTime.now().add(Duration(days: feesPaymentModel.totalDuration));
      firebaseDb.collection('members').doc(feesPaymentModel.memberuid).update({
        'packageDuration': feesPaymentModel.totalDuration,
        'lastFeesPaid': DateTime.now().millisecondsSinceEpoch,
        'packageEndDate': packageExpiryDate.millisecondsSinceEpoch
      });
    });
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

  Future<List<FeesPaymentModel>> getRecentTransactions() {
    return firebaseDb
        .collection(FirebaseResources.payment)
        .limit(10)
        .get()
        .then((value) =>
            value.docs.map((e) => FeesPaymentModel.fromMap(e.data())).toList());
  }
}
