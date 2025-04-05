// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import '../../../../../src/application/architecture/bloc/base_state.dart';

class MainState extends Equatable with BaseState {
  final int selectedIndex;
  final bool logOut;
  MainState({
    required this.selectedIndex,
    required this.logOut,
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
  static MainState initial() {
    return MainState(
      isLoading: false,
      selectedIndex: 0,
      message: "",
      error: false,
      success: false,
      logOut: false,
    );
  }

  MainState copyWith({
    bool? isLoading,
    String? message,
    bool? error,
    bool? success,
    bool? logOut,
    int? selectedIndex,
  }) {
    return MainState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      error: error ?? this.error,
      success: success ?? this.success,
      logOut: logOut ?? this.logOut,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, message, error, success, selectedIndex, logOut];
}
