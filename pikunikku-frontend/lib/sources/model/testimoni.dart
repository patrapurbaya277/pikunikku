class Testimoni {
    Testimoni({
        this.id,
        this.title,
        this.subtitle,
        this.pict,
        // this.button,
        this.place,
        this.status,
        // this.createdAt,
    });

    int? id;
    String? title;
    String? subtitle;
    String? pict;
    // dynamic? button;
    String? place;
    String? status;
    // dynamic createdAt;

    factory Testimoni.fromJson(Map<String, dynamic> json) => Testimoni(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        subtitle: json["subtitle"] == null ? null : json["subtitle"],
        pict: json["pict"] == null ? null : json["pict"],
        // button: json["button"],
        place: json["place"] == null ? null : json["place"],
        status: json["status"] == null ? null : json["status"],
        // createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "subtitle": subtitle == null ? null : subtitle,
        "pict": pict == null ? null : pict,
        // "button": button,
        "place": place == null ? null : place,
        "status": status == null ? null : status,
        // "created_at": createdAt,
    };
}
