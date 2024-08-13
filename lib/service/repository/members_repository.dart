import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gym/core/constants/dashboard_constants.dart';

import 'package:gym/core/resources/firebase_resources.dart';
import 'package:gym/service/model/members_model.dart';

class MembersRepository {
  final FirebaseFirestore db;
  final FirebaseStorage storage;
  MembersRepository({
    required this.db,
    required this.storage,
  });

  createMember({required MembersModel membersModel}) {
    return db
        .collection(FirebaseResources.members)
        .doc(membersModel.uid)
        .set(membersModel.toMap());
  }

  Future<List<MembersModel>> getMembers() {
    return db.collection(FirebaseResources.members).get().then((snapshot) =>
        snapshot.docs.map((e) => MembersModel.fromMap(e.data())).toList());
  }

  Future<MembersModel> getIndividualMembers({required String uid}) {
    return db
        .collection(FirebaseResources.members)
        .doc(uid)
        .get()
        .then((snapshot) => MembersModel.fromMap(snapshot.data()!));
  }

  List<MembersModel> searchMembers({
    required String searchQuery,
    required List<MembersModel> membersList,
    String? filterByPackageQuery,
    String? filterByStatusQuery,
  }) {
    return membersList.where((member) {
      final matchesName =
          member.name.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesStatus = filterByStatusQuery == null ||
          filterByStatusQuery ==
              DashboardConstants.filterByActiveStatusDropdownOptions.first ||
          (filterByStatusQuery ==
                  DashboardConstants.filterByActiveStatusDropdownOptions[1] &&
              member.isActive == true) ||
          (filterByStatusQuery ==
                  DashboardConstants.filterByActiveStatusDropdownOptions[2] &&
              member.isActive == false);

      final matchesPackage = filterByPackageQuery == null ||
          filterByPackageQuery == "All" ||
          member.packageModel.name == filterByPackageQuery;

      return matchesName && matchesStatus && matchesPackage;
    }).toList();
  }

  Future<List<MembersModel>> getMembersExpiringWithin3Days() async {
    // Calculate the date range
    DateTime now = DateTime.now();
    DateTime threeDaysLater = now.add(const Duration(days: 3));

    // Convert to Timestamp for Firestore query
    Timestamp nowTimestamp = Timestamp.fromDate(now);
    Timestamp threeDaysLaterTimestamp = Timestamp.fromDate(threeDaysLater);

    // Query Firestore
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('members')
        .where('packageEndDate', isGreaterThanOrEqualTo: nowTimestamp)
        .where('packageEndDate', isLessThanOrEqualTo: threeDaysLaterTimestamp)
        .get();

    // Convert query results to MembersModel objects
    List<MembersModel> expiringMembers = querySnapshot.docs
        .map((doc) => MembersModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    return expiringMembers;
  }

  Future<List<MembersModel>> getMembersExpiringWithin7Days() async {
    // Calculate the date range
    DateTime now = DateTime.now().add(const Duration(days: 3));
    DateTime threeDaysLater = now.add(const Duration(days: 7));

    // Convert to Timestamp for Firestore query
    Timestamp nowTimestamp = Timestamp.fromDate(now);
    Timestamp threeDaysLaterTimestamp = Timestamp.fromDate(threeDaysLater);

    // Query Firestore
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('members')
        .where('packageEndDate', isGreaterThanOrEqualTo: nowTimestamp)
        .where('packageEndDate', isLessThanOrEqualTo: threeDaysLaterTimestamp)
        .get();

    // Convert query results to MembersModel objects
    List<MembersModel> expiringMembers = querySnapshot.docs
        .map((doc) => MembersModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    return expiringMembers;
  }

  Future<List<MembersModel>> getMembersExpiringWithin30Days() async {
    // Calculate the date range
    DateTime now = DateTime.now().add(const Duration(days: 7));
    DateTime threeDaysLater = now.add(const Duration(days: 30));

    // Convert to Timestamp for Firestore query
    Timestamp nowTimestamp = Timestamp.fromDate(now);
    Timestamp threeDaysLaterTimestamp = Timestamp.fromDate(threeDaysLater);

    // Query Firestore
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('members')
        .where('packageEndDate', isGreaterThanOrEqualTo: nowTimestamp)
        .where('packageEndDate', isLessThanOrEqualTo: threeDaysLaterTimestamp)
        .get();

    // Convert query results to MembersModel objects
    List<MembersModel> expiringMembers = querySnapshot.docs
        .map((doc) => MembersModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    return expiringMembers;
  }

  List<MembersModel> getExpiredMembers({required List<MembersModel> members}) {
    return members.where((member) {
      if (member.lastFeesPaid == null) {
        return true;
      }
      return member.lastFeesPaid!.isBefore(DateTime.now());
    }).toList();
  }
}
