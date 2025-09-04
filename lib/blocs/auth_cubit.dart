import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/firebase_service.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;
  Authenticated(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  final FirebaseService _firebaseService;

  AuthCubit(this._firebaseService) : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _firebaseService.signIn(email, password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthError("Sign-in failed. Please check your credentials."));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _firebaseService.signUp(email, password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthError("Sign-up failed. Please try again."));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
