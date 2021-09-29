import 'dart:convert';

import 'package:qvapay_api_client/src/models/latest_transaction.dart';
import 'package:test/test.dart';

import '../../fixtures/fixture_adapter.dart';

void main() {
  final tLatestTransactionJson =
      json.decode(fixture('transaction.json')) as Map<String, dynamic>;

  group('LatestTransaction', () {
    final tLatestTransactionModel =
        LatestTransaction.fromJson(tLatestTransactionJson);
    test('fromJson', () {
      expect(tLatestTransactionModel, isA<LatestTransaction>());
      expect(
        tLatestTransactionModel,
        equals(LatestTransaction.fromJson(tLatestTransactionJson)),
      );
    });

    test('toJson', () {
      expect(tLatestTransactionModel.toJson(), isA<Map<String, dynamic>>());
      expect(tLatestTransactionModel.toJson(), equals(tLatestTransactionJson));
    });
  });
}
