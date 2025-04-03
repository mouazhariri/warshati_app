import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:warshati/features/sign_in/domain/entities/sign_in_params.dart';
import 'package:warshati/features/sign_in/domain/usecases/sign_in_use_case.dart';
import 'package:warshati/src/application/architecture/bloc/base_state.dart';
import 'package:warshati/src/application/di/injection.dart';
import 'package:warshati/src/core/utils/constants/constants.dart';
import 'package:warshati/src/infrastructure/storage/local_storage.dart';

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
      email: event.params.email,
      password: event.params.password,
    ));
    result.fold((failure) {
      emit(state.copyWith(
        isLoading: false,
        error: true,
        message: failure.message,
      ));
    }, (userInformation) async {
      emit(state.copyWith(
        isLoading: false,
        success: true,
        message: "Success",
      ));

      await localeStorage.setSecuredString(
          StorageKeys.securedToken, userInformation.token);
      await localeStorage.saveUserInfo(userInformation);
    });
  }
}
