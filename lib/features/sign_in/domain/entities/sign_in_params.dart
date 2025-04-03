// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SignInParams extends Equatable {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
  SignInParams copyWith({String? email, String? password}) {
    return SignInParams(
        email: email ?? this.email, password: password ?? this.password);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory SignInParams.fromMap(Map<String, dynamic> map) {
    return SignInParams(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
