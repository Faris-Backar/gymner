import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/service/model/package_model.dart';

class MembersModel {
  final String uid;
  final int registerNumber;
  final String name;
  final int mobileNumber;
  final int? age;
  final double? weight;
  final String? propicUrl;
  final PackageModel packageModel;
  final int? packageDuration;
  final DateTime? lastFeesPaid;
  final DateTime? packageEndDate;
  final bool? isActive;
  final bool? isBlocked;

  const MembersModel({
    required this.uid,
    required this.registerNumber,
    required this.name,
    required this.mobileNumber,
    this.age,
    this.weight,
    this.propicUrl,
    required this.packageModel,
    this.packageDuration,
    this.lastFeesPaid,
    this.packageEndDate,
    this.isActive,
    this.isBlocked,
  });

  MembersModel copyWith({
    String? uid,
    int? registerNumber,
    String? name,
    int? mobileNumber,
    int? age,
    double? weight,
    String? propicUrl,
    PackageModel? packageModel,
    int? packageDuration,
    DateTime? lastFeesPaid,
    DateTime? packageEndDate,
    bool? isActive,
    bool? isBlocked,
  }) {
    return MembersModel(
      uid: uid ?? this.uid,
      registerNumber: registerNumber ?? this.registerNumber,
      name: name ?? this.name,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      propicUrl: propicUrl ?? this.propicUrl,
      packageModel: packageModel ?? this.packageModel,
      packageDuration: packageDuration ?? this.packageDuration,
      lastFeesPaid: lastFeesPaid ?? this.lastFeesPaid,
      packageEndDate: packageEndDate ?? this.packageEndDate,
      isActive: isActive ?? this.isActive,
      isBlocked: isBlocked ?? this.isBlocked,
    );
  }

  /// Converts this model to a Map to store in Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'registerNumber': registerNumber,
      'name': name,
      'mobileNumber': mobileNumber,
      if (age != null) 'age': age,
      if (weight != null) 'weight': weight,
      if (propicUrl != null) 'propicUrl': propicUrl,
      'packageModel': packageModel.toMap(),
      if (packageDuration != null) 'packageDuration': packageDuration,
      if (lastFeesPaid != null)
        'lastFeesPaid': Timestamp.fromDate(lastFeesPaid!),
      if (packageEndDate != null)
        'packageEndDate': Timestamp.fromDate(packageEndDate!),
      if (isActive != null) 'isActive': isActive,
      if (isBlocked != null) 'isBlocked': isBlocked,
    };
  }

  /// Converts Map data from Firestore to MembersModel
  factory MembersModel.fromMap(Map<String, dynamic> map) {
    return MembersModel(
      uid: map['uid'] ?? '',
      registerNumber: map['registerNumber']?.toInt() ?? 0,
      name: map['name'] ?? '',
      mobileNumber: map['mobileNumber']?.toInt() ?? 0,
      age: map['age']?.toInt(),
      weight: map['weight']?.toDouble(),
      propicUrl: map['propicUrl'],
      packageModel: PackageModel.fromMap(map['packageModel']),
      packageDuration: map['packageDuration']?.toInt(),
      lastFeesPaid: map['lastFeesPaid'] != null
          ? (map['lastFeesPaid'] as Timestamp)
              .toDate() // Convert Timestamp to DateTime
          : null,
      packageEndDate: map['packageEndDate'] != null
          ? (map['packageEndDate'] as Timestamp)
              .toDate() // Convert Timestamp to DateTime
          : null,
      isActive: map['isActive'],
      isBlocked: map['isBlocked'],
    );
  }

  /// Converts this model to a JSON string
  String toJson() => json.encode(toMap());

  /// Converts JSON string to MembersModel
  factory MembersModel.fromJson(String source) =>
      MembersModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MembersModel(uid: $uid, registerNumber: $registerNumber, name: $name, mobileNumber: $mobileNumber, age: $age, weight: $weight, propicUrl: $propicUrl, packageModel: $packageModel, packageDuration: $packageDuration, lastFeesPaid: $lastFeesPaid, packageEndDate: $packageEndDate, isActive: $isActive, isBlocked: $isBlocked)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MembersModel &&
        other.uid == uid &&
        other.registerNumber == registerNumber &&
        other.name == name &&
        other.mobileNumber == mobileNumber &&
        other.age == age &&
        other.weight == weight &&
        other.propicUrl == propicUrl &&
        other.packageModel == packageModel &&
        other.packageDuration == packageDuration &&
        other.lastFeesPaid == lastFeesPaid &&
        other.packageEndDate == packageEndDate &&
        other.isActive == isActive &&
        other.isBlocked == isBlocked;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        registerNumber.hashCode ^
        name.hashCode ^
        mobileNumber.hashCode ^
        age.hashCode ^
        weight.hashCode ^
        propicUrl.hashCode ^
        packageModel.hashCode ^
        packageDuration.hashCode ^
        lastFeesPaid.hashCode ^
        packageEndDate.hashCode ^
        isActive.hashCode ^
        isBlocked.hashCode;
  }
}
