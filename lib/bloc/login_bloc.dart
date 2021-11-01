import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoadingState());

      await Future.delayed(const Duration(seconds: 1));

      if (event.email == "abc@gmail.com" && event.password == "12345") {
        emit(SuccessState(userName: "admin", email: event.email));
      } else {
        emit(FailureState(failureMsg: "Either email or password is wrong."));
      }
    });
  }
}
