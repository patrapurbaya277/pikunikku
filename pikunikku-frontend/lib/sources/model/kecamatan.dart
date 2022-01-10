class Kecamatan {
    Kecamatan({
        this.kecamatan,
        this.kelurahan,
        this.kodepos,
    });

    String? kecamatan;
    String? kelurahan;
    String? kodepos;

    factory Kecamatan.fromJson(Map<String, dynamic> json) => Kecamatan(
        kecamatan: json["kecamatan"] == null ? null : json["kecamatan"],
        kelurahan: json["kelurahan"] == null ? null : json["kelurahan"],
        kodepos: json["kodepos"] == null ? null : json["kodepos"],
    );

    Map<String, dynamic> toJson() => {
        "kecamatan": kecamatan == null ? null : kecamatan,
        "kelurahan": kelurahan == null ? null : kelurahan,
        "kodepos": kodepos == null ? null : kodepos,
    };
}