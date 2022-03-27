
import 'package:pikunikku/sources/api/url.dart';

class API{
  static Uri login = Uri.parse(URL.login);
  static Uri register = Uri.parse(URL.register);
  static Uri allTour = Uri.parse(URL.getAllTour);
  static Uri singleTour(String slug) => Uri.parse(URL.singleTour(slug));
  static Uri searchTour(String key)=>Uri.parse(URL.getAllTour+"/?search=$key");
  static Uri dekatRumahTour = Uri.parse(URL.getDekatRumahTour);
  static Uri pergiJauhTour = Uri.parse(URL.getPergiJauhTour);
  static Uri paket = Uri.parse(URL.getPaket);
  static Uri provinsi = Uri.parse(URL.getProvinsi);
  static Uri kota(String idProvinsi) => Uri.parse(URL.getKota(idProvinsi));
  static Uri kecamatan(String idKota) => Uri.parse(URL.getKecamatan(idKota));
  static Uri articles = Uri.parse(URL.getArticle);
  static Uri updateUser = Uri.parse(URL.updateUser);
  static Uri editProfile = Uri.parse(URL.editProfile);
  static Uri editPassword = Uri.parse(URL.editPassword);
  static Uri testimoni = Uri.parse(URL.getTestimoni);
  static Uri preBook = Uri.parse(URL.preBook);
  static Uri book = Uri.parse(URL.book);
  static Uri listBook = Uri.parse(URL.listBook);
  static Uri bookDetail(String id) => Uri.parse(URL.bookDetail(id));
}