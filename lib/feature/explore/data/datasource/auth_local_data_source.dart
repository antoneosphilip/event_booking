import '../../../../core/database/hive_storage.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> signUp(UserModel user);
  Future<UserModel?> signIn(String email, String password);
  Future<UserModel?> getUserByEmail(String email);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveStorage hiveStorage;

  AuthLocalDataSourceImpl(this.hiveStorage);

  @override
  Future<UserModel> signUp(UserModel user) async {
    if (hiveStorage.usersBox.containsKey(user.email)) {
      throw StateError('Email already registered');
    }

    final id = hiveStorage.nextUserId();
    final newUser = UserModel(
      id: id,
      name: user.name,
      email: user.email,
      password: user.password,
    );
    await hiveStorage.usersBox.put(user.email, newUser.toMap());
    return newUser;
  }

  @override
  Future<UserModel?> signIn(String email, String password) async {
    final data = hiveStorage.usersBox.get(email);
    if (data == null) return null;

    final user = UserModel.fromMap(Map<String, dynamic>.from(data as Map));
    if (user.password == password) return user;
    return null;
  }

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    final data = hiveStorage.usersBox.get(email);
    if (data == null) return null;
    return UserModel.fromMap(Map<String, dynamic>.from(data as Map));
  }
}
