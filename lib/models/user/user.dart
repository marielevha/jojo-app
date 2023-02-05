import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String phone;
  @HiveField(3)
  late String email;
  @HiveField(4)
  late String password;
  @HiveField(5)
  late String accessToken;
  @HiveField(6)
  late String firstName;
  @HiveField(7)
  late String lastName;
  @HiveField(8)
  late String country;
  @HiveField(9)
  late String profile;

  //User(this.id, this.name, this.phone, this.email, this.password, this.accessToken);

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.accessToken,
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.profile,
  });

  User.init();
  User.initId(this.id);

  User.register(
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.phone,
    this.country,
    this.email,
    this.password,
    this.accessToken
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      accessToken: json['token'],
      phone: json['phone'],
      country: json['country'],
      password: '',
      profile: json['profile'],
    );
  }
}
