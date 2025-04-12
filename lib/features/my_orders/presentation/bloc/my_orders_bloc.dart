import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:warshati/features/my_orders/domain/repositories/my_orders_repository.dart';
import 'package:warshati/features/my_orders/presentation/bloc/my_orders_state.dart';

import 'my_orders_event.dart';

@LazySingleton()
class MyOrdersBloc extends Bloc<MyOrdersEvent, MyOrdersState> {
  final MyOrdersRepository repository;
  MyOrdersBloc(this.repository) : super(MyOrdersState.initial()) {
    on<GetMyOrdersEvent>(_getMyOrders);
  }

  FutureOr<void> _getMyOrders(
      MyOrdersEvent event, Emitter<MyOrdersState> emit) async {
    emit(state.copyWith(isLoading: true));
    final service = await repository.getMyOrders();
    service.fold((failure) {
      emit(state.copyWith(
        isLoading: false,
        error: true,
        message: failure.message,
      ));
    }, (data) {
      emit(state.copyWith(
        isLoading: false,
        success: true,
        myOrders: data,
      ));
    });
  }
}
