import 'package:qvapay_api_client/src/models/app.dart';
import 'package:test/test.dart';

void main() {
  const tAppModel = App(
    logo: 'apps/qvapay.jpg',
    url: 'https://qvapay.com',
    name: 'QvaPay',
  );

  const tAppJson = {
    'logo': 'apps/qvapay.jpg',
    'url': 'https://qvapay.com',
    'name': 'QvaPay'
  };

  group('App', () {
    test('fromJson', () async {
      final result = App.fromJson(tAppJson);

      expect(result, tAppModel);
    });

    test('toJson', () {
      final result = tAppModel.toJson();

      expect(result, tAppJson);
    });
  });
}
