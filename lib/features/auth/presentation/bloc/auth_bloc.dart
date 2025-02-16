import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/auth/domain/entities/signup_request_entity.dart';
import 'package:pennywise/features/auth/domain/usecases/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthSignUpEvent>((event, emit) async {
      final result = await sl<SignUpUseCase>().call(
        SignupRequestEntity(
          email: event.email,
          password: event.password,
          passwordConfirmation: event.passwordConfirmation,
        ),
      );

      result.fold(
        (failure) => emit(AuthFailureState(message: failure.message)),
        (userId) => emit(AuthSuccessState(userId: userId)),
      );
    });
  }
}
