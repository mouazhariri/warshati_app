// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SignInParams extends Equatable {
  final String name;
  final String phoneNumber;

  SignInParams({required this.name, required this.phoneNumber});

  @override
  List<Object> get props => [name, phoneNumber];
  SignInParams copyWith({String? name, String? phoneNumber}) {
    return SignInParams(
        name: name ?? this.name, phoneNumber: phoneNumber ?? this.phoneNumber);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'full_name': name,
      'phone_number': phoneNumber,
    };
  }

  factory SignInParams.fromMap(Map<String, dynamic> map) {
    return SignInParams(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
