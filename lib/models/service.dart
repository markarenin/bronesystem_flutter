// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bronesystem/authprovider.dart';

class Service {
  int id;
  String name;
  int booking_days;
  int booking_time;
  bool paid;
  bool disabled;
  int price;

  Service({
    required this.id,
    required this.name,
    required this.booking_days,
    required this.booking_time,
    required this.paid,
    required this.disabled,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'booking_days': booking_days,
      'booking_time': booking_time,
      'paid': paid,
      'disabled': disabled,
      'price': price,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'] as int,
      name: map['name'] as String,
      booking_days: map['booking_days'] as int,
      booking_time: map['booking_time'] as int,
      paid: map['paid'] as bool,
      disabled: map['disabled'] as bool,
      price: map['price'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) =>
      Service.fromMap(json.decode(source) as Map<String, dynamic>);
}
