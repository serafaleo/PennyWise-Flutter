import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pennywise/core/errors/failure.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/auth/domain/entities/login_request_entity.dart';
import 'package:pennywise/features/auth/domain/entities/signup_request_entity.dart';
import 'package:pennywise/features/auth/domain/usecases/login_usecase.dart';
import 'package:pennywise/features/auth/domain/usecases/logout_usecase.dart';
import 'package:pennywise/features/auth/domain/usecases/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthLogoutEvent>(_onAuthLogout);
  }

  FutureOr<void> _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await sl<SignUpUseCase>().call(
      SignupRequestEntity(
        email: event.email,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
      ),
    );

    result.fold(
      (failure) => emit(AuthFailureState(failure: failure)),
      (unit) => emit(AuthSuccessState()),
    );
  }

  FutureOr<void> _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await sl<LoginUseCase>().call(
      LoginRequestEntity(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthFailureState(failure: failure)),
      (unit) => emit(AuthSuccessState()),
    );
  }

  FutureOr<void> _onAuthLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await sl<LogoutUseCase>().call(unit);

    result.fold(
      (failure) => emit(AuthFailureState(failure: failure)),
      (unit) => emit(AuthSuccessState()),
    );
  }
}
