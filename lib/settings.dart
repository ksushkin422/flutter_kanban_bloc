
final preferences = MyPreferences();
class MyPreferences {
  String token = '';
  Map<String, dynamic> applicationBaseDioOptions() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'JWT ${preferences.token}'
    };
  }
}