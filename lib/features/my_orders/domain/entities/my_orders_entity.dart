// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_orders_entity.g.dart';

@JsonSerializable()
class MyOrdersEntity extends Equatable {
  final int id;
  @JsonKey(name: "phone_number")
  final String phoneNumber;
  final String address;
  @JsonKey(name: "service_day")
  final String serviceDay;
  @JsonKey(name: "created_at")
  final String createAt;
  final String service;

  Map<String, dynamic> toJson() => _$MyOrdersEntityToJson(this);

  factory MyOrdersEntity.fromJson(Map<String, dynamic> json) =>
      _$MyOrdersEntityFromJson(json);

  MyOrdersEntity(
      {required this.id,
      required this.phoneNumber,
      required this.address,
      required this.serviceDay,
      required this.createAt,
      required this.service});

  @override
  List<Object> get props {
    return [
      id,
      phoneNumber,
      address,
      serviceDay,
      createAt,
      service,
    ];
  }

  MyOrdersEntity copyWith(
      {int? id,
      String? phoneNumber,
      String? address,
      String? serviceDay,
      String? createAt,
      String? service}) {
    return MyOrdersEntity(
        id: id ?? this.id,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        serviceDay: serviceDay ?? this.serviceDay,
        createAt: createAt ?? this.createAt,
        service: service ?? this.service);
  }
}
