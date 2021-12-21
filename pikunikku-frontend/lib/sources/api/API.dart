
import 'package:pikunikku/sources/api/url.dart';

class API{
  static Uri login = Uri.parse(URL.login);
  static Uri register = Uri.parse(URL.register);
  static Uri allTour = Uri.parse(URL.getAllTour);
  static Uri dekatRumahTour = Uri.parse(URL.getDekatRumahTour);
  static Uri pergiJauhTour = Uri.parse(URL.getPergiJauhTour);
  static Uri paket = Uri.parse(URL.getPaket);
}