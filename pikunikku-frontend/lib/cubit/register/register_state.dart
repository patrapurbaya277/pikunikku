part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final int? progress;
  //  final MultipartFile picture;
  final File? image;

  final String? name;
  final String? gender;
  final DateTime? birthday;
  final String? phoneNumber;

  // final String? city;
  // final String? province;
  // final String? postalCode;

  final List<Provinsi>? listProvince;
  final List<Kota>? listCity;
  final List<Kecamatan>? listKecamatan;
  final List<String>? listUniqueKecamatan;
  final List<String>? listKelurahan;

  final Kota? city;
  final Provinsi? province;

  final String? provinsi;
  final String? kota;
  final String? kecamatan;
  final String? kelurahan;
  final String? kodePos;
  final String? address;

  final bool? accountTrue;
  final bool? identityTrue;
  final bool? addressTrue;

  final bool? status;
  final String? message;
  final bool? loading;

  RegisterState({
    this.listUniqueKecamatan,
    this.email: "",
    this.password: "",
    this.confirmPassword = "",
    this.progress = 0,
    this.image,
    this.name = "",
    this.gender = "Laki-laki",
    this.birthday,
    this.phoneNumber = "",
    this.listCity,
    this.listKecamatan,
    this.listProvince,
    this.listKelurahan,
    this.provinsi,
    this.kota,
    this.city,
    this.province,
    this.kecamatan,
    this.kelurahan,
    this.kodePos,
    // this.postalCode = "",
    this.address = "",
    this.accountTrue = false,
    this.identityTrue = false,
    this.addressTrue = false,
    this.status = false,
    this.message = "",
    this.loading = false,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        progress,
        image,
        name,
        gender,
        birthday,
        phoneNumber,
        city,
        provinsi,
        kota,
        province,
        kecamatan,
        kelurahan,
        kodePos,
        listProvince,
        listKecamatan,
        listCity,
        listKelurahan,
        listUniqueKecamatan,
        // postalCode,
        address,
        accountTrue,
        identityTrue,
        addressTrue,
        status,
        message,
        loading,
      ];

  RegisterState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    File? image,
    String? name,
    String? gender,
    DateTime? birthday,
    String? phoneNumber,
    List<Provinsi>? listProvince,
    List<Kota>? listCity,
    List<Kecamatan>? listKecamatan,
    List<String>? listUniqueKecamatan,
    List<String>? listKelurahan,
    Kota? city,
    Provinsi? province,
    String? provinsi,
    String? kota,
    String? kecamatan,
    String? kelurahan,
    String? kodePos,
    // String? postalCode,
    String? address,
    int? progress,
    bool? accountTrue,
    bool? identityTrue,
    bool? addressTrue,
    bool? status,
    String? message,
    bool? loading,
  }) =>
      RegisterState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,

        progress: progress ?? this.progress,

        image: image ?? this.image,

        name: name ?? this.name,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        
        province: province ?? this.province,
        city: city ?? this.city,
        provinsi: provinsi??this.provinsi,
        kota: kota??this.kota,
        kelurahan: kelurahan?? this.kelurahan,
        kodePos: kodePos??this.kodePos,
        kecamatan: kecamatan ?? this.kecamatan,
        // postalCode: postalCode??this.postalCode,
        address: address ?? this.address,
        listCity: listCity??this.listCity,
        listKecamatan: listKecamatan??this.listKecamatan,
        listKelurahan: listKelurahan??this.listKelurahan,
        listProvince: listProvince??this.listProvince,
        listUniqueKecamatan: listUniqueKecamatan??this.listUniqueKecamatan,

        accountTrue: accountTrue ?? this.accountTrue,
        identityTrue: identityTrue ?? this.identityTrue,
        addressTrue: addressTrue ?? this.addressTrue,

        status: status ?? this.status,
        message: message ?? this.message,
        loading: loading ?? this.loading,
      );

  @override
  bool? get stringify => true;
}
