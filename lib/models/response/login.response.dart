import 'package:jojo/models/user/user.dart';

class LoginResponse {
  late String accessToken;
  late User user;

  LoginResponse({
    required this.user,
    required this.accessToken
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        user: User.fromJson(json['user']),
        accessToken: json['access_token']
    );
  }
}