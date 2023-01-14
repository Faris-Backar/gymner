import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/service/model/package_model.dart';

class FeesPaymentModel {
  final String memberuid;
  final DateTime feesDate;
  final PackageModel feesPackage;
  final int totalDuration;
  final double amountpayed;
  final double? pendingAmount;
  final DateTime? packageEndDate;
  FeesPaymentModel({
    required this.memberuid,
    required this.feesDate,
    required this.feesPackage,
    required this.totalDuration,
    required this.amountpayed,
    this.pendingAmount,
    this.packageEndDate,
  });

  FeesPaymentModel copyWith({
    String? memberuid,
    DateTime? feesDate,
    PackageModel? feesPackage,
    int? totalDuration,
    double? amountpayed,
    double? pendingAmount,
    DateTime? packageEndDate,
  }) {
    return FeesPaymentModel(
      memberuid: memberuid ?? this.memberuid,
      feesDate: feesDate ?? this.feesDate,
      feesPackage: feesPackage ?? this.feesPackage,
      totalDuration: totalDuration ?? this.totalDuration,
      amountpayed: amountpayed ?? this.amountpayed,
      pendingAmount: pendingAmount ?? this.pendingAmount,
      packageEndDate: packageEndDate ?? this.packageEndDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'memberuid': memberuid,
      'feesDate': feesDate.millisecondsSinceEpoch,
      'feesPackage': feesPackage.toMap(),
      'totalDuration': totalDuration,
      'amountpayed': amountpayed,
      'pendingAmount': pendingAmount,
      'packageEndDate': packageEndDate,
    };
  }

  factory FeesPaymentModel.fromMap(Map<String, dynamic> map) {
    return FeesPaymentModel(
      memberuid: map['memberuid'] ?? '',
      feesDate: DateTime.fromMillisecondsSinceEpoch(map['feesDate']),
      feesPackage: PackageModel.fromMap(map['feesPackage']),
      totalDuration: map['totalDuration']?.toInt() ?? 0,
      amountpayed: map['amountpayed']?.toDouble() ?? 0.0,
      pendingAmount: map['pendingAmount']?.toDouble(),
      packageEndDate: map['packageEndDate'] != null
          ? (map['packageEndDate'] as Timestamp).toDate()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeesPaymentModel.fromJson(String source) =>
      FeesPaymentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FeesPaymentModel(memberuid: $memberuid, feesDate: $feesDate, feesPackage: $feesPackage, totalDuration: $totalDuration, amountpayed: $amountpayed, pendingAmount: $pendingAmount, packageEndDate: $packageEndDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FeesPaymentModel &&
        other.memberuid == memberuid &&
        other.feesDate == feesDate &&
        other.feesPackage == feesPackage &&
        other.totalDuration == totalDuration &&
        other.amountpayed == amountpayed &&
        other.pendingAmount == pendingAmount &&
        other.packageEndDate == packageEndDate;
  }

  @override
  int get hashCode {
    return memberuid.hashCode ^
        feesDate.hashCode ^
        feesPackage.hashCode ^
        totalDuration.hashCode ^
        amountpayed.hashCode ^
        pendingAmount.hashCode ^
        packageEndDate.hashCode;
  }
}
