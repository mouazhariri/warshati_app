// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'services_entity.g.dart';

@JsonSerializable()
class ServicesEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String price;
  final String image;

  const ServicesEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  @override
  List<Object?> get props => [id, title, description, image, price];

  Map<String, dynamic> toJson() => _$ServicesEntityToJson(this);

  factory ServicesEntity.fromJson(Map<String, dynamic> json) =>
      _$ServicesEntityFromJson(json);

  ServicesEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? price,
    String? image,
  }) {
    return ServicesEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }
}
