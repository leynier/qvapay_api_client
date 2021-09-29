import 'package:dio/dio.dart';
import 'package:qvapay_api_client/src/exception.dart';
import 'package:qvapay_api_client/src/models/me.dart';

import 'package:qvapay_api_client/src/qvapay_api.dart';

/// {@template qvapay_api_client}
/// Dart API Client which wraps the [QvaPay API](https://documenter.getpostman.com/view/8765260/TzzHnDGw)
/// {@endtemplate}
class QvaPayApiClient extends QvaPayApi {
  /// {@macro qvapay_api_client}
  QvaPayApiClient(
    Dio dio,
    OAuthStorage storage,
  )   : _dio = dio,
        _storage = storage {
    storage.feach().then((value) => _accessToken = value ?? '');
  }

  final Dio _dio;
  String _accessToken = '';
  final OAuthStorage _storage;

  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '${QvaPayApi.baseUrl}/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 422) {
        final data = response.data!;
        if (data.keys.contains('message')) {
          throw AuthenticateException(
              error: (response.data! as Map<String, String>)['message']);
        } else {
          throw AuthenticateException(
              error:
                  (response.data! as Map<String, List<String>>)['errors']![0]);
        }
      }
      if (response.statusCode != 200) throw ServerException();

      final data = response.data;

      if (data != null && data.isNotEmpty) {
        final dataMap = Map<String, String>.from(data);
        if (dataMap.containsKey('token')) {
          final token = dataMap['token'];
          await _storage.save(token!);
          return Future.value(token);
        }
        throw AuthenticateException();
      }
    } on DioError catch (_) {
      throw ServerException();
    }

    throw ServerException();
  }

