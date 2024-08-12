import 'dart:convert';

class ExpiryReportModel {
  final int expiryWithinOneToThreeDays;
  final int expiryWithinFourToSevenDays;
  final int expiryWithinSeventoThirtyDays;
  final int expiredActiveMembers;
  ExpiryReportModel({
    required this.expiryWithinOneToThreeDays,
    required this.expiryWithinFourToSevenDays,
    required this.expiryWithinSeventoThirtyDays,
    required this.expiredActiveMembers,
  });

  ExpiryReportModel copyWith({
    int? expiryWithinOneToThreeDays,
    int? expiryWithinFourToSevenDays,
    int? expiryWithinSeventoThirtyDays,
    int? expiredActiveMembers,
  }) {
    return ExpiryReportModel(
      expiryWithinOneToThreeDays:
          expiryWithinOneToThreeDays ?? this.expiryWithinOneToThreeDays,
      expiryWithinFourToSevenDays:
          expiryWithinFourToSevenDays ?? this.expiryWithinFourToSevenDays,
      expiryWithinSeventoThirtyDays:
          expiryWithinSeventoThirtyDays ?? this.expiryWithinSeventoThirtyDays,
      expiredActiveMembers: expiredActiveMembers ?? this.expiredActiveMembers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expiryWithinOneToThreeDays': expiryWithinOneToThreeDays,
      'expiryWithinFourToSevenDays': expiryWithinFourToSevenDays,
      'expiryWithinSeventoThirtyDays': expiryWithinSeventoThirtyDays,
      'expiredActiveMembers': expiredActiveMembers,
    };
  }

  factory ExpiryReportModel.fromMap(Map<String, dynamic> map) {
    return ExpiryReportModel(
      expiryWithinOneToThreeDays:
          map['expiryWithinOneToThreeDays']?.toInt() ?? 0,
      expiryWithinFourToSevenDays:
          map['expiryWithinFourToSevenDays']?.toInt() ?? 0,
      expiryWithinSeventoThirtyDays:
          map['expiryWithinSeventoThirtyDays']?.toInt() ?? 0,
      expiredActiveMembers: map['expiredActiveMembers']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpiryReportModel.fromJson(String source) =>
      ExpiryReportModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpiryReportModel(expiryWithinOneToThreeDays: $expiryWithinOneToThreeDays, expiryWithinFourToSevenDays: $expiryWithinFourToSevenDays, expiryWithinSeventoThirtyDays: $expiryWithinSeventoThirtyDays, expiredActiveMembers: $expiredActiveMembers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpiryReportModel &&
        other.expiryWithinOneToThreeDays == expiryWithinOneToThreeDays &&
        other.expiryWithinFourToSevenDays == expiryWithinFourToSevenDays &&
        other.expiryWithinSeventoThirtyDays == expiryWithinSeventoThirtyDays &&
        other.expiredActiveMembers == expiredActiveMembers;
  }

  @override
  int get hashCode {
    return expiryWithinOneToThreeDays.hashCode ^
        expiryWithinFourToSevenDays.hashCode ^
        expiryWithinSeventoThirtyDays.hashCode ^
        expiredActiveMembers.hashCode;
  }
}
