class PikuMetaData {
    PikuMetaData({
        this.feature,
        this.include,
        this.notInclude,
        this.sign,
    });

    List<dynamic>? feature;
    List<dynamic>? include;
    List<dynamic>? notInclude;
    List<dynamic>? sign;

    factory PikuMetaData.fromJson(Map<String, dynamic> json) => PikuMetaData(
        feature: List<dynamic>.from(json["feature"].map((x) => x)),
        include: List<dynamic>.from(json["include"].map((x) => x)),
        notInclude: List<dynamic>.from(json["not_include"].map((x) => x)),
        sign: List<dynamic>.from(json["sign"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "feature": List<dynamic>.from(feature!.map((x) => x)),
        "include": List<dynamic>.from(include!.map((x) => x)),
        "not_include": List<dynamic>.from(notInclude!.map((x) => x)),
        "sign": List<dynamic>.from(sign!.map((x) => x)),
    };
}