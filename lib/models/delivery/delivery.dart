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

  /*
  @HiveField(6)
  late String createdAt;
  @HiveField(8)
  late String departCity;
  @HiveField(10)
  late String departDate;

  //Stop info
  @HiveField(11)
  late String stopLat;
  @HiveField(12)
  late String stopLng;
  @HiveField(13)
  late String stopCity;
  @HiveField(14)
  late String stopDate;

  //Destination info
  @HiveField(15)
  late String destinationLat;
  @HiveField(16)
  late String destinationLng;
  @HiveField(17)
  late String destinationCity;
  @HiveField(18)
  late String destinationDate;*/

  //Delivery(this.id, this.name, this.phone, this.email, this.password, this.accessToken);

  Delivery({
    required this.id,
    required this.code,
    required this.carNumber,
    required this.carType,
    required this.transactionType,
    required this.status,
    required this.userId,
    required this.userEmail,
    required this.departLat,
    required this.departLng,
  });

  Delivery.init();

  Delivery.register(this.id);

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
        id: json['id'],
        code: json['code'],
        carNumber: json['car_number'],
        carType: json['car_type'],
        transactionType: json['transaction_type'],
        status: json['status'],
        userId: json['user_id'],
        userEmail: '',
        departLat: '',
        departLng: '',
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

