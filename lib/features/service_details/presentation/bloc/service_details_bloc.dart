import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sham/features/service_details/domain/entities/order_Service_params.dart';
import 'package:sham/src/application/architecture/bloc/base_state.dart';
import 'package:sham/src/application/di/injection.dart';
import 'package:sham/src/infrastructure/storage/local_storage.dart';

import '../../domain/usecases/service_details_use_case.dart';

part 'service_details_event.dart';
part 'service_details_state.dart';

@Injectable()
class ServiceDetailsBloc
    extends Bloc<ServiceDetailsEvent, ServiceDetailsState> {
  final ServiceDetailsUseCase serviceDetailsUseCase;
  ServiceDetailsBloc(this.serviceDetailsUseCase)
      : super(ServiceDetailsState.initial()) {
    on<OrderServiceEvent>(_orderService);
  }
  @FactoryMethod()
  FutureOr<void> _orderService(
      OrderServiceEvent event, Emitter<ServiceDetailsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final localStorage=sl<LocalStorage>();
    final result = await serviceDetailsUseCase(OrderServiceParams(
      name: event.params.name,
      phoneNumber: event.params.phoneNumber,
      servicesId: event.params.servicesId,
      userId: localStorage.userinformation.id,
      serviceDay: event.params.serviceDay,
      address: event.params.address,
      details: event.params.details,
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
