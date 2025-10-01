import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_meals/core/API/api_result.dart';
import 'package:heal_meals/features/auth/data/models/user_login_model.dart';
import 'package:heal_meals/features/auth/data/models/user_register_model.dart';
import 'package:heal_meals/features/auth/data/repositories/auth_repository.dart';
import 'package:heal_meals/features/auth/logic/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial());

  Future<void> signUp(UserRegisterModel userRegisterModel) async {
    emit(AuthLoading());
    final result = await _authRepository.register(userRegisterModel);
    result.when(
      success: (data) => emit(
        AuthSignUpSuccess(
          message: data['message'] ?? 'Account created successfully!',
        ),
      ),
      error: (error) => emit(AuthFailure(error: error)),
    );
  }

  Future<void> signIn(UserLoginModel userLoginModel) async {
    emit(AuthLoading());
    final result = await _authRepository.login(userLoginModel);
    result.when(
      success: (data) {
        if (data['token'] != null) {
          _authRepository.saveToken(data['token']);
          _authRepository.saveUser(data['user']);
        }
        emit(AuthSignInSuccess(user: data));
      },
      error: (error) => emit(AuthFailure(error: error)),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    await _authRepository.logout();
    emit(AuthLoggedOut());
  }

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final isLoggedIn = await _authRepository.isLoggedIn();
    if (isLoggedIn) {
      emit(AuthAuthenticated(user: {})); // TODO: pass real user
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
