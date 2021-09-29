import 'dart:convert';

import 'package:qvapay_api_client/src/models/paid_by.dart';
import 'package:test/test.dart';

import '../../fixtures/fixture_adapter.dart';

void main() {
  final tPaidByJson =
      json.decode(fixture('paid_buy.json')) as Map<String, dynamic>;
  final tNullPaidByJson =
      json.decode(fixture('null_paid_buy.json')) as Map<String, dynamic>;

  group('PaidBy', () {
    final tPaidByModel = PaidBy.fromJson(tPaidByJson);
    test('fromJson', () async {
      expect(tPaidByModel, isA<PaidBy>());
      expect(tPaidByModel, equals(PaidBy.fromJson(tPaidByJson)));
    });

    test('toJson', () async {
      expect(tPaidByModel.toJson(), isA<Map<String, dynamic>>());
      expect(tPaidByModel.toJson(), equals(tPaidByJson));
    });

    test("whend the Json doesn't have some values", () async {
      final tModel = PaidBy.fromJson(tNullPaidByJson);

      expect(tModel.toJson(), equals(tNullPaidByJson));
    });
  });
}
