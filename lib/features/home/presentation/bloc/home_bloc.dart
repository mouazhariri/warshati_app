import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:warshati/features/home/domain/usecases/home_use_case.dart';
import 'package:warshati/src/application/architecture/use_case/base_usecase.dart';

import 'home_event.dart';
import 'home_state.dart';

@lazySingleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase homeUseCase;
  HomeBloc(this.homeUseCase) : super(HomeState.initial()) {
    on<GetAllServicesEvent>(_getAllServices);
  }

  FutureOr<void> _getAllServices(
      GetAllServicesEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    final service = await homeUseCase(NoParameters());
    service.fold((failure) {
      emit(state.copyWith(
        isLoading: false,
        error: true,
        message: failure.message,
      ));
    }, (servicesList) {
      emit(state.copyWith(
        isLoading: false,
        success: true,
        servicesList: servicesList,
      ));
    });
  }
}
