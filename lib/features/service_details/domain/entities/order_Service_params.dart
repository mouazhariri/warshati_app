// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrderServiceParams extends Equatable {
  final int serviceId;
  final String name;
  final String phoneNumber;
  final String serviceDay;
  final String address;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'service_id': serviceId,
      'username': name,
      'phone_number': phoneNumber,
      'service_day': serviceDay,
      'address': address,
    };
  }

  factory OrderServiceParams.fromMap(Map<String, dynamic> map) {
    return OrderServiceParams(
      serviceId: map['serviceId'] as int,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      serviceDay: map['serviceDay'] as String,
      address: map['address'] as String,
    );
  }

  OrderServiceParams({
    required this.name,
    required this.serviceId,
    required this.phoneNumber,
    required this.serviceDay,
    required this.address,
  });

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [
      name,
      serviceId,
      phoneNumber,
      serviceDay,
      address,
    ];
  }

  OrderServiceParams copyWith({
    int? serviceId,
    String? name,
    String? phoneNumber,
    String? serviceDay,
    String? address,
  }) {
    return OrderServiceParams(
      serviceId: serviceId ?? this.serviceId,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      serviceDay: serviceDay ?? this.serviceDay,
      address: address ?? this.address,
    );
  }
}
