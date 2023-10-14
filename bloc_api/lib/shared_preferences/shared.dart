import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static const _timelist = 'timeList';

  static Future setTimeData(List<DateTime> times) {
    return _preferences.setStringList(
        _timelist, times.map((e) => e.toIso8601String()).toList());
  }

  static List<DateTime>? getTimeData() {
    List<String>? timeList = _preferences.getStringList(_timelist);
    if (timeList == null) return null;
    return timeList.map((e) => DateTime.parse(e)).toList();
  }

  static Future setN(double N) {
    return _preferences.setDouble('N', N);
  }

  static Future setP(double P) {
    return _preferences.setDouble('P', P);
  }

  static Future setK(double K) {
    return _preferences.setDouble('K', K);
  }

  static double getN() {
    return _preferences.getDouble('N')!;
  }

  static double getP() {
    return _preferences.getDouble('P')!;
  }

  static double getK() {
    return _preferences.getDouble('K')!;
  }
}
