import 'package:jojo/models/otp/otp.dart';
import 'package:jojo/models/user/user.dart';

class RegisterResponse {
  late Otp otp;
  late User user;

  RegisterResponse({
    required this.user,
    required this.otp
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
        user: User.fromJson(json['user']),
        otp: Otp.fromJson(json['otp'])
    );
  }
}