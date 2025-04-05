part of 'service_details_bloc.dart';

abstract class ServiceDetailsEvent {}

class OrderServiceEvent extends ServiceDetailsEvent {
  final OrderServiceParams params;
  OrderServiceEvent({required this.params});
}
