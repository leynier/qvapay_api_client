import 'dart:convert';

import 'package:qvapay_api_client/src/models/service_buy.dart';
import 'package:test/test.dart';

import '../../fixtures/fixture_adapter.dart';

void main() {
  final tServiceBuyJson =
      json.decode(fixture('service_buy.json')) as Map<String, dynamic>;

  group('ServiceBuy', () {
    final tServiceBuyModel = ServiceBuy.fromJson(tServiceBuyJson);
    test('fromJson', () async {
      expect(tServiceBuyModel, isA<ServiceBuy>());
      expect(tServiceBuyModel, equals(ServiceBuy.fromJson(tServiceBuyJson)));
    });
    test('toJson', () async {
      expect(tServiceBuyModel.toJson(), isA<Map<String, dynamic>>());
      expect(tServiceBuyModel.toJson(), equals(tServiceBuyJson));
    });
  });
}
