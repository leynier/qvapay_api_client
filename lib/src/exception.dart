/// Server exception.
class ServerException implements Exception {
  /// Constructor for [ServerException].
  ServerException();
}

/// Authentication failure.
class AuthenticateException implements Exception {
  /// Constructor for [AuthenticateException].
  AuthenticateException({this.error});

  /// Message error for exception.
  final String? error;
}

/// Register failure.
class RegisterException implements Exception {
  /// Constructor for [RegisterException].
  RegisterException({this.error});

  /// Message error for exception.
  final String? error;
}
