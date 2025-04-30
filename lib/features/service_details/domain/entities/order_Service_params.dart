// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class OrderServiceParams extends Equatable {
  final List<int> servicesId;
  final int userId;

  final String name;
  final String phoneNumber;
  final String serviceDay;
  final String address;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'services': json.encode(servicesId),
      'user_id': userId,
      'username': name,
      'phone_number': phoneNumber,
      'service_day': serviceDay,
      'address': address,
    };
  }

  OrderServiceParams({
    required this.name,
    required this.servicesId,
    required this.userId,
    required this.phoneNumber,
    required this.serviceDay,
    required this.address,
  });

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [
      name,
      servicesId,
      userId,
      phoneNumber,
      serviceDay,
      address,
    ];
  }
/// FormData version (for multipart/form-data POST)
  FormData toFormData() {
    return FormData.fromMap({
      'services': jsonEncode(servicesId), // Important fix here!
      'user_id': userId,
      'username': name,
      'phone_number': phoneNumber,
      'service_day': serviceDay,
      'address': address,
    });
  }
  OrderServiceParams copyWith({
    List<int>? servicesId,
    int? userId,
    String? name,
    String? phoneNumber,
    String? serviceDay,
    String? address,
  }) {
    return OrderServiceParams(
      servicesId: servicesId ?? this.servicesId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      serviceDay: serviceDay ?? this.serviceDay,
      address: address ?? this.address,
    );
  }
}
