import '../datasource/auth_local_data_source.dart';
import '../models/user_model.dart';

class AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepository(this.localDataSource);

  Future<UserModel> signUp(String name, String email, String password) async {
    final user = UserModel(name: name, email: email, password: password);
    return await localDataSource.signUp(user);
  }

  Future<UserModel?> signIn(String email, String password) async {
    return await localDataSource.signIn(email, password);
  }

  Future<UserModel?> getUserByEmail(String email) async {
    return await localDataSource.getUserByEmail(email);
  }
}
