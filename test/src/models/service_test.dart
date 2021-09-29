import 'dart:convert';

import 'package:qvapay_api_client/src/models/service.dart';
import 'package:test/test.dart';

import '../../fixtures/fixture_adapter.dart';

void main() {
  final tServiceJson =
      json.decode(fixture('service.json')) as Map<String, dynamic>;

  group('Service', () {
    final tServiceModel = Service.fromJson(tServiceJson);
    test('fromJson', () async {
      expect(tServiceModel, isA<Service>());
      expect(tServiceModel, equals(Service.fromJson(tServiceJson)));
    });
    test('toJson', () async {
      expect(tServiceModel.toJson(), isA<Map<String, dynamic>>());
      expect(tServiceModel.toJson(), equals(tServiceJson));
    });
  });
}
