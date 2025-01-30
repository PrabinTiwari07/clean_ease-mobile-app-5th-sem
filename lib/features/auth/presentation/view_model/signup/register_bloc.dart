import 'package:bloc/bloc.dart';
import 'package:clean_ease/core/common/snackbar/my_snackbar.dart';
import 'package:clean_ease/features/auth/domain/use_case/register_usecase.dart';
import 'package:clean_ease/features/auth/presentation/view_model/signup/register_event.dart';
import 'package:flutter/material.dart';

import '../../view/login.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterBloc({required RegisterUseCase registerUseCase})
      : _registerUseCase = registerUseCase,
        super(RegisterState.initial()) {
    on<RegisterStudentEvent>(_onRegisterStudent);
  }

  Future<void> _onRegisterStudent(
    RegisterStudentEvent event,
    Emitter<RegisterState> emit,
  ) async {
    if (event.password != event.confirmPassword) {
      emit(state.copyWith(errorMessage: "Passwords do not match"));
      showMySnackBar(
        context: event.context,
        message: "Passwords do not match",
        color: Colors.red,
      );
      return;
    }

    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(
      RegisterUserParams(
        fullName: event.fullName,
        phoneNo: event.phoneNo,
        address: event.address,
        email: event.email,
        password: event.password,
        // isAdmin: false, // Update if admin option is required
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: failure.message,
        ));
        showMySnackBar(
          context: event.context,
          message: failure.message,
          color: Colors.red,
        );
      },
      (success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Registration successful!",
          color: Colors.green,
        );
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      },
    );
  }
}
