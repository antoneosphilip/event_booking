import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/preferences/app_preferences.dart';
import '../../../../../core/storage/secure_storage.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final AppPreferences appPreferences;
  final SecureStorage secureStorage;

  AuthCubit(
    this.authRepository,
    this.appPreferences,
    this.secureStorage,
  ) : super(
          appPreferences.isLoggedIn() ? AuthLoading() : AuthInitial(),
        );

  Future<void> loadSession() async {
    if (!appPreferences.isLoggedIn()) {
      emit(AuthInitial());
      return;
    }

    final email = appPreferences.getCurrentUserEmail();
    if (email == null) {
      await appPreferences.clearAuth();
      emit(AuthInitial());
      return;
    }

    emit(AuthLoading());
    final user = await authRepository.getUserByEmail(email);
    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      await appPreferences.clearAuth();
      emit(AuthInitial());
    }
  }

  Future<({String email, String password})?> getRememberedCredentials() {
    return secureStorage.getCredentials();
  }

  Future<void> signIn(
    String email,
    String password, {
    bool rememberMe = false,
  }) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signIn(email, password);
      if (user != null) {
        await _persistSession(user, rememberMe: rememberMe, email: email, password: password);
        emit(AuthSuccess(user));
      } else {
        emit(const AuthError('Invalid email or password'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signUp(name, email, password);
      await _persistSession(user);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logOut() async {
    await appPreferences.clearAuth();
    emit(AuthInitial());
  }

  Future<void> _persistSession(
    UserModel user, {
    bool rememberMe = false,
    String? email,
    String? password,
  }) async {
    await appPreferences.setLoggedIn(true);
    await appPreferences.setCurrentUserEmail(user.email);

    if (rememberMe && email != null && password != null) {
      await secureStorage.saveCredentials(email: email, password: password);
    } else if (!rememberMe) {
      await secureStorage.clearCredentials();
    }
  }
}
