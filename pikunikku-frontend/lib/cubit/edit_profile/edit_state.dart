part of 'edit_cubit.dart';

class EditState extends Equatable {
  final bool? saving;
  final bool? changeLocation;
  final bool? loading;

  final bool? hidePassword;

  final bool? changed;
  final User? oldUser;

  final int? passwordFase;
  final String? password;
  final String? newPassword;
  final String? confirmPassword;

  final File? image;
  final String? nama;
  final DateTime? tglLahir;
  final String? jeniskelamin;
  final String? noHp;
  final String? provinsi;
  final String? kota;
  final String? kecamatan;
  final String? kelurahan;
  final String? kodePos;
  final String? alamat;

  final List<Provinsi>? listProvince;
  final List<Kota>? listCity;
  final List<Kecamatan>? listKecamatan;
  final List<String>? listUniqueKecamatan;
  final List<String>? listKelurahan;
  final Kota? city;
  final Provinsi? province;

  final String? provinsiTemp;
  final String? kotaTemp;
  final String? kecamatanTemp;
  final String? kelurahanTemp;
  final String? kodePosTemp;

  EditState({
    this.hidePassword,
    this.loading,
    this.passwordFase,
    this.password,
    this.newPassword,
    this.confirmPassword,
    this.saving = false,
    this.changed = false,
    this.changeLocation = false,
    this.oldUser,
    this.nama,
    this.noHp,
    this.alamat,
    this.tglLahir,
    this.image,
    this.jeniskelamin,
    this.provinsi,
    this.kecamatan,
    this.kota,
    this.kelurahan,
    this.kodePos,
    this.listCity,
    this.listKecamatan,
    this.listProvince,
    this.listKelurahan,
    this.city,
    this.province,
    this.listUniqueKecamatan,
    this.provinsiTemp = "",
    this.kotaTemp = "",
    this.kecamatanTemp = "",
    this.kelurahanTemp = "",
    this.kodePosTemp = "",
  });

  @override
  List<Object?> get props => [
    hidePassword,
        loading,
        passwordFase,
        password,
        newPassword,
        confirmPassword,
        saving,
        changed,
        changeLocation,
        oldUser,
        nama,
        noHp,
        alamat,
        tglLahir,
        image,
        jeniskelamin,
        provinsi,
        kota,
        kecamatan,
        kelurahan,
        kodePos,
        province,
        city,
        listProvince,
        listKecamatan,
        listCity,
        listKelurahan,
        listUniqueKecamatan,
        provinsiTemp,
        kotaTemp,
        kecamatanTemp,
        kelurahanTemp,
        kodePosTemp,
      ];

  EditState initEditPassword() => EditState(
      hidePassword: true,
      loading: false,
      passwordFase: 0,
      password: null,
      newPassword: null,
      confirmPassword: null,
      changed: this.changed,
      saving: this.saving,
      oldUser: this.oldUser,
      image: null,
      nama: this.nama,
      tglLahir: this.tglLahir,
      jeniskelamin: this.jeniskelamin,
      noHp: this.noHp,
      provinsi: this.provinsi,
      kota: this.kota,
      kecamatan: this.kecamatan,
      kelurahan: this.kelurahan,
      kodePos: this.kodePos,
      alamat: this.alamat,
      province: this.province,
      city: this.city,
      listCity: this.listCity,
      listKecamatan: this.listKecamatan,
      listKelurahan: this.listKelurahan,
      listProvince: this.listProvince,
      listUniqueKecamatan: this.listUniqueKecamatan,
      provinsiTemp: this.provinsiTemp,
      kotaTemp: this.kotaTemp,
      kecamatanTemp: this.kecamatanTemp,
      kelurahanTemp: this.kelurahanTemp,
      kodePosTemp: this.kodePosTemp);

  EditState nullImage() => EditState(
    hidePassword: this.hidePassword,
    loading: false,
      passwordFase: this.passwordFase,
      password: this.password,
      newPassword: this.newPassword,
      confirmPassword: this.confirmPassword,
      changed: this.changed,
      saving: this.saving,
      oldUser: this.oldUser,
      image: null,
      nama: this.nama,
      tglLahir: this.tglLahir,
      jeniskelamin: this.jeniskelamin,
      noHp: this.noHp,
      provinsi: this.provinsi,
      kota: this.kota,
      kecamatan: this.kecamatan,
      kelurahan: this.kelurahan,
      kodePos: this.kodePos,
      alamat: this.alamat,
      province: this.province,
      city: this.city,
      listCity: this.listCity,
      listKecamatan: this.listKecamatan,
      listKelurahan: this.listKelurahan,
      listProvince: this.listProvince,
      listUniqueKecamatan: this.listUniqueKecamatan,
      provinsiTemp: this.provinsiTemp,
      kotaTemp: this.kotaTemp,
      kecamatanTemp: this.kecamatanTemp,
      kelurahanTemp: this.kelurahanTemp,
      kodePosTemp: this.kodePosTemp);

  EditState copyWith({
    bool? hidePassword,
    bool? loading,
    int? passwordFase,
    String? password,
    String? newPassword,
    String? confirmPassword,
    bool? saving,
    bool? changed,
    bool? changeLocation,
    User? oldUser,
    File? image,
    String? nama,
    DateTime? tglLahir,
    String? jeniskelamin,
    String? noHp,
    String? provinsi,
    String? kota,
    String? kecamatan,
    String? kelurahan,
    String? kodePos,
    String? alamat,
    List<Provinsi>? listProvince,
    List<Kota>? listCity,
    List<Kecamatan>? listKecamatan,
    List<String>? listUniqueKecamatan,
    List<String>? listKelurahan,
    Kota? city,
    Provinsi? province,
    String? provinsiTemp,
    String? kotaTemp,
    String? kecamatanTemp,
    String? kelurahanTemp,
    String? kodePosTemp,
  }) =>
      EditState(
        hidePassword: hidePassword??this.hidePassword,
          loading: loading??this.loading,
          passwordFase: passwordFase ?? this.passwordFase,
          password: password ?? this.password,
          newPassword: newPassword ?? this.newPassword,
          confirmPassword: confirmPassword ?? this.confirmPassword,
          changeLocation: changeLocation ?? this.changeLocation,
          saving: saving ?? this.saving,
          changed: changed ?? this.changed,
          oldUser: oldUser ?? this.oldUser,
          image: image ?? this.image,
          nama: nama ?? this.nama,
          tglLahir: tglLahir ?? this.tglLahir,
          jeniskelamin: jeniskelamin ?? this.jeniskelamin,
          noHp: noHp ?? this.noHp,
          provinsi: provinsi ?? this.provinsi,
          kota: kota ?? this.kota,
          kecamatan: kecamatan ?? this.kecamatan,
          kelurahan: kelurahan ?? this.kelurahan,
          kodePos: kodePos ?? this.kodePos,
          alamat: alamat ?? this.alamat,
          province: province ?? this.province,
          city: city ?? this.city,
          listCity: listCity ?? this.listCity,
          listKecamatan: listKecamatan ?? this.listKecamatan,
          listKelurahan: listKelurahan ?? this.listKelurahan,
          listProvince: listProvince ?? this.listProvince,
          listUniqueKecamatan: listUniqueKecamatan ?? this.listUniqueKecamatan,
          provinsiTemp: provinsiTemp ?? this.provinsiTemp,
          kotaTemp: kotaTemp ?? this.kotaTemp,
          kecamatanTemp: kecamatanTemp ?? this.kecamatanTemp,
          kelurahanTemp: kelurahanTemp ?? this.kelurahanTemp,
          kodePosTemp: kodePosTemp ?? this.kodePosTemp);

  @override
  bool? get stringify => true;
}
