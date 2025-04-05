// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import '../../../../../src/application/architecture/bloc/base_state.dart';
import '../../domain/entities/services_entity.dart';

class HomeState extends Equatable with BaseState {
  final List<ServicesEntity> servicesList;
  HomeState({
    required this.servicesList,
    required bool isLoading,
    required String message,
    required bool error,
    required bool success,
  }) {
    this.isLoading = isLoading;
    this.message = message;
    this.error = error;
    this.success = success;
  }
  static HomeState initial() {
    return HomeState(
      isLoading: false,
      servicesList: [],
      message: "",
      error: false,
      success: false,
    );
  }

  HomeState copyWith({
    bool? isLoading,
    String? message,
    bool? error,
    bool? success,
    List<ServicesEntity>? servicesList,
  }) {
    return HomeState(
      servicesList: servicesList ?? this.servicesList,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object> get props => [isLoading, message, error, success, servicesList];
}
