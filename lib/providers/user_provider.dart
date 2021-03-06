import 'package:get/get.dart';

class UserProvider extends GetConnect {
  Future<Response> login({required String pseudo, required String password}) {
    return post('login', {
      'username': pseudo,
      'password': password,
    });
  }

  Future<Response> loginWithUuid(String loginUuid) {
    return post('login', {'login_uuid': loginUuid});
  }

  Future<Response> register({
    required String email,
    required String username,
    required String password,
  }) {
    return post('signup', {
      'email': email,
      'username': username,
      'password': password,
    });
  }

  Future<Response> checkResetPassword(String email) {
    return post('forgotpassword', {
      'email': email,
    });
  }

  Future<Response> resetPassword({
    required String password,
    required String code,
  }) {
    return post('reset-password', {
      'password': password,
      'code': code,
    });
  }

  // forgotpassword
  // param email
}
