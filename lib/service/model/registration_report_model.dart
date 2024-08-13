import 'dart:convert';

class RegistrationReportModel {
  final int totalMembers;
  final int activeMembers;
  final int inActiveMembers;
  final int blockedMembers;
  RegistrationReportModel({
    required this.totalMembers,
    required this.activeMembers,
    required this.inActiveMembers,
    required this.blockedMembers,
  });

  RegistrationReportModel copyWith({
    int? totalMembers,
    int? activeMembers,
    int? inActiveMembers,
    int? blockedMembers,
  }) {
    return RegistrationReportModel(
      totalMembers: totalMembers ?? this.totalMembers,
      activeMembers: activeMembers ?? this.activeMembers,
      inActiveMembers: inActiveMembers ?? this.inActiveMembers,
      blockedMembers: blockedMembers ?? this.blockedMembers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalMembers': totalMembers,
      'activeMembers': activeMembers,
      'inActiveMembers': inActiveMembers,
      'blockedMembers': blockedMembers,
    };
  }

  factory RegistrationReportModel.fromMap(Map<String, dynamic> map) {
    return RegistrationReportModel(
      totalMembers: map['totalMembers']?.toInt() ?? 0,
      activeMembers: map['activeMembers']?.toInt() ?? 0,
      inActiveMembers: map['inActiveMembers']?.toInt() ?? 0,
      blockedMembers: map['blockedMembers']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrationReportModel.fromJson(String source) =>
      RegistrationReportModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegistrationReportModel(totalMembers: $totalMembers, activeMembers: $activeMembers, inActiveMembers: $inActiveMembers, blockedMembers: $blockedMembers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegistrationReportModel &&
        other.totalMembers == totalMembers &&
        other.activeMembers == activeMembers &&
        other.inActiveMembers == inActiveMembers &&
        other.blockedMembers == blockedMembers;
  }

  @override
  int get hashCode {
    return totalMembers.hashCode ^
        activeMembers.hashCode ^
        inActiveMembers.hashCode ^
        blockedMembers.hashCode;
  }
}
