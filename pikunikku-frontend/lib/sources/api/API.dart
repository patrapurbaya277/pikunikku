
import 'package:pikunikku/sources/api/url.dart';

class API{
  static Uri login = Uri.parse(URL.login);
  static Uri register = Uri.parse(URL.register);
  static Uri allTour = Uri.parse(URL.getAllTour);
  static Uri dekatRumahTour = Uri.parse(URL.getDekatRumahTour);
  static Uri pergiJauhTour = Uri.parse(URL.getPergiJauhTour);
  static Uri paket = Uri.parse(URL.getPaket);
  static Uri provinsi = Uri.parse(URL.getProvinsi);
  static Uri kota(String idProvinsi) => Uri.parse(URL.getKota(idProvinsi));
  static Uri kecamatan(String idKota) => Uri.parse(URL.getKecamatan(idKota));
  static Uri articles = Uri.parse(URL.getArticle);
  static Uri updateUser = Uri.parse(URL.updateUser);
}