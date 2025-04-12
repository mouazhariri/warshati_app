import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:warshati/src/infrastructure/storage/hive/hive_type_ids.dart';

part 'user_information.g.dart';

@HiveType(typeId: HiveTypeIds.userInfoTypId)
@JsonSerializable()
class UserInformation extends HiveObject implements EquatableMixin {
  @HiveField(1)
  @JsonKey(name: "id")
  final int id;
  @HiveField(2)
  @JsonKey(name: "full_name")
  final String? name;

  @HiveField(3)
  @JsonKey(name: "phone_number")
  final String phoneNumber;
  // @HiveField(9)
  // @JsonKey(name: "fcm_token")
  // final String fcmToken;

  // Exclude token from Hive serialization, only use for runtime or API
  // @HiveField(5)
  @JsonKey(name: "token")
  final String token;

  // @HiveField(4)
  // @JsonKey(name: "image")
  // final String? image;

  UserInformation({
    required this.id,
    required this.name,
    required this.phoneNumber,
    // required this.fcmToken,
    // required this.image,
    this.token = '',
  });

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      _$UserInformationFromJson(json);
  Map<String, dynamic> toJson() => _$UserInformationToJson(this);
  static UserInformation defaultValue = UserInformation(
    id: -1,
    name: '',
    phoneNumber: "",
    // fcmToken: "",
    // image: null,
    token: '',
  );
  @override
  bool operator ==(covariant UserInformation other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.token == token;
    // other.fcmToken == fcmToken &&
    // other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ phoneNumber.hashCode ^ token.hashCode
        // fcmToken.hashCode ^
        // image.hashCode
        ;
  }

  @override
  List<Object?> get props => [
        id,
        name,

        phoneNumber,
        token,
        // fcmToken,
        // image,
      ];

  @override
  bool? get stringify => true;

  UserInformation copyWith({
    int? id,
    String? name,
    String? phoneNumber,
    String? token,
    // String? fcmToken,
    // String? image,
  }) {
    return UserInformation(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      token: token ?? this.token,
      // fcmToken: fcmToken ?? this.fcmToken,
      // image: image ?? this.image,
    );
  }
}
