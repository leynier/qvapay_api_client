import 'dart:convert';

import 'package:qvapay_api_client/src/models/me.dart';
import 'package:test/test.dart';

import '../../fixtures/fixture_adapter.dart';

void main() {
  final tMeJson = json.decode(fixture('me.json')) as Map<String, dynamic>;

  group('Me', () {
    final tMeModel = Me.fromJson(tMeJson);
    test('fromJson', () async {
      expect(tMeModel, isA<Me>());
      expect(tMeModel, Me.fromJson(tMeJson));
    });
    test('toJson', () async {
      expect(tMeJson, isA<Map<String, dynamic>>());
      expect(tMeJson, tMeModel.toJson());
    });
  });
}
