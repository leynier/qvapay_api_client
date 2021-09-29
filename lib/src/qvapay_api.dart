import 'package:qvapay_api_client/src/models/me.dart';

/// {@template qvapay_api}
/// Abstract class for QvaPay API endpoint.
/// {@endtemplate}
abstract class QvaPayApi {
  /// Base URL `https://qvapay.com/api/app`
  static const String baseUrl = 'https://qvapay.com/api/app';

  /// Authentication on the `QvaPay` platform.
  Future<String> login(String email, String password);

  /// Logout the `QvaPay` platform.
  Future<void> logOut();

  /// Create a new user on the `QvaPay` platform.
  Future<String> signIn({
    required String name,
    required String email,
    required String password,
  });

  /// Obtain user data when is authenticated on the `QvaPay` platform.
  Future<Me> getUserData();
}

/// Use to implement a custom token storage
abstract class OAuthStorage {
  /// Save a token in storage
  Future<bool> save(String token);

  /// Get a token save in storage
  Future<String?> feach();

  /// Delete token in the storage
  Future<void> delete();
}

/// Save the token in memory
class OAuthMemoryStorage extends OAuthStorage {
  String? _token;

  @override
  Future<void> delete() {
    _token = null;
    return Future.value();
  }

  @override
  Future<String?> feach() {
    return Future.value(_token);
  }

  @override
  Future<bool> save(String token) {
    _token = token;
    return Future.value(true);
  }
}
