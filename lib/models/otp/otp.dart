class Otp {
  late bool status;
  late String token;
  late String message;

  Otp({
    required this.status,
    required this.token,
    required this.message,
  });

  Otp.init();

  factory Otp.fromJson(Map<String, dynamic> json) {
    return Otp(
      status: json['status'],
      token: json['token'],
      message: json['message'],
    );
  }
}