class Paket {
    Paket({
        this.id,
        this.configPaketId,
        this.packageName,
        this.packagePrice,
        this.packageDescription,
        this.availablePackage,
        this.minimumDp,
        // this.createdAt,
        // this.updatedAt,
    });

    int? id;
    String? configPaketId;
    String? packageName;
    double? packagePrice;
    String? packageDescription;
    String? availablePackage;
    double? minimumDp;
    // dynamic? createdAt;
    // DateTime? updatedAt;

    factory Paket.fromJson(Map<String, dynamic> json) => Paket(
        id: json["id"],
        configPaketId: json["config_paket_id"],
        packageName: json["package_name"],
        packagePrice: double.parse(json["package_price"]??"0.0"),
        packageDescription: json["package_description"],
        availablePackage: json["available_package"],
        minimumDp: double.parse(json["minimun_dp"]??"0.0"),
        // createdAt: json["created_at"],
        // updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "config_paket_id": configPaketId,
        "package_name": packageName,
        "package_price": packagePrice,
        "package_description": packageDescription,
        "available_package": availablePackage,
        "minimum_dp": minimumDp,
        // "created_at": createdAt,
        // "updated_at": updatedAt.toIso8601String(),
    };
}
