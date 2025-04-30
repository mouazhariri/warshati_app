// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_orders_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrdersEntity _$MyOrdersEntityFromJson(Map<String, dynamic> json) =>
    MyOrdersEntity(
      id: (json['id'] as num).toInt(),
      phoneNumber: json['phone_number'] as String,
      userName: json['user_name'] as String,
      address: json['address'] as String,
      serviceDay: json['service_day'] as String,
      serviceTitle: json['service_title'] as String,
      createAt: json['created_at'] as String,
    );

Map<String, dynamic> _$MyOrdersEntityToJson(MyOrdersEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone_number': instance.phoneNumber,
      'user_name': instance.userName,
      'address': instance.address,
      'service_day': instance.serviceDay,
      'service_title': instance.serviceTitle,
      'created_at': instance.createAt,
    };
