import 'dart:convert';

import 'package:hive/hive.dart';
part 'delivery.g.dart';

@HiveType(typeId: 1)
class Delivery {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String code;
  @HiveField(2)
  late int carNumber;
  @HiveField(3)
  late String carType;
  @HiveField(4)
  late String transactionType;
  @HiveField(5)
  late String status;
  @HiveField(6)
  late int userId;
  @HiveField(7)
  late String userEmail;

  //Depart info
  @HiveField(8)
  late String departLat;
  @HiveField(9)
  late String departLng;
  @HiveField(10)
  late String departCity;
  @HiveField(11)
  late String departDate;
  @HiveField(12)
  late String departHour;

  //Destination info
  @HiveField(13)
  late String destinationLat;
  @HiveField(14)
  late String destinationLng;
  @HiveField(15)
  late String destinationCity;
  @HiveField(16)
  late String destinationDate;
  @HiveField(17)
  late String destinationHour;

  //Stop info
  @HiveField(18)
  late String stopLat;
  @HiveField(19)
  late String stopLng;
  @HiveField(20)
  late String stopCity;
  @HiveField(21)
  late String stopDate;
  @HiveField(22)
  late String stopHour;

  @HiveField(23)
  late int routeNumber;
  @HiveField(24)
  late String contactName;
  @HiveField(25)
  late String contactPhone;


  //Delivery(this.id, this.name, this.phone, this.email, this.password, this.accessToken);

  Delivery({
    required this.id,
    required this.code,
    required this.routeNumber,
    required this.carNumber,
    required this.carType,
    required this.transactionType,
    required this.status,
    required this.userId,
    required this.userEmail,
    required this.departLat,
    required this.departLng,
    required this.departCity,
    required this.departDate,
    required this.departHour,
    required this.destinationLat,
    required this.destinationLng,
    required this.destinationCity,
    required this.destinationDate,
    required this.destinationHour,
    required this.stopLat,
    required this.stopLng,
    required this.stopCity,
    required this.stopDate,
    required this.stopHour,
    required this.contactName,
    required this.contactPhone,
  });

  Delivery.init();

  Delivery.register(this.id);

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      id: json['id'],
      code: json['code'],
      contactName: json['contact_name'],
      contactPhone: json['contact_phone'],
      routeNumber: json['route_number'],
      carNumber: json['car_number'],
      carType: json['car_type'],
      transactionType: json['transaction_type'],
      status: json['status'],
      userId: json['user_id'],
      userEmail: json['user_email'],
      departLat: jsonDecode(json['depart'])['latitude'].toString(),
      departLng: jsonDecode(json['depart'])['longitude'].toString(),
      departCity: jsonDecode(json['depart'])['city'],
      departDate: jsonDecode(json['depart'])['ship_date'],
      departHour: jsonDecode(json['depart'])['hour'],
      destinationLat: jsonDecode(json['destination'])['latitude'].toString(),
      destinationLng: jsonDecode(json['destination'])['longitude'].toString(),
      destinationCity: jsonDecode(json['destination'])['city'],
      destinationDate: jsonDecode(json['destination'])['ship_date'],
      destinationHour: jsonDecode(json['destination'])['hour'],
      stopLat: jsonDecode(json['stop'])['latitude'].toString(),
      stopLng: jsonDecode(json['stop'])['longitude'].toString(),
      stopCity: jsonDecode(json['stop'])['city'],
      stopDate: jsonDecode(json['stop'])['ship_date'],
      stopHour: jsonDecode(json['stop'])['hour'],
    );
  }


  /*factory Document.fromJson(Map<String, dynamic> json) {
    var _chapters = json['chapters'] as List;
    _chapters = _chapters.map((e) => Chapter.fromJson(e)).toList();

    return Document(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        chapterCount: json['chapters_count'],
        //image: 'https://i.imgur.com/sI4GvE6.png',
        rateMe: json['rate_me'].toDouble(),
        rating: json['avg_rating'].toDouble(),//double.parse(json['avg_rating']),
        image: json['attachments'],
        imageOverview: json['image_overview'],
        author: json['author'],
        isLike: json['isLike'],
        chapters: _chapters
    );
  }*/
}

