import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:warshati/features/service_details/domain/entities/order_Service_params.dart';
import 'package:warshati/src/application/architecture/bloc/base_state.dart';

import '../../domain/usecases/service_details_use_case.dart';

part 'service_details_event.dart';
part 'service_details_state.dart';

@Injectable()
class SignInBloc extends Bloc<ServiceDetailsEvent, ServiceDetailsState> {
  final ServiceDetailsUseCase serviceDetailsUseCase;
  SignInBloc(this.serviceDetailsUseCase)
      : super(ServiceDetailsState.initial()) {
    on<OrderServiceEvent>(_orderService);
  }
  @FactoryMethod()
  FutureOr<void> _orderService(
      OrderServiceEvent event, Emitter<ServiceDetailsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await serviceDetailsUseCase(OrderServiceParams(
      name: event.params.name,
      phoneNumber: event.params.phoneNumber,
      secondPhoneNumber: event.params.secondPhoneNumber,
      serviceId: event.params.serviceId,
      serviceDay: event.params.serviceDay,
      address: event.params.address,
    ));
    result.fold((failure) {
      emit(state.copyWith(
        isLoading: false,
        error: true,
        message: failure.message,
      ));
    }, (_) async {
      emit(state.copyWith(
        isLoading: false,
        success: true,
        message: "Success",
      ));
    });
  }
}
