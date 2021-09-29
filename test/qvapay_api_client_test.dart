// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qvapay_api_client/src/exception.dart';
import 'package:qvapay_api_client/src/models/me.dart';
import 'package:qvapay_api_client/src/qvapay_api.dart';
import 'package:test/test.dart';
import 'package:qvapay_api_client/qvapay_api_client.dart';

import 'fixtures/fixture_adapter.dart';

class MockDio extends Mock implements Dio {}

class MockOAuthStorage extends Mock implements OAuthStorage {}

void main() {
  late Dio mockDio;
  late QvaPayApi apiClient;
  late MockOAuthStorage mockStorage;

  setUp(() {
    mockDio = MockDio();
    mockStorage = MockOAuthStorage();
    apiClient = QvaPayApiClient(mockDio, mockStorage);
  });

  final tLoginResponse =
      json.decode(fixture('login.json')) as Map<String, dynamic>;

  final tToken = tLoginResponse['token'] as String;

  final tMeResponse = json.decode(fixture('me.json')) as Map<String, dynamic>;

  group('authentication', () {
    group('login', () {
      test('should return a token successfully', () async {
        when(() => mockStorage.save(tToken)).thenAnswer((_) async => true);
        when(() => mockDio.post<Map<String, dynamic>>(
              '${QvaPayApi.baseUrl}/login',
              data: any<Map<String, String>>(named: 'data'),
            )).thenAnswer((_) async => Response(
              data: tLoginResponse,
              statusCode: 200,
              requestOptions: RequestOptions(
                path: '${QvaPayApi.baseUrl}/login',
              ),
            ));

        final response = await apiClient.login('test@qvapay.com', 'sqp');

        verify(() => mockStorage.save(response)).called(1);
        expect(response, tToken);
      });
      test(
          'should throw a [AuthenticateException] when '
          'the password is incorrect', () async {
        when(() => mockDio.post<Map<String, dynamic>>(
              '${QvaPayApi.baseUrl}/login',
              data: any<Map<String, String>>(named: 'data'),
            )).thenAnswer((_) async => Response(
              data: const <String, String>{'message': 'Password mismatch'},
              statusCode: 422,
              requestOptions: RequestOptions(
                path: '${QvaPayApi.baseUrl}/login',
              ),
            ));

        expect(
          () => apiClient.login('test@qvapay.com', '?'),
          throwsA(
            isA<AuthenticateException>().having(
              (e) => e.error,
              'error',
              equals('Password mismatch'),
            ),
          ),
        );
        verifyZeroInteractions(mockStorage);
      });
      test(
        'should throw a [AuthenticateException] when the email is incorrect',
        () async {
          when(() => mockDio.post<Map<String, dynamic>>(
                '${QvaPayApi.baseUrl}/login',
                data: any<Map<String, String>>(named: 'data'),
              )).thenAnswer((_) async => Response(
                data: const <String, String>{'message': 'User does not exist'},
                statusCode: 422,
                requestOptions: RequestOptions(
                  path: '${QvaPayApi.baseUrl}/login',
                ),
              ));
          expect(
              () => apiClient.login('test@qvapay.com', 'sqp'),
              throwsA(
                isA<AuthenticateException>().having(
                  (e) => e.error,
                  'error',
                  equals('User does not exist'),
                ),
              ));
          verifyZeroInteractions(mockStorage);
        },
      );
      test(
        'should throw a [AuthenticateException] when the field email is empty',
        () async {
          when(() => mockDio.post<Map<String, dynamic>>(
                '${QvaPayApi.baseUrl}/login',
                data: any<Map<String, String>>(named: 'data'),
              )).thenAnswer((_) async => Response(
                data: const <String, List<String>>{
                  'errors': ['El campo email es obligatorio.']
                },
                statusCode: 422,
                requestOptions: RequestOptions(
                  path: '${QvaPayApi.baseUrl}/login',
                ),
              ));
          expect(
              () => apiClient.login(' ', 'sqp'),
              throwsA(
                isA<AuthenticateException>().having(
                  (e) => e.error,
                  'error',
                  equals('El campo email es obligatorio.'),
                ),
              ));
          verifyZeroInteractions(mockStorage);
        },
      );

      test(
        'should throw a [ServerException] when the response code is not 200',
        () async {
          when(() => mockDio.post<Map<String, dynamic>>(
                '${QvaPayApi.baseUrl}/login',
                data: any<Map<String, String>>(named: 'data'),
              )).thenAnswer((_) async => Response(
                data: const <String, List<String>>{
                  'errors': ['El campo email es obligatorio.']
                },
                statusCode: 500,
                requestOptions: RequestOptions(
                  path: '${QvaPayApi.baseUrl}/login',
                ),
              ));
          expect(
            () => apiClient.login(' ', 'sqp'),
            throwsA(isA<ServerException>()),
          );
        },
      );
    });

    group('signin', () {
      test('should return a token when registration is completed successfully.',
          () async {
        when(() => mockStorage.save(tToken)).thenAnswer((_) async => true);
        when(() => mockDio.post<Map<String, dynamic>>(
              '${QvaPayApi.baseUrl}/register',
              data: any<Map<String, String>>(named: 'data'),
            )).thenAnswer((_) async => Response(
              data: tLoginResponse,
              statusCode: 200,
              requestOptions: RequestOptions(
                path: '${QvaPayApi.baseUrl}/register',
              ),
            ));

        final response = await apiClient.signIn(
          name: 'Erich García Cruz',
          email: 'erich@qvapay.com',
          password: 'test',
        );

        expect(response, tToken);
        verify(() => mockStorage.save(tToken)).called(1);
      });

      test(
          'should throws a [RegisterException] when is already registered. '
          'or an error occurs', () async {
        when(() => mockDio.post<Map<String, dynamic>>(
              '${QvaPayApi.baseUrl}/register',
              data: any<Map<String, String>>(named: 'data'),
            )).thenAnswer((_) async => Response(
              data: const <String, List<String>>{
                'errors': ['El valor del campo email ya está en uso.']
              },
              statusCode: 422,
              requestOptions: RequestOptions(
                path: '${QvaPayApi.baseUrl}/register',
              ),
            ));

        expect(
          () => apiClient.signIn(
            name: 'Erich García Cruz',
            email: 'erich@qvapay.com',
            password: 'test',
          ),
          throwsA(isA<RegisterException>().having(
            (e) => e.error,
            'El valor del campo email ya está en uso.',
            isNotNull,
          )),
        );
        verifyZeroInteractions(mockStorage);
      });
    });

    group('logout', () {
      test('when is successfully', () async {
        when(() => mockStorage.delete()).thenAnswer((_) async => true);
        when(() => mockDio.get<String>(
              '${QvaPayApi.baseUrl}/logout',
              options: any(named: 'options'),
            )).thenAnswer((_) async => Response(
              data: '<html>',
              statusCode: 200,
              requestOptions: RequestOptions(
                path: '${QvaPayApi.baseUrl}/logout',
              ),
            ));

        try {
          await apiClient.logOut();
        } catch (_) {
          verify(
            () async => mockDio.get<String>(
              '${QvaPayApi.baseUrl}/logout',
              options: any(named: 'options'),
            ),
          ).called(1);
          verify(() => mockStorage.delete()).called(1);
        }
      });

      test('should throw a [ServerException] when ocures a error', () async {
        when(() => mockDio.get<String>(
              '${QvaPayApi.baseUrl}/logout',
              options: any(named: 'options'),
            )).thenThrow(DioError(
          requestOptions: RequestOptions(
            path: '${QvaPayApi.baseUrl}/logout',
          ),
        ));

        expect(() => apiClient.logOut(), throwsA(isA<ServerException>()));

        verify(
          () => mockDio.get<String>(
            '${QvaPayApi.baseUrl}/logout',
            options: any(named: 'options'),
          ),
        ).called(1);
        verifyZeroInteractions(mockStorage);
      });
    });
  });

  group('getUserData', () {
    final tMeModel = Me.fromJson(tMeResponse);
    test('should return a [Me] successfully', () async {
      when(() => mockDio.get<Map<String, dynamic>>(
            '${QvaPayApi.baseUrl}/me',
            options: any(named: 'options'),
          )).thenAnswer((_) async => Response(
            data: tMeResponse,
            statusCode: 200,
            requestOptions: RequestOptions(
              path: '${QvaPayApi.baseUrl}/me',
            ),
          ));

      final response = await apiClient.getUserData();

      expect(response, tMeModel);
    });
  });
}
