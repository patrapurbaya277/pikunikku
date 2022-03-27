class URL{
  //base
  static String base = "https://pikunikku.id/";
  static const String baseBeta = "https://beta.pikunikku.id/";
  static String baseBetaApi = "https://beta.pikunikku.id/api/";

  //login
  static String login = baseBetaApi+"login";

  //tour
  static String getAllTour = baseBetaApi+"program/tour-travel";
  static String singleTour(String slug) => baseBetaApi+"show/tour/$slug";
  static String getDekatRumahTour = baseBetaApi+"program/dekat-rumah";
  static String getPergiJauhTour = baseBetaApi+"program/pergi-jauh";
  static String getPaket = baseBetaApi+"paket";
  static String preBook = baseBetaApi+"booking-tour";
  static String book = baseBetaApi+"booking-tour/create";
  static String listBook = baseBetaApi+"booking-tour/list";
  static String bookDetail(String id) => baseBetaApi+"booking-tour/detail/$id";

  //user
  static String register = baseBetaApi+"register";
  static String imageProfile = baseBeta+"assets/images/profil_member/";
  static String updateUser = baseBetaApi+"member/profile";
  static String editProfile = baseBetaApi+"member/profile/update";
  static String editPassword = baseBetaApi+"member/password/update";

  static String getProvinsi = "https://kodepos-2d475.firebaseio.com/list_propinsi.json";
  static String getKota(String idProvinsi)=>"https://kodepos-2d475.firebaseio.com/list_kotakab/$idProvinsi.json";
  static String getKecamatan(String idKota)=>"https://kodepos-2d475.firebaseio.com/kota_kab/$idKota.json";

  //article
  static String getArticle = baseBetaApi+"articles";

  //testimoni
  static String getTestimoni = baseBetaApi+"testimoni";
  static const String moreTestimoni = baseBeta+"testimoni";

  //faq
  static const String moreFAQ = baseBeta+"home/faq";

  //social media
  static const String facebook = "https://www.facebook.com/pikunikkuid-110131786497539";
  static const String instagram = "https://www.instagram.com/pikunikku.id/?utm_medium=copy_link";
  static const String youtube = "https://www.youtube.com/channel/UCUBKJV1HMsJCq1bno5WxYgA";

}