class BookData {
    BookData({
        this.uuid,
        this.uuidConfigPakets,
        this.idPaketTour,
        this.uuidUser,
        this.typeBook,
        this.totalPeople,
        this.totalPrice,
        this.totalPayments,
        this.status,
        this.ktpSim,
        // this.referral,
        // this.groupId,
        this.modelPembayaran,
        // this.receiptPict,
        this.statusKeberangkatan,
        this.minimumDp,
        this.createdAt,
        this.updatedAt,
    });

    String? uuid;
    String? uuidConfigPakets;
    String? idPaketTour;
    String? uuidUser;
    String? typeBook;
    String? totalPeople;
    String? totalPrice;
    String? totalPayments;
    String? status;
    String? ktpSim;
    // dynamic referral;
    // dynamic groupId;
    String? modelPembayaran;
    // dynamic receiptPict;
    String? statusKeberangkatan;
    double? minimumDp;
    DateTime? createdAt;
    DateTime? updatedAt;


    factory BookData.fromJson(Map<String, dynamic> json) => BookData(
        uuid: json["uuid"],
        uuidConfigPakets: json["uuid_config_pakets"],
        idPaketTour: json["id_paket_tour"],
        uuidUser: json["uuid_user"],
        typeBook: json["type_book"],
        totalPeople: json["total_people"],
        totalPrice: json["total_price"],
        totalPayments: json["total_payments"],
        status: json["status"]=="0"?"Belum Lunas":json["status"]=="1"?"Lunas":json["status"]=="2"?"Batal":"",
        ktpSim: json["ktp_sim"],
        // referral: json["referral"],
        // groupId: json["group_id"],
        modelPembayaran: json["model_pembayaran"],
        // receiptPict: json["receipt_pict"],
        statusKeberangkatan: json["status_keberangkatan"]??"Menunggu",
        minimumDp: double.parse(json["minimum_dp"]??"0.0"),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid == null ? null : uuid,
        "uuid_config_pakets": uuidConfigPakets == null ? null : uuidConfigPakets,
        "id_paket_tour": idPaketTour == null ? null : idPaketTour,
        "uuid_user": uuidUser == null ? null : uuidUser,
        "type_book": typeBook == null ? null : typeBook,
        "total_people": totalPeople == null ? null : totalPeople,
        "total_price": totalPrice == null ? null : totalPrice,
        "total_payments": totalPayments == null ? null : totalPayments,
        "status": status == null ? null : status,
        "ktp_sim": ktpSim == null ? null : ktpSim,
        // "referral": referral,
        // "group_id": groupId,
        "model_pembayaran": modelPembayaran == null ? null : modelPembayaran,
        // "receipt_pict": receiptPict,
        "status_keberangkatan": statusKeberangkatan,
        "minimum_dp": minimumDp,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}
