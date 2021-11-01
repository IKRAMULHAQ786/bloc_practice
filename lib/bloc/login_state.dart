part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoadingState extends LoginState {}

class FailureState extends LoginState {
  final String failureMsg;
  FailureState({required this.failureMsg});
}

class SuccessState extends LoginState {
  final String userName;
  final String email;
  SuccessState({required this.userName, required this.email});
}
