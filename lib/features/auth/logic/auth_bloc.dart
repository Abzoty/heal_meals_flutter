import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_meals/core/API/api_result.dart';
import 'package:heal_meals/features/auth/logic/auth_event.dart';
import 'package:heal_meals/features/auth/logic/auth_state.dart';
import 'package:heal_meals/features/auth/data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _authRepository.register(event.userRegisterModel);

    result.when(
      success: (data) {
        emit(
          AuthSignUpSuccess(
            message: data['message'] ?? 'Account created successfully!',
          ),
        );
      },
      error: (error) {
        emit(AuthFailure(error: error));
      },
    );
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _authRepository.login(event.userLoginModel);

    result.when(
      success: (data) {
        // Remove 'async' here
        // Handle token saving synchronously or move it outside
        if (data['token'] != null) {
          // Don't await here - handle token saving differently
          _authRepository.saveToken(data['token']); // Remove await
        }
        emit(AuthSignInSuccess(user: data));
      },
      error: (error) {
        emit(AuthFailure(error: error));
      },
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await _authRepository.logout();
    emit(AuthLoggedOut());
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final isLoggedIn = await _authRepository.isLoggedIn();

    if (isLoggedIn) {
      // You might want to fetch user data here
      emit(AuthAuthenticated(user: {})); // Replace with actual user data
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
