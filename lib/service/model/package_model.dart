import 'dart:convert';

class PackageModel {
  final String name;
  final double price;
  final String uid;
  PackageModel({
    required this.name,
    required this.price,
    required this.uid,
  });

  PackageModel copyWith({
    String? name,
    double? price,
    String? uid,
  }) {
    return PackageModel(
      name: name ?? this.name,
      price: price ?? this.price,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'uid': uid,
    };
  }

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    return PackageModel(
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      uid: map['uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageModel.fromJson(String source) =>
      PackageModel.fromMap(json.decode(source));

  @override
  String toString() => 'PackageModel(name: $name, price: $price, uid: $uid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PackageModel &&
        other.name == name &&
        other.price == price &&
        other.uid == uid;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ uid.hashCode;
}
