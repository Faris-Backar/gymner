import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/service/model/package_model.dart';

class PackageRepository {
  final db = FirebaseFirestore.instance;

  Future<List<PackageModel>> getPackages() {
    try {
      return db.collection('packages').get().then((snapshot) =>
          snapshot.docs.map((e) => PackageModel.fromMap(e.data())).toList());
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }

  Future<void> createPackages({required PackageModel packageModel}) {
    try {
      return db
          .collection('packages')
          .doc(packageModel.uid)
          .set(packageModel.toMap());
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }
}
