// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'service_details_bloc.dart';

class ServiceDetailsState extends Equatable with BaseState {
  final OrderServiceParams params;

  ServiceDetailsState({
    required this.params,
    required bool isLoading, // Use the mixin variable
    required String message, // Use the mixin variable
    required bool error, // Use the mixin variable
    required bool success, // Use the mixin variable
  }) {
    this.isLoading = isLoading;
    this.message = message;
    this.error = error;
    this.success = success;
  }
  static ServiceDetailsState initial() {
    return ServiceDetailsState(
      params: OrderServiceParams(
          name: "",
          phoneNumber: "",
          serviceDay: "",
          details: "",
          servicesId: [],
          userId: -1,
          address: ""),
      isLoading: false,
      message: "",
      error: false,
      success: false,
    );
  }

  ServiceDetailsState copyWith({
    OrderServiceParams? params,
    bool? isLoading,
    String? message,
    bool? error,
    bool? success,
  }) {
    return ServiceDetailsState(
      params: params ?? this.params,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object> get props => [params, isLoading, message, error, success];
}
