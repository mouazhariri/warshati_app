// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:warshati/features/my_orders/domain/entities/my_orders_entity.dart';

import '../../../../../src/application/architecture/bloc/base_state.dart';

class MyOrdersState extends Equatable with BaseState {
  final List<MyOrdersEntity> myOrders;
  MyOrdersState({
    required this.myOrders,
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
  static MyOrdersState initial() {
    return MyOrdersState(
      isLoading: false,
      myOrders: [],
      message: "",
      error: false,
      success: false,
    );
  }

  MyOrdersState copyWith({
    bool? isLoading,
    String? message,
    bool? error,
    bool? success,
    List<MyOrdersEntity>? myOrders,
  }) {
    return MyOrdersState(
      myOrders: myOrders ?? this.myOrders,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object> get props => [isLoading, message, error, success, myOrders];
}
