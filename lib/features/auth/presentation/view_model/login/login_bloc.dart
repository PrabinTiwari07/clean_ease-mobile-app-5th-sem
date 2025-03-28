import 'package:clean_ease/app/di/di.dart';
import 'package:clean_ease/features/auth/domain/use_case/login_usecase.dart';
import 'package:clean_ease/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:clean_ease/features/home/presentation/view/home_view/home.dart';
import 'package:clean_ease/features/home/presentation/view_model/home_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc({required LoginUseCase loginUseCase, required HomeCubit homeCubit})
      : _loginUseCase = loginUseCase,
        super(LoginState.initial()) {
    // Handle Login Event
    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final result = await _loginUseCase(
        LoginParams(
          email: event.username,
          password: event.password,
        ),
      );

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
          ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(
              content: Text('Invalid Credentials'),
              backgroundColor: Colors.red,
            ),
          );
        },
        (success) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
          Navigator.pushReplacement(
            event.context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        },
      );
    });

    on<NavigateRegisterScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<RegisterBloc>(),
            child: event.destination,
          ),
        ),
      );
    });
  }
}
