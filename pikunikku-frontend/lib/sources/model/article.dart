class Article {
    Article({
        this.id,
        this.title,
        this.slug,
        this.content,
        this.picture,
        this.slider,
        // this.idUser,
        this.adminId,
        this.category,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? title;
    String? slug;
    String? content;
    String? picture;
    String? slider;
    // String? idUser;
    int? adminId;
    String? category;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        slug: json["slug"] == null ? null : json["slug"],
        content: json["content"] == null ? null : json["content"],
        picture: json["picture"] == null ? null : json["picture"],
        slider: json["slider"] == null ? "" : json["slider"],
        // idUser: json["id_user"] == null ? null : json["id_user"],
        adminId: json["admin_id"] == null ? null : int.parse(json["admin_id"]),
        category: json["category"] == null ? null : json["category"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "slug": slug,
        "content": content == null ? null : content,
        "picture": picture == null ? null : picture,
        "slider": slider,
        // "id_user": idUser == null ? null : idUser,
        "admin_id": adminId == null ? null : adminId,
        "category": category == null ? null : category,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}
