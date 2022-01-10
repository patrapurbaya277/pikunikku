class URL{
  //base
  static String base = "https://pikunikku.id/";
  static String baseBeta = "https://beta.pikunikku.id/";
  static String baseBetaApi = "https://beta.pikunikku.id/api/";

  //login
  static String login = baseBetaApi+"login";

  //tour
  static String getAllTour = baseBetaApi+"program/tour-travel";
  static String getDekatRumahTour = baseBetaApi+"program/dekat-rumah";
  static String getPergiJauhTour = baseBetaApi+"program/pergi-jauh";
  static String getPaket = baseBetaApi+"paket";

  //user
  static String register = baseBetaApi+"register";
  static String imageProfile = baseBeta+"assets/images/profil_member/";
  static String updateUser = baseBetaApi+"member/profile";

  static String getProvinsi = "https://kodepos-2d475.firebaseio.com/list_propinsi.json";
  static String getKota(String idProvinsi)=>"https://kodepos-2d475.firebaseio.com/list_kotakab/$idProvinsi.json";
  static String getKecamatan(String idKota)=>"https://kodepos-2d475.firebaseio.com/kota_kab/$idKota.json";

  //article
  static String getArticle = baseBetaApi+"articles";

}