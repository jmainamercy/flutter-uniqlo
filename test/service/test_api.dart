import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:uniqlo/service/auth_api.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockClient;
  late AuthApi authApi;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockClient = MockHttpClient();
    authApi = AuthApi(client: mockClient);
  });

  group('login', () {
    test('test successful login', () async {
      var mockResponse = {
        'id': 1,
        'username': 'Jerry',
        'email': 'jerry@gail.com',
        'firstName': 'Jerry',
        'lastName': 'Anyango',
        'gender': 'male',
        'image': 'https.fake.url',
        'accessToken': 'access123',
        'refreshToken': 'refresh123',
      };

      when(
        () => mockClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

      final result = await authApi.login('Jerry', 'password123');
      expect(result.accessToken, 'access123');
      expect(result.refreshToken, 'refresh123');
      expect(result.user.firstName, 'Jerry');
    });

    test('unsuccessful login', () async {
      when(
        () => mockClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async =>
            http.Response(jsonEncode({'message': 'Invalid Credentials'}), 400),
      );

      final result = authApi.login('wrong', 'wrongpass');
      expect(
        result,
        throwsA(
          isA<AuthException>().having(
            (e) => e.toString(),
            'message',
            contains('Invalid Credentials'),
          ),
        ),
      );
    });
  });
}
