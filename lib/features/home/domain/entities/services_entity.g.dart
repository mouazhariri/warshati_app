// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesEntity _$ServicesEntityFromJson(Map<String, dynamic> json) =>
    ServicesEntity(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$ServicesEntityToJson(ServicesEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'image': instance.image,
    };
