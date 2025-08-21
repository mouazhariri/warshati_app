import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:sham/features/auth/sign_in/domain/entities/sign_in_params.dart';
import 'package:sham/features/auth/sign_in/domain/usecases/sign_in_use_case.dart';
import 'package:sham/features/auth/sign_up/domain/usecases/sign_up_use_case.dart';
import 'package:sham/src/application/architecture/bloc/base_state.dart';
import 'package:sham/src/application/di/injection.dart';
import 'package:sham/src/core/utils/constants/constants.dart';
import 'package:sham/src/infrastructure/storage/local_storage.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

@Injectable()
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;
  SignUpBloc(this.signUpUseCase) : super(SignUpState.initial()) {
    on<SignUpWithEmailEvent>(_signUp);
  }
  @FactoryMethod()
  FutureOr<void> _signUp(
      SignUpWithEmailEvent event, Emitter<SignUpState> emit) async {
    final LocalStorage localeStorage = sl<LocalStorage>();
    emit(state.copyWith(isLoading: true));
    final result = await signUpUseCase(SignInParams(
      name: event.params.name,
      phoneNumber: event.params.phoneNumber,
    ));
    result.fold((failure) {
      debugPrint("fail");

      emit(state.copyWith(
        isLoading: false,
        error: true,
        message: failure.message,
      ));
    }, (userInformation) async {
      debugPrint("SUCESSSSS2");

      emit(state.copyWith(
        isLoading: false,
        success: true,
        message: "تم تسجيل الدخول بنجاح",
      ));

      await localeStorage.setSecuredString(
          StorageKeys.securedToken, userInformation.token);
      await localeStorage.saveUserInfo(userInformation);
    });
  }
}
