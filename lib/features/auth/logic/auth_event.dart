import 'package:equatable/equatable.dart';
import 'package:heal_meals/features/auth/data/models/user_login_model.dart';
import 'package:heal_meals/features/auth/data/models/user_register_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequested extends AuthEvent {
  final UserRegisterModel userRegisterModel;

  const SignUpRequested({required this.userRegisterModel});

  @override
  List<Object> get props => [userRegisterModel];
}

class SignInRequested extends AuthEvent {
  final UserLoginModel userLoginModel;

  const SignInRequested({required this.userLoginModel});

  @override
  List<Object> get props => [userLoginModel];
}

class LogoutRequested extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}
