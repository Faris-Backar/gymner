import 'dart:convert';

import 'package:gym/service/model/members_model.dart';

class SmsModel {
  final MembersModel member;
  bool isSelected;
  SmsModel({
    required this.member,
    required this.isSelected,
  });

  SmsModel copyWith({
    MembersModel? member,
    bool? isSelected,
  }) {
    return SmsModel(
      member: member ?? this.member,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'member': member.toMap(),
      'isSelected': isSelected,
    };
  }

  factory SmsModel.fromMap(Map<String, dynamic> map) {
    return SmsModel(
      member: MembersModel.fromMap(map['member']),
      isSelected: map['isSelected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SmsModel.fromJson(String source) =>
      SmsModel.fromMap(json.decode(source));

  @override
  String toString() => 'SmsModel(member: $member, isSelected: $isSelected)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SmsModel &&
        other.member == member &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode => member.hashCode ^ isSelected.hashCode;
}
