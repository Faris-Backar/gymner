import 'dart:convert';

import 'package:gym/service/model/package_model.dart';

class FeesPaymentModel {
  final String transactionType;
  final DateTime createdAt;
  final double? amountSpend;
  final String? memberuid;
  final DateTime? paymentDate;
  final PackageModel? feesPackage;
  final int? totalDuration;
  final double? amountpayed;
  final String? expenseName;
  final double? pendingAmount;
  final DateTime? packageEndDate;
  final String? remarks;
  FeesPaymentModel(
      {required this.transactionType,
      required this.createdAt,
      this.amountSpend,
      this.memberuid,
      this.paymentDate,
      this.feesPackage,
      this.totalDuration,
      this.amountpayed,
      this.pendingAmount,
      this.packageEndDate,
      this.remarks,
      this.expenseName});

  FeesPaymentModel copyWith({
    String? transactionType,
    DateTime? createdAt,
    double? amountSpend,
    String? memberuid,
    DateTime? paymentDate,
    PackageModel? feesPackage,
    int? totalDuration,
    double? amountpayed,
    double? pendingAmount,
    DateTime? packageEndDate,
  }) {
    return FeesPaymentModel(
      transactionType: transactionType ?? this.transactionType,
      createdAt: createdAt ?? this.createdAt,
      amountSpend: amountSpend ?? this.amountSpend,
      memberuid: memberuid ?? this.memberuid,
      paymentDate: paymentDate ?? this.paymentDate,
      feesPackage: feesPackage ?? this.feesPackage,
      totalDuration: totalDuration ?? this.totalDuration,
      amountpayed: amountpayed ?? this.amountpayed,
      pendingAmount: pendingAmount ?? this.pendingAmount,
      packageEndDate: packageEndDate ?? this.packageEndDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'transactionType': transactionType,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'amountSpend': amountSpend,
      'memberuid': memberuid,
      'paymentDate': paymentDate?.millisecondsSinceEpoch,
      'feesPackage': feesPackage?.toMap(),
      'totalDuration': totalDuration,
      'amountpayed': amountpayed,
      'pendingAmount': pendingAmount,
      'packageEndDate': packageEndDate?.millisecondsSinceEpoch,
    };
  }

  factory FeesPaymentModel.fromMap(Map<String, dynamic> map) {
    return FeesPaymentModel(
      transactionType: map['transactionType'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      amountSpend: map['amountSpend']?.toDouble(),
      memberuid: map['memberuid'],
      paymentDate: map['paymentDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['paymentDate'])
          : null,
      feesPackage: map['feesPackage'] != null
          ? PackageModel.fromMap(map['feesPackage'])
          : null,
      totalDuration: map['totalDuration']?.toInt(),
      amountpayed: map['amountpayed']?.toDouble(),
      pendingAmount: map['pendingAmount']?.toDouble(),
      packageEndDate: map['packageEndDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['packageEndDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeesPaymentModel.fromJson(String source) =>
      FeesPaymentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FeesPaymentModel(transactionType: $transactionType, createdAt: $createdAt, amountSpend: $amountSpend, memberuid: $memberuid, paymentDate: $paymentDate, feesPackage: $feesPackage, totalDuration: $totalDuration, amountpayed: $amountpayed, expenseName: $expenseName, pendingAmount: $pendingAmount, packageEndDate: $packageEndDate, remarks: $remarks)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FeesPaymentModel &&
        other.transactionType == transactionType &&
        other.createdAt == createdAt &&
        other.amountSpend == amountSpend &&
        other.memberuid == memberuid &&
        other.paymentDate == paymentDate &&
        other.feesPackage == feesPackage &&
        other.totalDuration == totalDuration &&
        other.amountpayed == amountpayed &&
        other.pendingAmount == pendingAmount &&
        other.packageEndDate == packageEndDate;
  }

  @override
  int get hashCode {
    return transactionType.hashCode ^
        createdAt.hashCode ^
        amountSpend.hashCode ^
        memberuid.hashCode ^
        paymentDate.hashCode ^
        feesPackage.hashCode ^
        totalDuration.hashCode ^
        amountpayed.hashCode ^
        pendingAmount.hashCode ^
        packageEndDate.hashCode;
  }
}
