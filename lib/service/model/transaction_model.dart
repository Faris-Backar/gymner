import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionsModel {
  final String? memberName;
  final String? memberUid;
  final DateTime? txDate; // Changed to DateTime for handling timestamp
  final String? txAmount;
  final String? txUid;

  TransactionsModel({
    this.memberName,
    this.memberUid,
    this.txDate,
    this.txAmount,
    this.txUid,
  });

  TransactionsModel copyWith({
    String? memberName,
    String? memberUid,
    DateTime? txDate,
    String? txAmount,
    String? txUid,
  }) {
    return TransactionsModel(
      memberName: memberName ?? this.memberName,
      memberUid: memberUid ?? this.memberUid,
      txDate: txDate ?? this.txDate,
      txAmount: txAmount ?? this.txAmount,
      txUid: txUid ?? this.txUid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'memberName': memberName,
      'memberUid': memberUid,
      if (txDate != null)
        'txDate': Timestamp.fromDate(
            txDate!), // Convert DateTime to Firestore Timestamp
      'txAmount': txAmount,
      'txUid': txUid,
    };
  }

  factory TransactionsModel.fromMap(Map<String, dynamic> map) {
    return TransactionsModel(
      memberName: map['memberName'],
      memberUid: map['memberUid'],
      txDate: map['txDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['txDate'].millisecondsSinceEpoch)
          : null, // Convert Firestore Timestamp to DateTime
      txAmount: map['txAmount'],
      txUid: map['txUid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionsModel.fromJson(String source) =>
      TransactionsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionsModel(memberName: $memberName, memberUid: $memberUid, txDate: $txDate, txAmount: $txAmount, txUid: $txUid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionsModel &&
        other.memberName == memberName &&
        other.memberUid == memberUid &&
        other.txDate == txDate &&
        other.txAmount == txAmount &&
        other.txUid == txUid;
  }

  @override
  int get hashCode {
    return memberName.hashCode ^
        memberUid.hashCode ^
        txDate.hashCode ^
        txAmount.hashCode ^
        txUid.hashCode;
  }
}
