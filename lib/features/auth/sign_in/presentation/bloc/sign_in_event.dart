part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class SignInWithEmailEvent extends SignInEvent {
  final SignInParams params;
  SignInWithEmailEvent({required this.params});
}
