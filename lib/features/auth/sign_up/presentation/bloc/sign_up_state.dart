// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'sign_up_bloc.dart';

class SignUpState extends Equatable with BaseState {
  final SignInParams signInParams;

  SignUpState({
    required this.signInParams,
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
  static SignUpState initial() {
    return SignUpState(
      signInParams: SignInParams(name: "", phoneNumber: ""),
      isLoading: false,
      message: "",
      error: false,
      success: false,
    );
  }

  SignUpState copyWith({
    SignInParams? signInParams,
    bool? isLoading,
    String? message,
    bool? error,
    bool? success,
  }) {
    return SignUpState(
      signInParams: signInParams ?? this.signInParams,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object> get props => [signInParams, isLoading, message, error, success];
}
