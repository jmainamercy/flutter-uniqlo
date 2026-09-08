import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniqlo/model/user.dart';
import 'package:uniqlo/service/auth_api.dart';
import 'package:uniqlo/viewmodel/view_model.dart';

class MockAuthApi extends Mock implements AuthApi {}

User _mockUser = User(
  id: 1,
  username: 'joana',
  email: 'joana@gmail.com',
  firstName: 'Joana',
  lastName: 'Maina',
  gender: 'female',
  image: 'http.fake.url',
);

void main() {
  late MockAuthApi mockApi;

  setUpAll(() {
    registerFallbackValue(_mockUser);
  });

  setUp(() {
    mockApi = MockAuthApi();
  });

  group('login', () {
    test('test successful login', () async {
      SharedPreferences.setMockInitialValues({});
      when(() => mockApi.login(any(), any())).thenAnswer(
        (_) async => AuthResult(
          user: _mockUser,
          accessToken: 'access123',
          refreshToken: 'refresh123',
        ),
      );
      final authVm = AuthViewmodel(authApi: mockApi);
      var success = await authVm.login('joana', 'joanapass');

      expect(authVm.authStatus, AuthStatus.authenticated);
      expect(success, isTrue);
      expect(authVm.user?.email, _mockUser.email);
    });

    test('failed login', () async {
      SharedPreferences.setMockInitialValues({});
      when(
        () => mockApi.login(any(), any()),
      ).thenThrow(AuthException('Invalid credentials'));

      final vm = AuthViewmodel(authApi: mockApi);
      var success = await vm.login('wrong', 'invalid');

      expect(success, isFalse);
      expect(vm.authStatus, AuthStatus.unauthenticated);
      expect(vm.errorMessage, contains('Invalid credentials'));
    });
  });
}
