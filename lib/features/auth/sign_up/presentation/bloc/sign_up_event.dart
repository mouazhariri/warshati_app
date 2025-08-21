part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class SignUpWithEmailEvent extends SignUpEvent {
  final SignInParams params;
  SignUpWithEmailEvent({required this.params});
}
