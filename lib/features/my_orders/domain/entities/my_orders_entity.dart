// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_orders_entity.g.dart';

@JsonSerializable()
class MyOrdersEntity extends Equatable {
  final int id;
  @JsonKey(name: "phone_number")
  final String phoneNumber;
  @JsonKey(name: "user_name")
  final String userName;
  final String address;
  @JsonKey(name: "service_day")
  final String serviceDay;
  @JsonKey(name: "service_titles")
  final List<String> serviceTitle;
  @JsonKey(name: "created_at")
  final String createAt;

  Map<String, dynamic> toJson() => _$MyOrdersEntityToJson(this);

  factory MyOrdersEntity.fromJson(Map<String, dynamic> json) =>
      _$MyOrdersEntityFromJson(json);

  const MyOrdersEntity({
    required this.id,
    required this.phoneNumber,
    required this.userName,
    required this.address,
    required this.serviceDay,
    required this.serviceTitle,
    required this.createAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      phoneNumber,
      userName,
      serviceTitle,
      address,
      serviceDay,
      createAt,
    ];
  }

  MyOrdersEntity copyWith(
      {int? id,
      String? phoneNumber,
      String? userName,
      String? address,
      String? serviceDay,
      String? createAt,
      List<String>? serviceTitle}) {
    return MyOrdersEntity(
        id: id ?? this.id,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        serviceDay: serviceDay ?? this.serviceDay,
        createAt: createAt ?? this.createAt,
        userName: userName ?? this.userName,
        serviceTitle: serviceTitle ?? this.serviceTitle);
  }
}
