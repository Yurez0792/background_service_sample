// import 'package:shared_preferences/shared_preferences.dart';
//
// class MyPreferences {
//   static const textKey = 'textKey';
//
//
//   static MyPreferences? _myPreferences;
//   SharedPreferences? _preferences;
//
//   Future<SharedPreferences> getPreferences() async {
//     _preferences ??= await SharedPreferences.getInstance();
//
//     return _preferences!;
//   }
//
//   MyPreferences._();
//
//   static MyPreferences getInstance() {
//     _myPreferences ??= MyPreferences._();
//
//     return _myPreferences!;
//   }
//
//   Future<void> setString(final String key, final String value) async {
//     final preferences = await getPreferences();
//     await preferences.setString(key, value);
//   }
//
//   Future<String> getString(final String key) async {
//     final preferences = await getPreferences();
//     return preferences.getString(key) ?? '';
//   }
// }
