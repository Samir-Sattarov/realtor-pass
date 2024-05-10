import '../../../../app_core/app_core_library.dart';

abstract class AuthLocalDataSource {
  Future<String?> getToken();
  Future<bool> checkActiveSession();
  Future<void> saveToken(String token);
  Future<void> saveUserId(int id);
  Future<int?> getUserId();
  Future<void> logOut();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SecureStorage secureStorage;

  AuthLocalDataSourceImpl(this.secureStorage);

  @override
  Future<String?> getToken() async {
    final response = await secureStorage.get(key: StorageKeys.kToken);

    return response;
  }

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.save(key: StorageKeys.kToken, value: token);
  }

  @override
  Future<bool> checkActiveSession() async {
    final response = await secureStorage.get(key: StorageKeys.kToken);

    if (response == null) {
      return false;
    }
    return true;
  }

  @override
  logOut() async => await secureStorage.deleteAll();

  @override
  Future<int?> getUserId() async {
    final data = await secureStorage.get(key: StorageKeys.kUserId);

    if (data == null) return null;
    return int.parse(data);
  }

  @override
  Future<void> saveUserId(int id) async {
    await secureStorage.save(key: StorageKeys.kUserId, value: id.toString());
  }
}
