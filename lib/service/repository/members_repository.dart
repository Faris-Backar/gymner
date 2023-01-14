import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import 'package:gym/core/resources/firebase_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/service/model/members_model.dart';

class MembersRepository {
  final FirebaseFirestore db;
  final FirebaseStorage storage;
  MembersRepository({
    required this.db,
    required this.storage,
  });

  createMember({required MembersModel membersModel}) {
    final uid = getIt<Uuid>();
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

  Future<List<MembersModel>> searchMembers({required String searchQuery}) {
    return db
        .collection(FirebaseResources.members)
        .where("name", isEqualTo: searchQuery)
        .get()
        .then((snapshot) =>
            snapshot.docs.map((e) => MembersModel.fromMap(e.data())).toList());
  }
}
