// To parse this JSON data, do
//
//     final tour = tourFromJson(jsonString);

import 'dart:convert';

import 'meta_data.dart';

Tour tourFromJson(String str) => Tour.fromJson(json.decode(str));

String tourToJson(Tour data) => json.encode(data.toJson());

class Tour {
  Tour({
    this.id,
    this.uuidUser,
    this.uuidPaket,
    this.price,
    this.deparatureTime,
    this.location,
    this.duration,
    this.availableSeat,
    this.name,
    this.slug,
    this.desc,
    this.pict,
    this.category,
    this.itinerary,
    this.allowInfluence,
    this.createdAt,
    this.updatedAt,
    this.metaData,
  });

  String? id;
  String? uuidUser;
  String? uuidPaket;
  double? price;
  DateTime? deparatureTime;
  String? location;
  String? duration;
  int? availableSeat;
  String? name;
  String? slug;
  String? desc;
  String? pict;
  String? category;
  String? itinerary;
  String? allowInfluence;
  DateTime? createdAt;
  DateTime? updatedAt;
  PikuMetaData? metaData;
  // String? metaData;

  factory Tour.fromJson(Map<String, dynamic> json) => Tour(
        id: json["id"],
        uuidUser: json["uuid_user"],
        uuidPaket: json["uuid_paket"],
        price: json["price"] ?? 0,
        deparatureTime: DateTime.parse(json["deparature_time"]),
        location: json["location"],
        duration: json["duration"],
        availableSeat: json["available_seat"]??0,
        name: json["name"],
        slug: json["slug"],
        desc: json["desc"]??"Tidak ada deskripsi",
        pict: json["pict"],
        category: json["category"],
        itinerary: json["itinerary"],
        allowInfluence: json["allow_influence"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        // metaData: PikuMetaData.fromJson(jsonDecode(json["meta_data"])),
        // metaData: json["meta_data"]
        metaData: PikuMetaData.fromJson(jsonDecode(json["meta_data"].toString())),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid_user": uuidUser,
        "uuid_paket": uuidPaket,
        "price": price,
        "deparature_time":
            "${deparatureTime!.year.toString().padLeft(4, '0')}-${deparatureTime!.month.toString().padLeft(2, '0')}-${deparatureTime!.day.toString().padLeft(2, '0')}",
        "location": location,
        "duration": duration,
        "available_seat": availableSeat,
        "name": name,
        "slug": slug,
        "desc": desc,
        "pict": pict,
        "category": category,
        "itinerary": itinerary,
        "allow_influence": allowInfluence,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "meta_data": metaData,
      };
}
