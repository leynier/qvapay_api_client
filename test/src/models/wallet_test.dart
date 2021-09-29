import 'dart:convert';

import 'package:qvapay_api_client/src/models/wallet.dart';
import 'package:test/test.dart';

import '../../fixtures/fixture_adapter.dart';

void main() {
  final tWalletJson =
      json.decode(fixture('wallet.json')) as Map<String, dynamic>;

  group('Wallet', () {
    final tWalletModel = Wallet.fromJson(tWalletJson);
    test('fromJson', () {
      expect(tWalletModel, isA<Wallet>());
      expect(tWalletModel, equals(Wallet.fromJson(tWalletJson)));
    });

    test('toJson', () {
      final jsonWallet = tWalletModel.toJson();
      expect(jsonWallet, isA<Map<String, dynamic>>());
      expect(jsonWallet, equals(tWalletJson));
    });
  });
}
