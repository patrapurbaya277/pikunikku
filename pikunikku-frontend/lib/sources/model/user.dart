// import 'package:pikunikku/sources/api/url.dart';

class User {
    User({
        required this.id,
        required this.nama,
        required this.noHp,
        required this.email,
        // required this.emailVerifiedAt,
        required this.isVerified,
        required this.password,
        required this.createdAt,
        required this.updatedAt,
        required this.alamat,
        required this.kota,
        required this.provinsi,
        required this.kodePos,
        required this.tglLahir,
        required this.jenisKelamin,
        required this.picture,
        required this.pikunikkuPoint,
        // required this.influencer,
        // required this.referral,
        // required this.noRekening,
        // required this.influenceReferral,
    });

    int id;
    String nama;
    String noHp;
    String email;
    bool isVerified;
    // DateTime emailVerifiedAt;
    String password;
    DateTime createdAt;
    DateTime updatedAt;
    String alamat;
    String kota;
    String provinsi;
    String kodePos;
    DateTime tglLahir;
    String jenisKelamin;
    String picture;
    int pikunikkuPoint;
    // String influencer;
    // String referral;
    // String noRekening;
    // dynamic influenceReferral;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nama: json["nama"],
        noHp: json["no_hp"],
        email: json["email"],
        isVerified: json["email_verified_at"]!=null?true:false,
        // emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        password: json["password"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        alamat: json["alamat"]??"",
        kota: json["kota"],
        provinsi: json["provinsi"],
        kodePos: json["kode_pos"],
        tglLahir: DateTime.parse(json["tgl_lahir"]),
        jenisKelamin: json["jenis_kelamin"],
        picture: json["picture"]??"null",
        pikunikkuPoint: json["pikunikku_point"]??0,
        // influencer: json["influencer"],
        // referral: json["referral"],
        // noRekening: json["no_rekening"],
        // influenceReferral: json["influence_referral"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "no_hp": noHp,
        "email": email,
        "isVerified": isVerified,
        // "email_verified_at": emailVerifiedAt.toIso8601String(),
        "password": password,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "alamat": alamat,
        "kota": kota,
        "provinsi": provinsi,
        "kode_pos": kodePos,
        "tgl_lahir": "${tglLahir.year.toString().padLeft(4, '0')}-${tglLahir.month.toString().padLeft(2, '0')}-${tglLahir.day.toString().padLeft(2, '0')}",
        "jenis_kelamin": jenisKelamin,
        "picture": picture,
        "pikunikku_point": pikunikkuPoint,
        // "influencer": influencer,
        // "referral": referral,
        // "no_rekening": noRekening,
        // "influence_referral": influenceReferral,
    };
}
