import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:sham/features/sign_in/domain/entities/sign_in_params.dart';
import 'package:sham/features/sign_in/domain/usecases/sign_in_use_case.dart';
import 'package:sham/src/application/architecture/bloc/base_state.dart';
import 'package:sham/src/application/di/injection.dart';
import 'package:sham/src/core/utils/constants/constants.dart';
import 'package:sham/src/infrastructure/storage/local_storage.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

@Injectable()
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;
  SignInBloc(this.signInUseCase) : super(SignInState.initial()) {
    on<SignInWithEmailEvent>(_signIn);
  }
  @FactoryMethod()
  FutureOr<void> _signIn(
      SignInWithEmailEvent event, Emitter<SignInState> emit) async {
    final LocalStorage localeStorage = sl<LocalStorage>();
    emit(state.copyWith(isLoading: true));
    final result = await signInUseCase(SignInParams(
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
